import 'dart:io';

import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/catalog/catalog.dart';
import 'package:deeplink_x_example/catalog/detail_page.dart';
import 'package:deeplink_x_example/widgets/fallback_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final allSpecs = [...catalogApps, ...catalogStores];

  group('catalog data', () {
    test('covers every supported app and store exactly once', () {
      expect(catalogApps, hasLength(23));
      expect(catalogStores, hasLength(7));
      final ids = allSpecs.map((final spec) => spec.id).toList();
      expect(ids.toSet(), hasLength(ids.length));
    });

    test('every referenced logo asset is bundled', () {
      for (final spec in allSpecs) {
        expect(File(spec.assetName).existsSync(), isTrue, reason: spec.assetName);
      }
    });

    test('every action builds from its default values under both fallback flags', () {
      for (final spec in allSpecs) {
        for (final action in spec.actions) {
          final values = ActionValues({for (final field in action.fields) field.key: field.defaultValue});
          expect(action.validate?.call(values), isNull, reason: '${spec.id} ${action.title}');
          for (final fallbackToStore in const [false, true]) {
            switch (action.runner) {
              case final OpenAppRunner runner:
                final app = runner.build(fallbackToStore: fallbackToStore);
                if (spec.category != CatalogCategory.stores) {
                  expect(
                    (app as DownloadableApp).fallbackToStore,
                    fallbackToStore,
                    reason: '${spec.id} ${action.title}',
                  );
                }
              case final AppActionRunner runner:
                final built = runner.build(values, fallbackToStore: fallbackToStore);
                if (spec.category != CatalogCategory.stores && built is DownloadableApp) {
                  final downloadable = built as DownloadableApp;
                  expect(downloadable.fallbackToStore, fallbackToStore, reason: '${spec.id} ${action.title}');
                }
            }
          }
        }
      }
    });
  });

  group('detail page', () {
    testWidgets('launches an open-app action and honors the fallback toggle', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      final spec = catalogApps.firstWhere((final spec) => spec.id == 'telegram');
      await tester.pumpWidget(MaterialApp(home: DetailPage(spec: spec, deeplinkX: deeplinkX)));

      await tester.pump();
      expect(find.text('Not installed'), findsOneWidget);

      await tester.tap(find.text('Open Telegram'));
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedApps.single, isA<Telegram>());
      expect((deeplinkX.launchedApps.single as Telegram).fallbackToStore, isTrue);
      expect(find.textContaining('fallback disabled'), findsNothing);

      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      await tester.tap(find.descendant(of: find.byType(FallbackPill), matching: find.byType(GestureDetector)));
      await tester.pump();
      await tester.tap(find.text('Open Telegram'));
      await tester.pumpAndSettle();
      expect((deeplinkX.launchedApps.last as Telegram).fallbackToStore, isFalse);
      expect(find.textContaining('fallback disabled'), findsOneWidget);
    });

    testWidgets('launches a field-backed action with the entered values', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      final spec = catalogApps.firstWhere((final spec) => spec.id == 'instagram');
      await tester.pumpWidget(MaterialApp(home: DetailPage(spec: spec, deeplinkX: deeplinkX)));

      await tester.ensureVisible(find.text('Open profile').last);
      await tester.tap(find.text('Open profile').last);
      await tester.pumpAndSettle();
      final action = deeplinkX.launchedActions.single as InstagramOpenProfileAction;
      expect(action.username, 'instagram');
      expect(action.fallbackToStore, isTrue);
    });

    testWidgets('blocks a launch when a required field is empty', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      final spec = catalogApps.firstWhere((final spec) => spec.id == 'instagram');
      await tester.pumpWidget(MaterialApp(home: DetailPage(spec: spec, deeplinkX: deeplinkX)));

      await tester.enterText(find.byType(TextField), '');
      await tester.ensureVisible(find.text('Open profile').last);
      await tester.tap(find.text('Open profile').last);
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedActions, isEmpty);
      expect(find.text('Enter username.'), findsOneWidget);
    });

    testWidgets('rejects an out-of-range coordinate', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      final spec = catalogApps.firstWhere((final spec) => spec.id == 'google_maps');
      await tester.pumpWidget(MaterialApp(home: DetailPage(spec: spec, deeplinkX: deeplinkX)));

      await tester.enterText(find.widgetWithText(TextField, '37.7749').first, '120');
      await tester.ensureVisible(find.text('View location'));
      await tester.tap(find.text('View location'));
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedActions, isEmpty);
      expect(find.text('Latitude must be between -90 and 90.'), findsOneWidget);
    });
  });
}

class _FakeDeeplinkX extends DeeplinkX {
  _FakeDeeplinkX() : super(platformType: PlatformType.android);

  final List<App> launchedApps = [];
  final List<AppAction> launchedActions = [];

  @override
  Future<bool> isAppInstalled(final App app) async => false;

  @override
  Future<bool> launchApp(final App app, {final bool disableFallback = false}) async {
    launchedApps.add(app);
    return true;
  }

  @override
  Future<bool> launchAction(final AppAction action, {final bool disableFallback = false}) async {
    launchedActions.add(action);
    return true;
  }
}

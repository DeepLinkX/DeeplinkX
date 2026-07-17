import 'dart:async';

import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/home.dart';
import 'package:deeplink_x_example/use_cases/about_support_page.dart';
import 'package:deeplink_x_example/use_cases/fallback_playground_page.dart';
import 'package:deeplink_x_example/use_cases/installed_apps_page.dart';
import 'package:deeplink_x_example/use_cases/map_selector_page.dart';
import 'package:deeplink_x_example/use_cases/meeting_community_page.dart';
import 'package:deeplink_x_example/use_cases/promoted_app_page.dart';
import 'package:deeplink_x_example/use_cases/rate_review_page.dart';
import 'package:deeplink_x_example/use_cases/share_message_page.dart';
import 'package:deeplink_x_example/use_cases/update_app_page.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('home use cases', () {
    testWidgets('filter chips reveal every section', (final tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.text('View all 9'), findsOneWidget);
      expect(find.text('View all 22'), findsOneWidget);
      expect(find.text('View all 7'), findsOneWidget);

      const titles = [
        'Update App',
        'About & Support',
        'Map Selector',
        'Rate & Review',
        'Share & Message',
        'Installed Apps',
        'Meeting & Community',
        'Promoted App CTA',
        'Fallback Playground',
      ];
      await tester.tap(find.byKey(const ValueKey('filter-use-cases')));
      await tester.pump();
      for (final title in titles) {
        expect(find.text(title), findsOneWidget);
      }

      await tester.tap(find.byKey(const ValueKey('filter-apps')));
      await tester.pump();
      expect(find.byType(AppTile), findsNWidgets(22));

      await tester.tap(find.byKey(const ValueKey('filter-stores')));
      await tester.pump();
      expect(find.byType(AppTile), findsNWidgets(7));

      await tester.tap(find.byKey(const ValueKey('filter-stores')));
      await tester.pump();
      expect(find.text('View all 9'), findsOneWidget);
      expect(find.byType(AppTile), findsNWidgets(12));
    });
  });

  group('selector', () {
    testWidgets('keeps Automatic first and prevents duplicate launches', (final tester) async {
      final deeplinkX = _FakeDeeplinkX(installationResolver: (final app) => app is PlayStore);
      final completer = Completer<bool>();
      var automaticCalls = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (final context) => FilledButton(
                    onPressed:
                        () => showLaunchSelector<PlayStoreOpenAppPageAction>(
                          context: context,
                          title: 'Choose store',
                          automaticSubtitle: 'Automatic store selection.',
                          deeplinkX: deeplinkX,
                          options: [
                            LaunchOption(
                              id: 'play',
                              title: 'Google Play',
                              app: PlayStore.openAppPage(packageName: 'com.example.app'),
                              fallbackLabel: 'Browser listing',
                              assetName: 'assets/google_play.png',
                            ),
                          ],
                          onAutomatic: () {
                            automaticCalls++;
                            return completer.future;
                          },
                          onSelected: (final app) async => true,
                        ),
                    child: const Text('Open'),
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(
        tester.getTopLeft(find.byKey(const ValueKey('selector-automatic'))).dy,
        lessThan(tester.getTopLeft(find.byKey(const ValueKey('selector-play'))).dy),
      );
      expect(find.text('Installed'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('selector-automatic')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('selector-automatic')), warnIfMissed: false);
      expect(automaticCalls, 1);

      completer.complete(true);
      await tester.pumpAndSettle();
      expect(find.text('Launch request succeeded.'), findsOneWidget);
    });

    testWidgets('shows fallback status and launches a manual option', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      PlayStoreOpenAppPageAction? selected;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (final context) => FilledButton(
                    onPressed:
                        () => showLaunchSelector<PlayStoreOpenAppPageAction>(
                          context: context,
                          title: 'Choose store',
                          automaticSubtitle: 'Automatic store selection.',
                          deeplinkX: deeplinkX,
                          options: [
                            LaunchOption(
                              id: 'play',
                              title: 'Google Play',
                              app: PlayStore.openAppPage(packageName: 'com.example.app'),
                              fallbackLabel: 'Browser listing',
                              assetName: 'assets/google_play.png',
                            ),
                          ],
                          onAutomatic: () async => true,
                          onSelected: (final app) async {
                            selected = app;
                            return true;
                          },
                        ),
                    child: const Text('Open manual selector'),
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open manual selector'));
      await tester.pumpAndSettle();
      expect(find.text('Not installed • Browser listing'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('selector-play')));
      await tester.pumpAndSettle();
      expect(selected, isNotNull);
    });
  });

  group('requested use cases', () {
    testWidgets('update selector redirects with Telegram store metadata', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      await _pumpPage(tester, UpdateAppPage(deeplinkX: deeplinkX));

      await tester.tap(find.byKey(const ValueKey('open-store-selector')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('selector-automatic')));
      await tester.pumpAndSettle();

      expect(deeplinkX.redirectedStoreActions.single, hasLength(5));
      expect(deeplinkX.redirectedStoreActions.single.first, isA<PlayStoreOpenAppPageAction>());
    });

    testWidgets('about page launches fixed public profile actions', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      await _pumpPage(tester, AboutSupportPage(deeplinkX: deeplinkX));

      await tester.tap(find.byKey(const ValueKey('about-telegram')));
      await tester.pumpAndSettle();

      final action = deeplinkX.launchedActions.single as TelegramOpenProfileAction;
      expect(action.username, 'durov');
      expect(action.fallbackToStore, isFalse);
    });

    testWidgets('map selector validates coordinates and passes all providers in order', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      await _pumpPage(tester, MapSelectorPage(deeplinkX: deeplinkX));

      await tester.enterText(find.byKey(const ValueKey('map-latitude')), '120');
      await tester.tap(find.byKey(const ValueKey('open-map-selector')));
      await tester.pump();
      expect(find.textContaining('Latitude must be'), findsOneWidget);
      expect(deeplinkX.mapDirectionsActions, isEmpty);

      await tester.enterText(find.byKey(const ValueKey('map-latitude')), '35.6892');
      await tester.tap(find.byKey(const ValueKey('open-map-selector')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('selector-automatic')));
      await tester.pumpAndSettle();

      final actions = deeplinkX.mapDirectionsActions.single;
      expect(actions, hasLength(10));
      expect(actions.first, isA<GoogleMapsDirectionsWithCoordsAction>());
      expect(actions[6], isA<SygicDirectionsWithCoordsAction>());
      expect(actions.last, isA<YandexMapsDirectionsWithCoordsAction>());
    });

    testWidgets('rating selector uses Android listing alternatives', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      await _pumpPage(tester, RateReviewPage(deeplinkX: deeplinkX));

      await tester.tap(find.byKey(const ValueKey('open-rating-selector')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('selector-automatic')));
      await tester.pumpAndSettle();

      final stores = deeplinkX.redirectedStoreActions.single;
      expect(stores, hasLength(2));
      expect(stores.first, isA<PlayStoreOpenAppPageAction>());
      expect(stores.last, isA<HuaweiAppGalleryStoreOpenAppPageAction>());
    });

    testWidgets('share page validates and creates WhatsApp and Telegram actions', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      await _pumpPage(tester, ShareMessagePage(deeplinkX: deeplinkX));

      await tester.enterText(find.byKey(const ValueKey('whatsapp-share-text')), '');
      await tester.tap(find.byKey(const ValueKey('share-whatsapp')));
      await tester.pump();
      expect(find.text('Enter text to share.'), findsOneWidget);

      await tester.enterText(find.byKey(const ValueKey('whatsapp-share-text')), 'Share me');
      await tester.tap(find.byKey(const ValueKey('share-whatsapp')));
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedActions.single, isA<WhatsAppShareTextAction>());

      await tester.ensureVisible(find.byKey(const ValueKey('message-telegram')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('message-telegram')));
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedActions.last, isA<TelegramSendMessageAction>());
    });

    testWidgets('installed-app page reports states and launches only installed entries', (final tester) async {
      final deeplinkX = _FakeDeeplinkX(installationResolver: (final app) => app is Telegram);
      await _pumpPage(tester, InstalledAppsPage(deeplinkX: deeplinkX));
      await tester.pump();

      expect(find.text('Installed'), findsOneWidget);
      expect(find.text('Not installed'), findsWidgets);

      await tester.tap(find.byKey(const ValueKey('installed-Telegram')));
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedApps.single, isA<Telegram>());
      expect(deeplinkX.launchAppDisableFallback.single, isTrue);
    });

    testWidgets('meeting page validates then creates Zoom and Slack actions', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      await _pumpPage(tester, MeetingCommunityPage(deeplinkX: deeplinkX));

      await tester.tap(find.byKey(const ValueKey('join-zoom')));
      await tester.pump();
      expect(find.text('Enter a Zoom meeting ID.'), findsOneWidget);

      await tester.enterText(find.byKey(const ValueKey('zoom-meeting-id')), '0000000000');
      await tester.tap(find.byKey(const ValueKey('join-zoom')));
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedActions.single, isA<ZoomJoinMeetingAction>());

      await tester.ensureVisible(find.byKey(const ValueKey('open-slack')));
      await tester.enterText(find.byKey(const ValueKey('slack-team-id')), 'T00000000');
      await tester.enterText(find.byKey(const ValueKey('slack-channel-id')), 'C00000000');
      await tester.tap(find.byKey(const ValueKey('open-slack')));
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedActions.last, isA<SlackOpenChannelAction>());
    });

    testWidgets('promoted CTA keeps platform tracking actions together', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      await _pumpPage(tester, PromotedAppPage(deeplinkX: deeplinkX));

      await tester.tap(find.byKey(const ValueKey('open-promoted-app')));
      await tester.pumpAndSettle();

      final stores = deeplinkX.redirectedStoreActions.single;
      final play = stores.first as PlayStoreOpenAppPageAction;
      final ios = stores.last as IOSAppStoreOpenAppPageAction;
      expect(play.referrer, contains('utm_campaign=summer_launch'));
      expect(ios.campaignToken, 'deeplink_x_example');
      expect(ios.uniqueOrigin, 'use_cases');
    });

    testWidgets('fallback playground applies the selected policy without inferring a stage', (final tester) async {
      final deeplinkX = _FakeDeeplinkX();
      await _pumpPage(tester, FallbackPlaygroundPage(deeplinkX: deeplinkX));
      await tester.pump();

      await tester.tap(find.byKey(const ValueKey('launch-fallback-preset')));
      await tester.pumpAndSettle();
      expect(deeplinkX.launchedActions.single, isA<TelegramOpenProfileAction>());
      expect(deeplinkX.launchActionDisableFallback.single, isFalse);
      expect((deeplinkX.launchedActions.single as TelegramOpenProfileAction).fallbackToStore, isFalse);
      expect(find.text('Success'), findsOneWidget);

      await tester.tap(
        find.descendant(of: find.byKey(const ValueKey('fallback-policy')), matching: find.text('Store then web')),
      );
      await tester.pump();
      deeplinkX.result = false;
      await tester.tap(find.byKey(const ValueKey('launch-fallback-preset')));
      await tester.pumpAndSettle();

      final storeAction = deeplinkX.launchedActions.last as TelegramOpenProfileAction;
      expect(storeAction.fallbackToStore, isTrue);
      expect(deeplinkX.launchActionDisableFallback.last, isFalse);
      expect(find.text('Failure'), findsOneWidget);
    });
  });
}

Future<void> _pumpPage(final WidgetTester tester, final Widget page) async {
  await tester.pumpWidget(MaterialApp(home: page));
  await tester.pump();
}

class _FakeDeeplinkX extends DeeplinkX {
  _FakeDeeplinkX({this.installationResolver, final PlatformType platformType = PlatformType.android})
    : super(platformType: platformType);

  bool result = true;
  final bool Function(App app)? installationResolver;
  final List<AppAction> launchedActions = [];
  final List<bool> launchActionDisableFallback = [];
  final List<App> launchedApps = [];
  final List<bool> launchAppDisableFallback = [];
  final List<List<StoreOpenAppPageAction>> redirectedStoreActions = [];
  final List<List<MapDirectionsWithCoordsAction>> mapDirectionsActions = [];

  @override
  Future<bool> isAppInstalled(final App app) async => installationResolver?.call(app) ?? false;

  @override
  Future<bool> launchAction(final AppAction action, {final bool disableFallback = false}) async {
    launchedActions.add(action);
    launchActionDisableFallback.add(disableFallback);
    return result;
  }

  @override
  Future<bool> launchApp(final App app, {final bool disableFallback = false}) async {
    launchedApps.add(app);
    launchAppDisableFallback.add(disableFallback);
    return result;
  }

  @override
  Future<bool> redirectToStore({required final List<StoreOpenAppPageAction> storeActions}) async {
    redirectedStoreActions.add(storeActions);
    return result;
  }

  @override
  Future<bool> launchMapDirectionsWithCoordsAction({
    required final List<MapDirectionsWithCoordsAction> actions,
    final bool disableFallback = false,
  }) async {
    mapDirectionsActions.add(actions);
    return result;
  }
}

import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x/src/utils/launcher_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLauncherUtil extends Mock implements LauncherUtil {}

class MockApp extends Mock implements App {}

class MockDownloadableApp extends Mock implements DownloadableApp {}

class MockIntentAction extends Mock implements IntentAppLinkAction {}

class MockUniversalLinkAction extends Mock implements UniversalLinkAppAction {}

class MockAppLinkAction extends Mock implements AppLinkAppAction {}

class MockFallbackAction extends Mock implements AppAction, Fallbackable {}

class MockDownloadableAction extends Mock implements AppAction, DownloadableApp {}

class MockStoreAction extends Mock implements StoreOpenAppPageAction, UniversalLinkAppAction {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('fallback://'));
    registerFallbackValue(const AndroidIntentOption(action: 'test'));
    registerFallbackValue(MockApp());
    registerFallbackValue(MockStoreAction());
  });

  group('isAppInstalled', () {
    test('delegates to launcher util', () async {
      final launcher = MockLauncherUtil();
      final app = MockApp();
      when(() => launcher.isAppInstalled(app)).thenAnswer((final _) async => true);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.isAppInstalled(app);

      expect(result, isTrue);
      verify(() => launcher.isAppInstalled(app)).called(1);
    });
  });

  group('launchApp', () {
    test('calls launcher when installed', () async {
      final launcher = MockLauncherUtil();
      final app = MockApp();
      when(() => launcher.isAppInstalled(app)).thenAnswer((final _) async => true);
      when(() => launcher.launchApp(app)).thenAnswer((final _) async => true);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchApp(app);

      expect(result, isTrue);
      verify(() => launcher.launchApp(app)).called(1);
    });

    test('redirects to store when not installed', () async {
      final launcher = MockLauncherUtil();
      final app = MockDownloadableApp();
      when(() => launcher.isAppInstalled(app)).thenAnswer((final _) async => false);
      final store = MockStoreAction();
      final storeLink = Uri.parse('https://store');
      when(() => app.fallbackToStore).thenReturn(true);
      when(() => app.storeActions).thenReturn([store]);
      when(() => store.platform).thenReturn(PlatformType.android);
      when(() => store.universalLink).thenReturn(storeLink);
      when(() => launcher.isAppInstalled(store)).thenAnswer((final _) async => true);
      when(() => launcher.launchUrl(storeLink)).thenAnswer((final _) async => true);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchApp(app);

      expect(result, isTrue);
      verify(() => launcher.launchUrl(storeLink)).called(1);
      verifyNever(() => launcher.launchApp(app));
    });

    test('returns false when fallback disabled', () async {
      final launcher = MockLauncherUtil();
      final app = MockApp();
      when(() => launcher.isAppInstalled(app)).thenAnswer((final _) async => false);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchApp(app, disableFallback: true);

      expect(result, isFalse);
      verifyNever(() => launcher.launchUrl(any()));
    });
  });

  group('launchAction', () {
    test('launches intent action', () async {
      final launcher = MockLauncherUtil();
      final action = MockIntentAction();
      const options = AndroidIntentOption(action: 'action');
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => true);
      when(() => launcher.launchIntent(options)).thenAnswer((final _) async => true);
      when(() => action.androidIntentOptions).thenReturn(options);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => launcher.launchIntent(options)).called(1);
    });

    test('falls back to app link when intent fails', () async {
      final launcher = MockLauncherUtil();
      final action = MockIntentAction();
      const options = AndroidIntentOption(action: 'action');
      final appLink = Uri.parse('scheme://path');
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => true);
      when(() => launcher.launchIntent(options)).thenAnswer((final _) async => false);
      when(() => launcher.launchUrl(appLink)).thenAnswer((final _) async => true);
      when(() => action.androidIntentOptions).thenReturn(options);
      when(() => action.appLink).thenReturn(appLink);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => launcher.launchIntent(options)).called(1);
      verify(() => launcher.launchUrl(appLink)).called(1);
    });

    test('uses app link on iOS platform', () async {
      final launcher = MockLauncherUtil();
      final action = MockIntentAction();
      const options = AndroidIntentOption(action: 'action');
      final appLink = Uri.parse('scheme://path');
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => true);
      when(() => launcher.launchIntent(options)).thenAnswer((final _) async => false);
      when(() => launcher.launchUrl(appLink)).thenAnswer((final _) async => true);
      when(() => action.androidIntentOptions).thenReturn(options);
      when(() => action.appLink).thenReturn(appLink);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.ios,
      );

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => launcher.launchIntent(options)).called(1);
      verify(() => launcher.launchUrl(appLink)).called(1);
    });

    test('launches universal link action', () async {
      final launcher = MockLauncherUtil();
      final action = MockUniversalLinkAction();
      final link = Uri.parse('https://example.com');
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => true);
      when(() => launcher.launchUrl(link)).thenAnswer((final _) async => true);
      when(() => action.universalLink).thenReturn(link);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => launcher.launchUrl(link)).called(1);
    });

    test('launches app link action', () async {
      final launcher = MockLauncherUtil();
      final action = MockAppLinkAction();
      final link = Uri.parse('scheme://app');
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => true);
      when(() => launcher.launchUrl(link)).thenAnswer((final _) async => true);
      when(() => action.appLink).thenReturn(link);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => launcher.launchUrl(link)).called(1);
    });

    test('falls back to fallback link', () async {
      final launcher = MockLauncherUtil();
      final action = MockFallbackAction();
      final fallback = Uri.parse('https://fallback');
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => false);
      when(() => launcher.launchUrl(fallback)).thenAnswer((final _) async => true);
      when(() => action.fallbackLink).thenReturn(fallback);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => launcher.launchUrl(fallback)).called(1);
    });

    test('falls back to store when enabled', () async {
      final launcher = MockLauncherUtil();
      final action = MockDownloadableAction();
      final store = MockStoreAction();
      final storeLink = Uri.parse('https://store');
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => false);
      when(() => action.fallbackToStore).thenReturn(true);
      when(() => action.storeActions).thenReturn([store]);
      when(() => store.platform).thenReturn(PlatformType.android);
      when(() => store.universalLink).thenReturn(storeLink);
      when(() => launcher.isAppInstalled(store)).thenAnswer((final _) async => true);
      when(() => launcher.launchUrl(storeLink)).thenAnswer((final _) async => true);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => launcher.launchUrl(storeLink)).called(1);
    });

    test('returns false when fallback disabled and not installed', () async {
      final launcher = MockLauncherUtil();
      final action = MockAppLinkAction();
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => false);
      when(() => action.appLink).thenReturn(Uri.parse('scheme://app'));
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchAction(action, disableFallback: true);

      expect(result, isFalse);
      verifyNever(() => launcher.launchUrl(any()));
    });

    test('handles PlatformException and returns false', () async {
      final launcher = MockLauncherUtil();
      final action = MockIntentAction();
      const options = AndroidIntentOption(action: 'action');
      final appLink = Uri.parse('scheme://path');
      when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => true);
      when(() => launcher.launchIntent(options)).thenThrow(PlatformException(code: 'err'));
      when(() => launcher.launchUrl(appLink)).thenAnswer((final _) async => true);
      when(() => action.androidIntentOptions).thenReturn(options);
      when(() => action.appLink).thenReturn(appLink);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.launchAction(action);

      expect(result, isFalse);
    });
  });

  group('redirectToStore', () {
    test('stops at first success', () async {
      final launcher = MockLauncherUtil();
      final first = MockStoreAction();
      final second = MockStoreAction();
      when(() => first.platform).thenReturn(PlatformType.android);
      when(() => second.platform).thenReturn(PlatformType.android);
      final link1 = Uri.parse('https://1');
      final link2 = Uri.parse('https://2');
      when(() => first.universalLink).thenReturn(link1);
      when(() => second.universalLink).thenReturn(link2);
      when(() => launcher.isAppInstalled(any())).thenAnswer((final _) async => true);
      when(() => launcher.launchUrl(link1)).thenAnswer((final _) async => true);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.redirectToStore(storeActions: [first, second]);

      expect(result, isTrue);
      verify(() => launcher.launchUrl(link1)).called(1);
      verifyNever(() => launcher.launchUrl(link2));
    });

    test('tries next store when first fails', () async {
      final launcher = MockLauncherUtil();
      final first = MockStoreAction();
      final second = MockStoreAction();
      when(() => first.platform).thenReturn(PlatformType.android);
      when(() => second.platform).thenReturn(PlatformType.android);
      final link1 = Uri.parse('https://1');
      final link2 = Uri.parse('https://2');
      when(() => first.universalLink).thenReturn(link1);
      when(() => second.universalLink).thenReturn(link2);
      when(() => launcher.isAppInstalled(any())).thenAnswer((final _) async => true);
      when(() => launcher.launchUrl(link1)).thenAnswer((final _) async => false);
      when(() => launcher.launchUrl(link2)).thenAnswer((final _) async => true);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.redirectToStore(storeActions: [first, second]);

      expect(result, isTrue);
      verify(() => launcher.launchUrl(link1)).called(1);
      verify(() => launcher.launchUrl(link2)).called(1);
    });

    test('returns false when no matching store', () async {
      final launcher = MockLauncherUtil();
      final iosStore = MockStoreAction();
      when(() => iosStore.platform).thenReturn(PlatformType.ios);
      final deeplinkX = DeeplinkX(
        launcherUtil: launcher,
        platformType: PlatformType.android,
      );

      final result = await deeplinkX.redirectToStore(storeActions: [iosStore]);

      expect(result, isFalse);
      verifyNever(() => launcher.launchUrl(any()));
    });
  });
}

import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x/src/utils/launcher_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLauncherUtil extends Mock implements LauncherUtil {}

class MockApp extends Mock implements App {}

class MockDownloadableApp extends Mock implements DownloadableApp {}

class MockIntentAction extends Mock implements IntentAppLinkAction {}

class MockFallbackableIntentAction extends Mock implements IntentAppLinkAction, Fallbackable {}

class MockUniversalLinkAction extends Mock implements UniversalLinkAppAction {}

class MockAppLinkAction extends Mock implements AppLinkAppAction {}

class MockFallbackAction extends Mock implements AppAction, Fallbackable {}

class MockDownloadableAction extends Mock implements AppAction, DownloadableApp {}

class MockStoreAction extends Mock implements StoreOpenAppPageAction, UniversalLinkAppAction {}

void main() {
  late DeeplinkX deeplinkX;
  late MockLauncherUtil mockLauncherUtil;

  setUp(() {
    mockLauncherUtil = MockLauncherUtil();
    deeplinkX = DeeplinkX(launcherUtil: mockLauncherUtil, platformType: PlatformType.android);

    when(() => mockLauncherUtil.isAppInstalled(any())).thenAnswer((final _) async => true);
    when(() => mockLauncherUtil.launchApp(any())).thenAnswer((final _) async => true);
    when(() => mockLauncherUtil.launchUrl(any())).thenAnswer((final _) async => true);
    when(() => mockLauncherUtil.launchIntent(any())).thenAnswer((final _) async => true);
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse('fallback://'));
    registerFallbackValue(const AndroidIntentOption(action: 'test'));
    registerFallbackValue(MockApp());
    registerFallbackValue(MockStoreAction());
    registerFallbackValue(PlatformType.android);
  });

  group('isAppInstalled', () {
    test('delegates to launcher util', () async {
      final app = MockApp();

      final result = await deeplinkX.isAppInstalled(app);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.isAppInstalled(app)).called(1);
    });
  });

  group('launchApp', () {
    test('calls launcher when installed', () async {
      final app = MockApp();

      final result = await deeplinkX.launchApp(app);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.isAppInstalled(app)).called(1);
      verify(() => mockLauncherUtil.launchApp(app)).called(1);
    });

    test('redirects to store when not installed when app is downloadable', () async {
      final app = MockDownloadableApp();
      final store = MockStoreAction();
      final storeLink = Uri.parse('https://store');

      when(() => mockLauncherUtil.isAppInstalled(app)).thenAnswer((final _) async => false);

      when(() => app.fallbackToStore).thenReturn(true);
      when(() => app.storeActions).thenReturn([store]);
      when(() => store.platform).thenReturn(PlatformType.android);
      when(() => store.universalLink).thenReturn(storeLink);
      when(() => mockLauncherUtil.launchUrl(storeLink)).thenAnswer((final _) async => true);

      final result = await deeplinkX.launchApp(app);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.isAppInstalled(app)).called(1);
      verify(() => mockLauncherUtil.isAppInstalled(store)).called(1);
      verify(() => mockLauncherUtil.launchUrl(storeLink)).called(1);
      verifyNever(() => mockLauncherUtil.launchApp(app));
      verifyNever(() => mockLauncherUtil.launchUrl(app.website));
    });

    test('opens website when not installed when app is not downloadable', () async {
      final app = MockApp();
      final website = Uri.parse('https://website');

      when(() => mockLauncherUtil.isAppInstalled(app)).thenAnswer((final _) async => false);
      when(() => app.website).thenReturn(website);

      final result = await deeplinkX.launchApp(app);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.isAppInstalled(app)).called(1);
      verify(() => mockLauncherUtil.launchUrl(app.website)).called(1);
      verifyNever(() => mockLauncherUtil.launchApp(app));
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
      final action = MockIntentAction();
      const options = AndroidIntentOption(action: 'action');
      when(() => action.androidIntentOptions).thenReturn(options);

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchIntent(options)).called(1);
    });

    test('falls back to app link when intent fails', () async {
      final action = MockIntentAction();
      const options = AndroidIntentOption(action: 'action');
      final appLink = Uri.parse('scheme://path');
      when(() => mockLauncherUtil.launchIntent(options)).thenAnswer((final _) async => false);
      when(() => action.androidIntentOptions).thenReturn(options);
      when(() => action.appLink).thenReturn(appLink);

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchIntent(options)).called(1);
      verify(() => mockLauncherUtil.launchUrl(appLink)).called(1);
    });

    test('launches universal link action', () async {
      final action = MockUniversalLinkAction();
      final link = Uri.parse('https://example.com');

      when(() => action.universalLink).thenReturn(link);

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchUrl(link)).called(1);
    });

    test('launches app link action', () async {
      final action = MockAppLinkAction();
      final link = Uri.parse('scheme://app');

      when(() => action.appLink).thenReturn(link);

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchUrl(link)).called(1);
    });

    test('falls back to fallback link', () async {
      final action = MockFallbackAction();
      final fallback = Uri.parse('https://fallback');

      when(() => action.fallbackLink).thenReturn(fallback);

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchUrl(fallback)).called(1);
    });

    test('falls back to store when enabled', () async {
      final action = MockDownloadableAction();
      final store = MockStoreAction();
      final storeLink = Uri.parse('https://store');

      when(() => mockLauncherUtil.isAppInstalled(action)).thenAnswer((final _) async => false);
      when(() => mockLauncherUtil.isAppInstalled(store)).thenAnswer((final _) async => true);

      when(() => action.fallbackToStore).thenReturn(true);
      when(() => action.storeActions).thenReturn([store]);

      when(() => store.platform).thenReturn(PlatformType.android);
      when(() => store.universalLink).thenReturn(storeLink);

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchUrl(storeLink)).called(1);
    });

    test('returns false when fallback disabled and not installed', () async {
      final action = MockAppLinkAction();

      when(() => mockLauncherUtil.isAppInstalled(action)).thenAnswer((final _) async => false);
      when(() => action.appLink).thenReturn(Uri.parse('scheme://app'));

      final result = await deeplinkX.launchAction(action, disableFallback: true);

      expect(result, isFalse);
      verifyNever(() => mockLauncherUtil.launchUrl(any()));
    });

    test('handles PlatformException and returns false', () async {
      final action = MockFallbackableIntentAction();
      const options = AndroidIntentOption(action: 'action');
      final fallbackUri = Uri.parse('fallback://');

      when(() => mockLauncherUtil.launchIntent(options)).thenThrow(PlatformException(code: 'err'));

      when(() => action.androidIntentOptions).thenReturn(options);
      when(() => action.fallbackLink).thenReturn(fallbackUri);

      final result = await deeplinkX.launchAction(action);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchUrl(fallbackUri)).called(1);
    });

    test('handles Exception and returns false', () async {
      final action = MockIntentAction();
      const options = AndroidIntentOption(action: 'action');

      when(() => mockLauncherUtil.launchIntent(options)).thenThrow(Exception('err'));

      when(() => action.androidIntentOptions).thenReturn(options);

      final result = await deeplinkX.launchAction(action);

      expect(result, isFalse);
    });

    test('handles some error and returns false', () async {
      final action = MockIntentAction();
      const options = AndroidIntentOption(action: 'action');

      when(() => mockLauncherUtil.launchIntent(options)).thenThrow(UnimplementedError('err'));

      when(() => action.androidIntentOptions).thenReturn(options);

      final result = await deeplinkX.launchAction(action);

      expect(result, isFalse);
    });
  });

  group('redirectToStore', () {
    test('stops at first success', () async {
      final first = MockStoreAction();
      final second = MockStoreAction();
      when(() => first.platform).thenReturn(PlatformType.android);
      when(() => second.platform).thenReturn(PlatformType.android);

      final link1 = Uri.parse('https://1');
      final link2 = Uri.parse('https://2');
      when(() => first.universalLink).thenReturn(link1);
      when(() => second.universalLink).thenReturn(link2);

      final result = await deeplinkX.redirectToStore(storeActions: [first, second]);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchUrl(link1)).called(1);
      verifyNever(() => mockLauncherUtil.launchUrl(link2));
    });

    test('tries next store when first fails', () async {
      final first = MockStoreAction();
      final second = MockStoreAction();
      when(() => first.platform).thenReturn(PlatformType.android);
      when(() => second.platform).thenReturn(PlatformType.android);

      final link1 = Uri.parse('https://1');
      final link2 = Uri.parse('https://2');
      when(() => first.universalLink).thenReturn(link1);
      when(() => second.universalLink).thenReturn(link2);

      when(() => mockLauncherUtil.launchUrl(link1)).thenAnswer((final _) async => false);

      final result = await deeplinkX.redirectToStore(storeActions: [first, second]);

      expect(result, isTrue);
      verify(() => mockLauncherUtil.launchUrl(link1)).called(1);
      verify(() => mockLauncherUtil.launchUrl(link2)).called(1);
    });

    test('returns false when no matching store', () async {
      final iosStore = MockStoreAction();
      when(() => iosStore.platform).thenReturn(PlatformType.ios);

      final result = await deeplinkX.redirectToStore(storeActions: [iosStore]);

      expect(result, isFalse);
      verifyNever(() => mockLauncherUtil.launchUrl(any()));
    });
  });
}

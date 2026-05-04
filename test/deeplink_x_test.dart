import 'package:deeplink_x/deeplink_x.dart'; // Make sure to import the deeplink_x package
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock interfaces
class MockApp extends Mock implements App {}

class MockAppAction extends Mock implements AppAction {}

class MockDownloadableApp extends Mock implements DownloadableApp {}

class MockStoreApp extends Mock implements StoreApp {}

class MockStoreOpenAppPageAction extends Mock implements StoreOpenAppPageAction {}

class MockAppLinkAppAction extends Mock implements AppLinkAppAction {}

class MockFallbackable extends Mock implements Fallbackable {}

class MockUniversalLinkAppAction extends Mock implements UniversalLinkAppAction {}

class MockIntentAppLinkAction extends Mock implements IntentAppLinkAction {}

class MockMapAppAction extends Mock implements MapAppAction {}

class MockMapViewAction extends Mock implements MapViewAction {}

class MockMapSearchAction extends Mock implements MapSearchAction {}

class MockMapDirectionsAction extends Mock implements MapDirectionsAction {}

class MockMapDirectionsWithCoordsAction extends Mock implements MapDirectionsWithCoordsAction {}

class MockDeeplinkX extends Mock implements DeeplinkX {}

// Tests APIs exposed correctly
void main() {
  late MockDeeplinkX deeplinkX;

  setUp(() {
    deeplinkX = MockDeeplinkX();

    when(() => deeplinkX.launchAction(any())).thenAnswer((final _) async => true);
    when(() => deeplinkX.isAppInstalled(any())).thenAnswer((final _) async => true);
    when(() => deeplinkX.launchApp(any())).thenAnswer((final _) async => true);
  });

  setUpAll(() {
    registerFallbackValue(MockAppAction());
  });

  group('Exposed Api Access Check:', () {
    group('Apps:', () {
      test('Instagram', () {
        final action = Instagram.open();
        expect(action, isA<App>());
      });

      test('Telegram', () {
        final action = Telegram.open();
        expect(action, isA<App>());
      });

      test('WhatsApp', () {
        final action = WhatsApp.open();
        expect(action, isA<App>());
      });

      test('LinkedIn', () {
        final action = LinkedIn.open();
        expect(action, isA<App>());
      });

      test('Facebook', () {
        final action = Facebook.open();
        expect(action, isA<App>());
      });

      test('Youtube', () {
        final action = YouTube.open();
        expect(action, isA<App>());
      });

      test('Twitter', () {
        final action = Twitter.open();
        expect(action, isA<App>());
      });

      test('TikTok', () {
        final action = TikTok.open();
        expect(action, isA<App>());
      });

      test('Zoom', () {
        final action = Zoom.open();
        expect(action, isA<App>());
      });

      test('Slack', () {
        final action = Slack.open();
        expect(action, isA<App>());
      });

      test('GoogleMaps', () {
        final action = GoogleMaps.open();
        expect(action, isA<App>());
      });

      test('Waze', () {
        final action = Waze.open();
        expect(action, isA<App>());
      });

      test('Apple Maps', () {
        final action = AppleMaps.open();
        expect(action, isA<App>());
      });

      test('Sygic', () {
        final action = Sygic.open();
        expect(action, isA<App>());
      });

      test('Pinterest', () {
        final action = Pinterest.open();
        expect(action, isA<App>());
      });

      test('IOSAppStore', () {
        final action = IOSAppStore.open();
        expect(action, isA<App>());
      });

      test('PlayStore', () {
        final action = PlayStore.open();
        expect(action, isA<App>());
      });

      test('HuaweiAppGalleryStore', () {
        final action = HuaweiAppGalleryStore.openAppPage(
          packageName: 'packageName',
          appId: 'appId',
        );
        expect(action, isA<App>());
      });

      test('CafeBazaarStore', () {
        final action = CafeBazaarStore.open();
        expect(action, isA<App>());
      });

      test('MyketStore', () {
        final action = MyketStore.open();
        expect(action, isA<App>());
      });

      test('MacAppStore', () {
        final action = MacAppStore.open();
        expect(action, isA<App>());
      });

      test('MicrosoftStore', () {
        final action = MicrosoftStore.open();
        expect(action, isA<App>());
      });
    });

    group('Enums:', () {
      test('PlatformType', () {
        const platform = PlatformType.android;
        expect(platform, isA<PlatformType>());
      });
    });

    group('Models:', () {
      test('Coordinate', () {
        const coordinate = Coordinate(latitude: 1, longitude: 2);
        expect(coordinate, isA<Coordinate>());
      });

      test('AndroidIntentOption', () {
        const androidIntentOption = AndroidIntentOption(
          action: 'android.intent.action.VIEW',
          package: 'com.test.app',
          data: '',
        );
        expect(androidIntentOption, isA<AndroidIntentOption>());
      });
    });

    group('Public methods:', () {
      test('launchAction', () async {
        final result = await deeplinkX.launchAction(MockAppAction());
        expect(result, true);
      });

      test('isAppInstalled', () async {
        final result = await deeplinkX.isAppInstalled(MockAppAction());
        expect(result, true);
      });

      test('launchApp', () async {
        when(() => deeplinkX.launchApp(any())).thenAnswer((final _) async => true);
        final result = await deeplinkX.launchApp(MockAppAction());
        expect(result, true);
      });

      test('redirectToStore', () async {
        when(
          () => deeplinkX.redirectToStore(
            storeActions: any(named: 'storeActions'),
          ),
        ).thenAnswer((final _) async => true);
        final result = await deeplinkX.redirectToStore(storeActions: [MockStoreOpenAppPageAction()]);
        expect(result, true);
      });

      test('launchMapViewAction', () async {
        final actions = <MapViewAction>[];
        when(() => deeplinkX.launchMapViewAction(actions: actions)).thenAnswer((final _) async => true);

        final result = await deeplinkX.launchMapViewAction(actions: actions);

        expect(result, true);
      });

      test('launchMapSearchAction', () async {
        final actions = <MapSearchAction>[];
        when(() => deeplinkX.launchMapSearchAction(actions: actions)).thenAnswer((final _) async => true);

        final result = await deeplinkX.launchMapSearchAction(actions: actions);

        expect(result, true);
      });

      test('launchMapDirectionsAction', () async {
        final actions = <MapDirectionsAction>[];
        when(() => deeplinkX.launchMapDirectionsAction(actions: actions)).thenAnswer((final _) async => true);

        final result = await deeplinkX.launchMapDirectionsAction(actions: actions);

        expect(result, true);
      });

      test('launchMapDirectionsWithCoordsAction', () async {
        final actions = <MapDirectionsWithCoordsAction>[];
        when(() => deeplinkX.launchMapDirectionsWithCoordsAction(actions: actions)).thenAnswer((final _) async => true);

        final result = await deeplinkX.launchMapDirectionsWithCoordsAction(actions: actions);

        expect(result, true);
      });
    });

    group('Interfaces:', () {
      test('App', () {
        final mock = MockApp();
        when(() => mock.customScheme).thenReturn('test');
        when(() => mock.androidPackageName).thenReturn('com.test.app');
        when(() => mock.website).thenReturn(Uri.parse('https://test.com'));
        when(() => mock.macosBundleIdentifier).thenReturn('com.test.app');

        when(() => mock.supportedPlatforms).thenReturn([
          PlatformType.android,
          PlatformType.ios,
          PlatformType.web,
        ]);

        expect(mock.customScheme, 'test');
        expect(mock.androidPackageName, 'com.test.app');
        expect(mock.website.toString(), 'https://test.com');
        expect(mock.macosBundleIdentifier, 'com.test.app');
        expect(mock.supportedPlatforms, contains(PlatformType.android));
        expect(mock.supportedPlatforms, contains(PlatformType.ios));
        expect(mock.supportedPlatforms, contains(PlatformType.web));
        expect(mock.supportedPlatforms.length, 3);
      });

      test('AppAction', () {
        final mock = MockAppAction();
        expect(mock, isA<AppAction>());
      });

      test('DownloadableApp', () {
        final mock = MockDownloadableApp();
        when(() => mock.fallbackToStore).thenReturn(true);
        when(() => mock.storeActions).thenReturn([]);

        expect(mock.fallbackToStore, true);
        expect(mock.storeActions, isEmpty);
      });

      test('StoreApp', () {
        final mock = MockStoreApp();
        when(() => mock.platform).thenReturn(PlatformType.android);

        expect(mock.platform, PlatformType.android);
      });

      test('AppLinkAppAction', () {
        final mock = MockAppLinkAppAction();
        when(() => mock.appLink).thenReturn(Uri.parse('test://test'));

        expect(mock.appLink.toString(), 'test://test');
      });

      test('MapAppAction', () {
        final mock = MockMapAppAction();
        expect(mock, isA<MapAppAction>());
      });

      test('MapViewAction', () {
        final mock = MockMapViewAction();
        const coordinate = Coordinate(latitude: 1, longitude: 2);
        when(() => mock.coordinate).thenReturn(coordinate);

        expect(mock, isA<MapViewAction>());
        expect(mock.coordinate, coordinate);
      });

      test('MapSearchAction', () {
        final mock = MockMapSearchAction();
        when(() => mock.query).thenReturn('Central Park');

        expect(mock, isA<MapSearchAction>());
        expect(mock.query, 'Central Park');
      });

      test('MapDirectionsAction', () {
        final mock = MockMapDirectionsAction();
        when(() => mock.destination).thenReturn('Central Park');

        expect(mock, isA<MapDirectionsAction>());
        expect(mock.destination, 'Central Park');
      });

      test('MapDirectionsWithCoordsAction', () {
        final mock = MockMapDirectionsWithCoordsAction();
        const destination = Coordinate(latitude: 1, longitude: 2);
        when(() => mock.destination).thenReturn(destination);

        expect(mock, isA<MapDirectionsWithCoordsAction>());
        expect(mock.destination, destination);
      });

      test('Fallbackable', () {
        final mock = MockFallbackable();
        when(() => mock.fallbackLink).thenReturn(Uri.parse('https://test.com'));

        expect(mock.fallbackLink.toString(), 'https://test.com');
      });

      test('UniversalLinkAppAction', () {
        final mock = MockUniversalLinkAppAction();
        when(() => mock.universalLink).thenReturn(Uri.parse('https://test.com/universal'));

        expect(mock.universalLink.toString(), 'https://test.com/universal');
      });

      test('IntentAppLinkAction', () {
        final mock = MockIntentAppLinkAction();
        final androidIntentOptions = AndroidIntentOption(
          action: 'android.intent.action.VIEW',
          package: 'com.test.app',
          data: Uri.parse('test://test').toString(),
        );
        when(() => mock.androidIntentOptions).thenReturn(androidIntentOptions);
        when(() => mock.appLink).thenReturn(Uri.parse('test://test'));

        expect(mock.androidIntentOptions.action, 'android.intent.action.VIEW');
        expect(mock.androidIntentOptions.package, 'com.test.app');
        expect(mock.androidIntentOptions.data.toString(), 'test://test');
        expect(mock.appLink.toString(), 'test://test');
      });
    });
  });
}

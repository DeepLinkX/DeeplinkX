import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/air_navigation_pro.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Air Navigation Pro Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = AirNavigationPro.open();

      expect(action.customScheme, 'airnavpro');
      expect(action.androidPackageName, 'com.xample.airnavigation');
      expect(action.website.toString(), 'https://airnavigation.aero/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = AirNavigationPro.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = AirNavigationPro().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.xample.airnavigation');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '301046057');
      expect(iosStoreAction.appName, 'air-navigation-pro');
    });

    test('view action builds direct-to link, Android intent, and fallback', () {
      final action = AirNavigationPro.view(
        coordinate: const Coordinate(latitude: 46.2044, longitude: 6.1432),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, const Coordinate(latitude: 46.2044, longitude: 6.1432));
      expect(
        action.appLink.toString(),
        'airnavpro://direct-to?coordinates=wgs84-decimal&location=46.2044_6.1432%2C0.0',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'https://airnavigation.aero/direct-to?coordinates=wgs84-decimal&location=46.2044_6.1432%2C0.0',
      );
      expect(action.androidIntentOptions.package, 'com.xample.airnavigation');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(
        action.fallbackLink.toString(),
        'https://airnavigation.aero/direct-to?coordinates=wgs84-decimal&location=46.2044_6.1432%2C0.0',
      );
    });

    test('directTo action builds direct-to route', () {
      final action = AirNavigationPro.directTo(
        destination: const Coordinate(latitude: 46.2381, longitude: 6.1090),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, const Coordinate(latitude: 46.2381, longitude: 6.1090));
      expect(
        action.appLink.toString(),
        'airnavpro://direct-to?coordinates=wgs84-decimal&location=46.2381_6.109%2C0.0',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'https://airnavigation.aero/direct-to?coordinates=wgs84-decimal&location=46.2381_6.109%2C0.0',
      );
      expect(action.androidIntentOptions.package, 'com.xample.airnavigation');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(
        action.fallbackLink.toString(),
        'https://airnavigation.aero/direct-to?coordinates=wgs84-decimal&location=46.2381_6.109%2C0.0',
      );
    });

    test('directionsWithCoords action uses direct-to route', () {
      final action = AirNavigationPro.directionsWithCoords(
        destination: const Coordinate(latitude: 46.2381, longitude: 6.1090),
      );

      expect(action, isA<AirNavigationProDirectToAction>());
      expect(action.destination, const Coordinate(latitude: 46.2381, longitude: 6.1090));
      expect(
        action.appLink.toString(),
        'airnavpro://direct-to?coordinates=wgs84-decimal&location=46.2381_6.109%2C0.0',
      );
    });

    test('actions keep fallback flag', () {
      final viewAction = AirNavigationPro.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final directToAction = AirNavigationPro.directTo(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directToAction.fallbackToStore, true);

      final directionsAction = AirNavigationPro.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsAction.fallbackToStore, true);
    });
  });
}

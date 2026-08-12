import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/sygic_truck.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sygic Truck Actions', () {
    const destination = Coordinate(latitude: 48.1486, longitude: 17.1077);

    test('open action exposes metadata and store actions', () {
      final action = SygicTruck.open();

      expect(action.customScheme, 'com.sygic.aura');
      expect(action.androidPackageName, 'com.sygic.truck');
      expect(action.website.toString(), 'https://www.sygic.com/truck-gps-navigation');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = SygicTruck().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.sygic.truck');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '992127700');
      expect(iosStoreAction.appName, 'sygic-truck-rv-navigation');
    });

    test('view action creates coordinate link, Android intent, and fallback', () {
      final action = SygicTruck.view(
        coordinate: destination,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), 'com.sygic.aura://coordinate%7C17.1077%7C48.1486%7Cshow');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'com.sygic.truck');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink.toString(), 'https://www.sygic.com/truck-gps-navigation');
    });

    test('directionsWithCoords action creates drive link, Android intent, and fallback', () {
      final action = SygicTruck.directionsWithCoords(
        destination: destination,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, destination);
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), 'com.sygic.aura://coordinate%7C17.1077%7C48.1486%7Cdrive');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.androidIntentOptions.package, 'com.sygic.truck');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://www.sygic.com/truck-gps-navigation');
    });
  });
}

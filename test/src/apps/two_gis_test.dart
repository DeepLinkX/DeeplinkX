import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/two_gis.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('2GIS Actions', () {
    const origin = Coordinate(latitude: 55.751244, longitude: 37.618423);
    const destination = Coordinate(latitude: 55.76009, longitude: 37.648801);

    test('open action exposes metadata and store actions', () {
      final action = TwoGis.open();

      expect(action.customScheme, 'dgis');
      expect(action.androidPackageName, 'ru.dublgis.dgismobile');
      expect(action.website.toString(), 'https://2gis.ru');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = TwoGis().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'ru.dublgis.dgismobile');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '481627348');
      expect(iosStoreAction.appName, '2gis-map-navigation-tracker');
    });

    test('travel modes expose provider values', () {
      // ignore: deprecated_member_use_from_same_package
      expect(TwoGisTravelMode.auto.value, 'car');
      expect(TwoGisTravelMode.driving.value, 'car');
      expect(TwoGisTravelMode.transit.value, 'ctx');
      expect(TwoGisTravelMode.walking.value, 'pedestrian');
    });

    test('travel modes expose Android app values', () {
      // ignore: deprecated_member_use_from_same_package
      expect(TwoGisTravelMode.auto.androidValue, 'car');
      expect(TwoGisTravelMode.driving.androidValue, 'car');
      expect(TwoGisTravelMode.transit.androidValue, 'bus');
      expect(TwoGisTravelMode.walking.androidValue, 'pedestrian');
    });

    test('view action creates iOS marker, Android route, and fallback URLs', () {
      final action = TwoGis.view(
        coordinate: destination,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), 'dgis://2gis.ru/geo/37.648801,55.76009');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'ru.dublgis.dgismobile');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(
        action.androidIntentOptions.data,
        'dgis://2gis.ru/routeSearch/rsType/car/to/37.648801,55.76009',
      );
      expect(action.fallbackLink.toString(), 'https://2gis.ru/geo/37.648801,55.76009');
    });

    test('directionsWithCoords action creates route URLs with origin and mode', () {
      final action = TwoGis.directionsWithCoords(
        origin: origin,
        destination: destination,
        mode: TwoGisTravelMode.transit,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, origin);
      expect(action.destination, destination);
      expect(action.mode, TwoGisTravelMode.transit);
      expect(action.fallbackToStore, true);
      expect(
        action.appLink.toString(),
        'dgis://2gis.ru/routeSearch/rsType/ctx/from/37.618423,55.751244/to/37.648801,55.76009',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'dgis://2gis.ru/routeSearch/rsType/bus/from/37.618423,55.751244/to/37.648801,55.76009',
      );
      expect(action.androidIntentOptions.package, 'ru.dublgis.dgismobile');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(
        action.fallbackLink.toString(),
        'https://2gis.ru/routeSearch/rsType/ctx/from/37.618423,55.751244/to/37.648801,55.76009',
      );
    });

    test('directionsWithCoords action supports destination-only routes', () {
      final action = TwoGis.directionsWithCoords(destination: destination);

      expect(action.origin, null);
      expect(action.mode, TwoGisTravelMode.driving);
      expect(action.appLink.toString(), 'dgis://2gis.ru/routeSearch/rsType/car/to/37.648801,55.76009');
      expect(action.fallbackLink.toString(), 'https://2gis.ru/routeSearch/rsType/car/to/37.648801,55.76009');
    });
  });
}

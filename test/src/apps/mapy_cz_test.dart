import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/mapy_cz.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const prague = Coordinate(latitude: 50.0755, longitude: 14.4378);
  const destination = Coordinate(latitude: 50.0292, longitude: 14.3681);

  group('MapyCz actions', () {
    test('open action exposes current metadata and store actions', () {
      final action = MapyCz.open();

      expect(action.customScheme, 'szn-mapy');
      expect(action.androidPackageName, 'cz.seznam.mapy');
      expect(action.website.toString(), 'https://mapy.com/');
      expect(action.supportedPlatforms, <PlatformType>[PlatformType.ios, PlatformType.android]);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isA<App>());
      expect(action, isA<DownloadableApp>());
    });

    test('store actions resolve to the current listings', () {
      final storeActions = MapyCz().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'cz.seznam.mapy');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '411411020');
      expect(iosStoreAction.appName, 'mapy-com-offline-maps-gps');
    });

    test('map sets and route types expose provider values', () {
      expect(MapyCzMapSet.values.map((final value) => value.value), [
        'basic',
        'outdoor',
        'winter',
        'aerial',
        'traffic',
      ]);
      expect(MapyCzRouteType.values.map((final value) => value.value), [
        'car_fast',
        'car_fast_traffic',
        'car_short',
        'foot_fast',
        'foot_hiking',
        'bike_road',
        'bike_mountain',
      ]);
    });

    test('view builds the documented showmap URL', () {
      final action = MapyCz.view(
        coordinate: prague,
        zoom: 15,
        mapSet: MapyCzMapSet.outdoor,
      );

      expect(action, isA<AppLinkAppAction>());
      expect(action, isA<IntentAppLinkAction>());
      expect(action, isA<Fallbackable>());
      expect(action.coordinate, prague);
      expect(action.zoom, 15);
      expect(action.mapSet, MapyCzMapSet.outdoor);
      expect(action.marker, true);
      expect(
        action.appLink.toString(),
        'https://mapy.com/fnc/v1/showmap?mapset=outdoor&center=14.4378%2C50.0755&zoom=15&marker=true',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.androidIntentOptions.package, 'cz.seznam.mapy');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink, action.appLink);
    });

    test('view exposes documented defaults', () {
      final action = MapyCz.view(coordinate: prague);

      expect(action.zoom, 16);
      expect(action.mapSet, MapyCzMapSet.basic);
      expect(action.marker, true);
      expect(
        action.appLink.toString(),
        'https://mapy.com/fnc/v1/showmap?mapset=basic&center=14.4378%2C50.0755&zoom=16&marker=true',
      );
    });

    test('search builds the documented search URL', () {
      final action = MapyCz.search(
        query: 'coffee shop',
        center: prague,
        zoom: 14,
        mapSet: MapyCzMapSet.aerial,
      );

      expect(action.query, 'coffee shop');
      expect(action.center, prague);
      expect(action.zoom, 14);
      expect(action.mapSet, MapyCzMapSet.aerial);
      expect(
        action.appLink.toString(),
        'https://mapy.com/fnc/v1/search?mapset=aerial&query=coffee+shop&center=14.4378%2C50.0755&zoom=14',
      );
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink, action.appLink);
    });

    test('directionsWithCoords builds the documented route URL', () {
      final action = MapyCz.directionsWithCoords(
        origin: prague,
        destination: destination,
        waypoints: const [Coordinate(latitude: 50.0335, longitude: 14.5087)],
        routeType: MapyCzRouteType.carFastTraffic,
        mapSet: MapyCzMapSet.traffic,
        navigate: true,
      );

      expect(action.destination, destination);
      expect(action.origin, prague);
      expect(action.waypoints, const [Coordinate(latitude: 50.0335, longitude: 14.5087)]);
      expect(action.routeType, MapyCzRouteType.carFastTraffic);
      expect(action.mapSet, MapyCzMapSet.traffic);
      expect(action.navigate, true);
      expect(
        action.appLink.toString(),
        'https://mapy.com/fnc/v1/route?mapset=traffic&start=14.4378%2C50.0755&end=14.3681%2C50.0292&routeType=car_fast_traffic&waypoints=14.5087%2C50.0335&navigate=true',
      );
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink, action.appLink);
    });

    test('directionsWithCoords supports destination-only defaults', () {
      final action = MapyCz.directionsWithCoords(destination: destination);

      expect(action.origin, null);
      expect(action.waypoints, isEmpty);
      expect(action.routeType, MapyCzRouteType.carFast);
      expect(action.mapSet, MapyCzMapSet.basic);
      expect(action.navigate, false);
      expect(
        action.appLink.toString(),
        'https://mapy.com/fnc/v1/route?mapset=basic&end=14.3681%2C50.0292&routeType=car_fast',
      );
    });

    test('rejects blank searches and more than 15 waypoints', () {
      expect(() => MapyCz.search(query: '  '), throwsArgumentError);
      expect(
        () => MapyCz.directionsWithCoords(
          destination: destination,
          waypoints: List<Coordinate>.filled(16, prague),
        ),
        throwsArgumentError,
      );
    });

    test('actions keep fallback flag', () {
      expect(MapyCz.view(coordinate: prague, fallbackToStore: true).fallbackToStore, true);
      expect(MapyCz.search(query: 'cafe', fallbackToStore: true).fallbackToStore, true);
      expect(MapyCz.directionsWithCoords(destination: destination, fallbackToStore: true).fallbackToStore, true);
    });
  });
}

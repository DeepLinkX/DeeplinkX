import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/tencent_maps.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tencent Maps Actions', () {
    const origin = Coordinate(latitude: 39.994745, longitude: 116.247282);
    const destination = Coordinate(latitude: 39.867192, longitude: 116.493187);
    const waypoint = Coordinate(latitude: 30.248015, longitude: 120.207788);

    test('open action exposes metadata and store actions', () {
      final action = TencentMaps.open();

      expect(action.customScheme, 'qqmap');
      expect(action.androidPackageName, 'com.tencent.map');
      expect(action.website.toString(), 'https://map.qq.com');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = TencentMaps().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.tencent.map');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '481623196');
      expect(iosStoreAction.appName, 'tencent-map');
    });

    test('coord types and travel modes expose provider values', () {
      expect(TencentMapsCoordType.gps.value, '1');
      expect(TencentMapsCoordType.tencent.value, '2');
      expect(TencentMapsTravelMode.driving.value, 'drive');
      expect(TencentMapsTravelMode.transit.value, 'bus');
      expect(TencentMapsTravelMode.walking.value, 'walk');
      expect(TencentMapsTravelMode.bicycling.value, 'bike');
    });

    test('waypoint formats route pass value', () {
      final title = ['Metro', 'Station'].join(' ');
      final routeWaypoint = TencentMapsWaypoint(title: title, coordinate: waypoint);

      expect(routeWaypoint.title, 'Metro Station');
      expect(routeWaypoint.coordinate, waypoint);
      expect(routeWaypoint.value, 'name:Metro Station;coord:30.248015,120.207788');
    });

    test('view action creates marker links, intent, and fallback', () {
      final action = TencentMaps.view(
        coordinate: destination,
        title: 'Tencent Office',
        address: 'Beijing',
        coordType: TencentMapsCoordType.gps,
        referer: 'test_app',
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.title, 'Tencent Office');
      expect(action.address, 'Beijing');
      expect(action.coordType, TencentMapsCoordType.gps);
      expect(action.referer, 'test_app');
      expect(action.fallbackToStore, true);
      expect(action.appLink.scheme, 'qqmap');
      expect(action.appLink.host, 'map');
      expect(action.appLink.path, '/marker');
      expect(action.appLink.queryParameters['marker'], 'coord:39.867192,116.493187;title:Tencent Office;addr:Beijing');
      expect(action.appLink.queryParameters['coord_type'], '1');
      expect(action.appLink.queryParameters['referer'], 'test_app');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.androidIntentOptions.package, 'com.tencent.map');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'apis.map.qq.com');
      expect(action.fallbackLink.path, '/uri/v1/marker');
      expect(action.fallbackLink.queryParameters, action.appLink.queryParameters);
    });

    test('search action creates keyword links with region', () {
      final action = TencentMaps.search(
        query: 'coffee',
        region: 'Shanghai',
        referer: 'test_app',
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapSearchAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.query, 'coffee');
      expect(action.region, 'Shanghai');
      expect(action.referer, 'test_app');
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), contains('qqmap://map/search'));
      expect(action.appLink.queryParameters['keyword'], 'coffee');
      expect(action.appLink.queryParameters['region'], 'Shanghai');
      expect(action.appLink.queryParameters['referer'], 'test_app');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink.toString(), contains('https://apis.map.qq.com/uri/v1/search'));
      expect(action.fallbackLink.queryParameters, action.appLink.queryParameters);
    });

    test('nearbySearch action creates center and radius links', () {
      final action = TencentMaps.nearbySearch(
        query: 'restaurant',
        center: origin,
        radius: 800,
        coordType: TencentMapsCoordType.gps,
        referer: 'test_app',
      );

      expect(action, isInstanceOf<MapSearchAction>());
      expect(action.query, 'restaurant');
      expect(action.center, origin);
      expect(action.radius, 800);
      expect(action.coordType, TencentMapsCoordType.gps);
      expect(action.referer, 'test_app');
      expect(action.appLink.queryParameters['keyword'], 'restaurant');
      expect(action.appLink.queryParameters['center'], '39.994745,116.247282');
      expect(action.appLink.queryParameters['radius'], '800');
      expect(action.appLink.queryParameters['coord_type'], '1');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink.queryParameters, action.appLink.queryParameters);
    });

    test('nearbySearch action defaults to current location', () {
      final action = TencentMaps.nearbySearch(query: 'hotel');

      expect(action.center, null);
      expect(action.radius, 1000);
      expect(action.coordType, TencentMapsCoordType.tencent);
      expect(action.referer, 'deeplink_x');
      expect(action.appLink.queryParameters['center'], 'CurrentLocation');
      expect(action.appLink.queryParameters['radius'], '1000');
      expect(action.appLink.queryParameters['coord_type'], '2');
      expect(action.appLink.queryParameters['referer'], 'deeplink_x');
    });

    test('directionsWithCoords action creates route links with origin, POI, and waypoints', () {
      final action = TencentMaps.directionsWithCoords(
        origin: origin,
        originTitle: 'Tsinghua',
        destination: destination,
        destinationTitle: 'Community',
        destinationPoiId: '12609347545913930473',
        waypoints: const [TencentMapsWaypoint(title: 'Metro Station', coordinate: waypoint)],
        mode: TencentMapsTravelMode.transit,
        referer: 'test_app',
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, origin);
      expect(action.originTitle, 'Tsinghua');
      expect(action.destination, destination);
      expect(action.destinationTitle, 'Community');
      expect(action.destinationPoiId, '12609347545913930473');
      expect(action.waypoints.length, 1);
      expect(action.mode, TencentMapsTravelMode.transit);
      expect(action.referer, 'test_app');
      expect(action.fallbackToStore, true);
      expect(action.appLink.path, '/routeplan');
      expect(action.appLink.queryParameters['type'], 'bus');
      expect(action.appLink.queryParameters['from'], 'Tsinghua');
      expect(action.appLink.queryParameters['fromcoord'], '39.994745,116.247282');
      expect(action.appLink.queryParameters['to'], 'Community');
      expect(action.appLink.queryParameters['tocoord'], '39.867192,116.493187');
      expect(action.appLink.queryParameters['touid'], '12609347545913930473');
      expect(action.appLink.queryParameters['passes'], 'name:Metro Station;coord:30.248015,120.207788');
      expect(action.appLink.queryParameters['referer'], 'test_app');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.androidIntentOptions.package, 'com.tencent.map');
      expect(action.fallbackLink.path, '/uri/v1/routeplan');
      expect(action.fallbackLink.queryParameters, action.appLink.queryParameters);
    });

    test('directionsWithCoords action defaults to current location origin', () {
      final action = TencentMaps.directionsWithCoords(destination: destination);

      expect(action.origin, null);
      expect(action.destinationTitle, null);
      expect(action.originTitle, null);
      expect(action.destinationPoiId, null);
      expect(action.waypoints, isEmpty);
      expect(action.mode, TencentMapsTravelMode.driving);
      expect(action.referer, 'deeplink_x');
      expect(action.appLink.queryParameters['type'], 'drive');
      expect(action.appLink.queryParameters['fromcoord'], 'CurrentLocation');
      expect(action.appLink.queryParameters['tocoord'], '39.867192,116.493187');
      expect(action.appLink.queryParameters.containsKey('from'), false);
      expect(action.appLink.queryParameters.containsKey('to'), false);
      expect(action.appLink.queryParameters.containsKey('touid'), false);
      expect(action.appLink.queryParameters.containsKey('passes'), false);
    });
  });
}

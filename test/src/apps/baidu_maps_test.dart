import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/baidu_maps.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Baidu Maps Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = BaiduMaps.open();

      expect(action.customScheme, 'baidumap');
      expect(action.androidPackageName, 'com.baidu.BaiduMap');
      expect(action.website.toString(), 'https://map.baidu.com');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = BaiduMaps.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('view action creates marker links', () {
      final action = BaiduMaps.view(
        coordinate: const Coordinate(latitude: 39.915, longitude: 116.404),
        title: 'Tiananmen',
        content: 'Beijing landmark',
        zoom: 16,
        coordType: BaiduMapsCoordType.wgs84,
        traffic: true,
      );

      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());

      expect(action.appLink.scheme, 'baidumap');
      expect(action.appLink.host, 'map');
      expect(action.appLink.path, '/marker');
      expect(action.appLink.queryParameters['location'], '39.915,116.404');
      expect(action.appLink.queryParameters['title'], 'Tiananmen');
      expect(action.appLink.queryParameters['content'], 'Beijing landmark');
      expect(action.appLink.queryParameters['zoom'], '16');
      expect(action.appLink.queryParameters['coord_type'], 'wgs84');
      expect(action.appLink.queryParameters['traffic'], 'on');
      expect(action.appLink.queryParameters['src'], 'deeplink_x');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.path, '/marker');
      expect(intentUri.queryParameters['location'], '39.915,116.404');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'com.baidu.BaiduMap');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://map.baidu.com');
    });

    test('search action creates place search links', () {
      final action = BaiduMaps.search(
        query: 'coffee',
        region: 'Beijing',
        center: const Coordinate(latitude: 39.915, longitude: 116.404),
        // not const on purpose so VM executes the constructor (coverage)
        // ignore: prefer_const_constructors
        bounds: BaiduMapsBounds(
          southWest: const Coordinate(latitude: 39.9, longitude: 116.3),
          northEast: const Coordinate(latitude: 40, longitude: 116.5),
        ),
        radius: 1000,
        zoom: 15,
        coordType: BaiduMapsCoordType.gcj02,
      );

      expect(action.appLink.path, '/place/search');
      expect(action.appLink.queryParameters['query'], 'coffee');
      expect(action.appLink.queryParameters['region'], 'Beijing');
      expect(action.appLink.queryParameters['location'], '39.915,116.404');
      expect(action.appLink.queryParameters['bounds'], '39.9,116.3,40.0,116.5');
      expect(action.appLink.queryParameters['radius'], '1000');
      expect(action.appLink.queryParameters['zoom'], '15');
      expect(action.appLink.queryParameters['coord_type'], 'gcj02');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.path, '/place/search');
      expect(intentUri.queryParameters['query'], 'coffee');
      expect(action.fallbackLink.toString(), 'https://map.baidu.com');
    });

    test('nearbySearch action creates nearby links', () {
      final action = BaiduMaps.nearbySearch(
        query: 'hotel',
        center: const Coordinate(latitude: 31.2304, longitude: 121.4737),
        radius: 2500,
        coordType: BaiduMapsCoordType.bd09mc,
      );

      expect(action.appLink.path, '/place/nearby');
      expect(action.appLink.queryParameters['query'], 'hotel');
      expect(action.appLink.queryParameters['location'], '31.2304,121.4737');
      expect(action.appLink.queryParameters['radius'], '2500');
      expect(action.appLink.queryParameters['coord_type'], 'bd09mc');
      expect(Uri.parse(action.androidIntentOptions.data!).path, '/place/nearby');
      expect(action.fallbackLink.toString(), 'https://map.baidu.com');
    });

    test('line action creates transit line links', () {
      final action = BaiduMaps.line(
        name: 'Line 1',
        region: 'Beijing',
        zoom: 13,
      );

      expect(action.appLink.path, '/line');
      expect(action.appLink.queryParameters['name'], 'Line 1');
      expect(action.appLink.queryParameters['region'], 'Beijing');
      expect(action.appLink.queryParameters['zoom'], '13');
      expect(Uri.parse(action.androidIntentOptions.data!).path, '/line');
      expect(action.fallbackLink.toString(), 'https://map.baidu.com');
    });

    test('directions action creates text route links', () {
      final action = BaiduMaps.directions(
        origin: 'Beijing Railway Station',
        destination: 'Tiananmen',
        region: 'Beijing',
        mode: BaiduMapsTravelMode.transit,
      );

      expect(action.appLink.path, '/direction');
      expect(action.appLink.queryParameters['origin'], 'Beijing Railway Station');
      expect(action.appLink.queryParameters['destination'], 'Tiananmen');
      expect(action.appLink.queryParameters['region'], 'Beijing');
      expect(action.appLink.queryParameters['mode'], 'transit');
      expect(action.appLink.queryParameters['coord_type'], 'bd09ll');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.path, '/direction');
      expect(intentUri.queryParameters['destination'], 'Tiananmen');
      expect(action.fallbackLink.toString(), 'https://map.baidu.com');

      final currentLocationAction = BaiduMaps.directions(destination: 'Tiananmen');
      expect(currentLocationAction.appLink.queryParameters['origin'], '我的位置');
      expect(currentLocationAction.appLink.queryParameters['mode'], 'driving');
    });

    test('directionsWithCoords action creates coordinate route links', () {
      final action = BaiduMaps.directionsWithCoords(
        origin: const Coordinate(latitude: 39.9042, longitude: 116.4074),
        originTitle: 'Start',
        destination: const Coordinate(latitude: 39.915, longitude: 116.404),
        destinationTitle: 'Tiananmen',
        region: 'Beijing',
        mode: BaiduMapsTravelMode.walking,
        coordType: BaiduMapsCoordType.wgs84,
      );

      expect(action.appLink.path, '/direction');
      expect(action.appLink.queryParameters['origin'], 'latlng:39.9042,116.4074|name:Start');
      expect(action.appLink.queryParameters['destination'], 'latlng:39.915,116.404|name:Tiananmen');
      expect(action.appLink.queryParameters['region'], 'Beijing');
      expect(action.appLink.queryParameters['mode'], 'walking');
      expect(action.appLink.queryParameters['coord_type'], 'wgs84');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.path, '/direction');
      expect(intentUri.queryParameters['destination'], 'latlng:39.915,116.404|name:Tiananmen');
      expect(action.fallbackLink.toString(), 'https://map.baidu.com');

      final currentLocationAction = BaiduMaps.directionsWithCoords(
        destination: const Coordinate(latitude: 39.915, longitude: 116.404),
      );
      expect(currentLocationAction.appLink.queryParameters['origin'], '我的位置');
      expect(currentLocationAction.appLink.queryParameters['destination'], 'latlng:39.915,116.404');
    });

    test('navigate action creates native navigation links', () {
      final drivingAction = BaiduMaps.navigate(
        destination: const Coordinate(latitude: 39.915, longitude: 116.404),
      );

      expect(drivingAction.appLink.path, '/navi');
      expect(drivingAction.appLink.queryParameters['location'], '39.915,116.404');
      expect(drivingAction.appLink.queryParameters['coord_type'], 'bd09ll');
      expect(Uri.parse(drivingAction.androidIntentOptions.data!).path, '/navi');

      final walkingAction = BaiduMaps.navigate(
        destination: const Coordinate(latitude: 39.915, longitude: 116.404),
        mode: BaiduMapsNavigationMode.walking,
      );
      expect(walkingAction.appLink.path, '/walknavi');
      expect(walkingAction.appLink.queryParameters['destination'], '39.915,116.404');
      expect(Uri.parse(walkingAction.androidIntentOptions.data!).path, '/walknavi');

      final ridingAction = BaiduMaps.navigate(
        destination: const Coordinate(latitude: 39.915, longitude: 116.404),
        mode: BaiduMapsNavigationMode.riding,
        coordType: BaiduMapsCoordType.gcj02,
      );
      expect(ridingAction.appLink.path, '/ridenavi');
      expect(ridingAction.appLink.queryParameters['destination'], '39.915,116.404');
      expect(ridingAction.appLink.queryParameters['coord_type'], 'gcj02');
      expect(Uri.parse(ridingAction.androidIntentOptions.data!).path, '/bikenavi');
      expect(ridingAction.fallbackLink.toString(), 'https://map.baidu.com');
    });

    test('store actions resolve to expected stores', () {
      final storeActions = BaiduMaps().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.baidu.BaiduMap');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '452186370');
      expect(iosStoreAction.appName, 'baidu-maps');
    });

    test('actions keep fallback flag and parameters', () {
      final viewAction = BaiduMaps.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final searchAction = BaiduMaps.search(query: 'library', fallbackToStore: true);
      expect(searchAction.query, 'library');
      expect(searchAction.fallbackToStore, true);

      final nearbySearchAction = BaiduMaps.nearbySearch(query: 'atm', fallbackToStore: true);
      expect(nearbySearchAction.query, 'atm');
      expect(nearbySearchAction.fallbackToStore, true);

      final lineAction = BaiduMaps.line(name: 'Line 2', fallbackToStore: true);
      expect(lineAction.name, 'Line 2');
      expect(lineAction.fallbackToStore, true);

      final directionsAction = BaiduMaps.directions(destination: 'Station', fallbackToStore: true);
      expect(directionsAction.destination, 'Station');
      expect(directionsAction.fallbackToStore, true);

      final directionsWithCoordsAction = BaiduMaps.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsWithCoordsAction.destination.toString(), '1.0,2.0');
      expect(directionsWithCoordsAction.fallbackToStore, true);

      final navigateAction = BaiduMaps.navigate(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(navigateAction.destination.toString(), '1.0,2.0');
      expect(navigateAction.fallbackToStore, true);
    });
  });
}

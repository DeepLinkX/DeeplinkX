import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/amap.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Amap Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = Amap.open();

      expect(action.customScheme, 'iosamap');
      expect(action.androidPackageName, 'com.autonavi.minimap');
      expect(action.website.toString(), 'https://www.amap.com');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = Amap.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('myLocation action creates iOS and Android links', () {
      final action = Amap.myLocation();

      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.appLink.toString(), 'iosamap://mylocation?sourceApplication=deeplink_x');
      expect(
        action.androidIntentOptions.data,
        'androidamap://mylocation?sourceApplication=deeplink_x',
      );
      expect(action.androidIntentOptions.package, 'com.autonavi.minimap');
      expect(action.fallbackLink.toString(), 'https://www.amap.com');
    });

    test('view action creates marker links', () {
      final action = Amap.view(
        coordinate: const Coordinate(latitude: 39.98848272, longitude: 116.47560823),
        title: 'Amap HQ',
        convertFromWgs84: true,
      );

      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());

      expect(action.appLink.scheme, 'iosamap');
      expect(action.appLink.host, 'viewmap');
      expect(action.appLink.queryParameters['sourceApplication'], 'deeplink_x');
      expect(action.appLink.queryParameters['poiname'], 'Amap HQ');
      expect(action.appLink.queryParameters['lat'], '39.98848272');
      expect(action.appLink.queryParameters['lon'], '116.47560823');
      expect(action.appLink.queryParameters['dev'], '1');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.scheme, 'androidamap');
      expect(intentUri.host, 'viewmap');
      expect(intentUri.queryParameters['poiname'], 'Amap HQ');
      expect(intentUri.queryParameters['lat'], '39.98848272');
      expect(intentUri.queryParameters['lon'], '116.47560823');
      expect(intentUri.queryParameters['dev'], '1');
      expect(action.fallbackLink.toString(), 'https://www.amap.com');
    });

    test('search action creates platform-specific query keys', () {
      final action = Amap.search(
        query: 'bank|fuel',
        // not const on purpose so VM executes the constructor (coverage)
        // ignore: prefer_const_constructors
        bounds: AmapBounds(
          topLeft: const Coordinate(latitude: 36.1, longitude: 116.1),
          bottomRight: const Coordinate(latitude: 36.2, longitude: 116.2),
        ),
      );

      expect(action.appLink.scheme, 'iosamap');
      expect(action.appLink.host, 'poi');
      expect(action.appLink.queryParameters['name'], 'bank|fuel');
      expect(action.appLink.queryParameters.containsKey('keywords'), false);
      expect(action.appLink.queryParameters['lat1'], '36.1');
      expect(action.appLink.queryParameters['lon1'], '116.1');
      expect(action.appLink.queryParameters['lat2'], '36.2');
      expect(action.appLink.queryParameters['lon2'], '116.2');
      expect(action.appLink.queryParameters['dev'], '0');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.scheme, 'androidamap');
      expect(intentUri.host, 'poi');
      expect(intentUri.queryParameters['keywords'], 'bank|fuel');
      expect(intentUri.queryParameters.containsKey('name'), false);
      expect(intentUri.queryParameters['lat1'], '36.1');
      expect(intentUri.queryParameters['lon1'], '116.1');
      expect(intentUri.queryParameters['lat2'], '36.2');
      expect(intentUri.queryParameters['lon2'], '116.2');
      expect(intentUri.queryParameters['dev'], '0');
      expect(action.fallbackLink.toString(), 'https://www.amap.com');
    });

    test('directions action creates text destination links', () {
      final action = Amap.directions(destination: 'Amap HQ');

      expect(action.appLink.scheme, 'iosamap');
      expect(action.appLink.host, 'path');
      expect(action.appLink.queryParameters['sourceApplication'], 'deeplink_x');
      expect(action.appLink.queryParameters['dname'], 'Amap HQ');
      expect(action.appLink.queryParameters['dev'], '0');
      expect(action.appLink.queryParameters['t'], '0');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.scheme, 'amapuri');
      expect(intentUri.host, 'route');
      expect(intentUri.path, '/plan/');
      expect(intentUri.queryParameters['sourceApplication'], 'deeplink_x');
      expect(intentUri.queryParameters['dname'], 'Amap HQ');
      expect(intentUri.queryParameters['dev'], '0');
      expect(intentUri.queryParameters['t'], '0');
      expect(action.fallbackLink.toString(), 'https://www.amap.com');
    });

    test('directionsWithCoords action creates route links with waypoints', () {
      final action = Amap.directionsWithCoords(
        origin: const Coordinate(latitude: 39.92848272, longitude: 116.39560823),
        originTitle: 'A',
        destination: const Coordinate(latitude: 39.98848272, longitude: 116.47560823),
        destinationTitle: 'B',
        waypoints: [
          // not const on purpose so VM executes the constructor (coverage)
          // ignore: prefer_const_constructors
          AmapWaypoint(
            coordinate: const Coordinate(latitude: 39.5, longitude: 116.8),
            title: 'Via 1',
          ),
          // not const on purpose so VM executes the constructor (coverage)
          // ignore: prefer_const_constructors
          AmapWaypoint(
            coordinate: const Coordinate(latitude: 39.7, longitude: 116.5),
            title: 'Via 2',
          ),
        ],
        mode: AmapTravelMode.bicycling,
        convertFromWgs84: true,
      );

      expect(action.appLink.scheme, 'iosamap');
      expect(action.appLink.host, 'path');
      expect(action.appLink.queryParameters['slat'], '39.92848272');
      expect(action.appLink.queryParameters['slon'], '116.39560823');
      expect(action.appLink.queryParameters['sname'], 'A');
      expect(action.appLink.queryParameters['dlat'], '39.98848272');
      expect(action.appLink.queryParameters['dlon'], '116.47560823');
      expect(action.appLink.queryParameters['dname'], 'B');
      expect(action.appLink.queryParameters['dev'], '1');
      expect(action.appLink.queryParameters['t'], '3');
      expect(action.appLink.queryParameters['vian'], '2');
      expect(action.appLink.queryParameters['vialons'], '116.8|116.5');
      expect(action.appLink.queryParameters['vialats'], '39.5|39.7');
      expect(action.appLink.queryParameters['vianames'], 'Via 1|Via 2');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.scheme, 'amapuri');
      expect(intentUri.host, 'route');
      expect(intentUri.path, '/plan/');
      expect(intentUri.queryParameters['slat'], '39.92848272');
      expect(intentUri.queryParameters['slon'], '116.39560823');
      expect(intentUri.queryParameters['sname'], 'A');
      expect(intentUri.queryParameters['dlat'], '39.98848272');
      expect(intentUri.queryParameters['dlon'], '116.47560823');
      expect(intentUri.queryParameters['dname'], 'B');
      expect(intentUri.queryParameters['dev'], '1');
      expect(intentUri.queryParameters['t'], '3');
      expect(intentUri.queryParameters['vian'], '2');
      expect(intentUri.queryParameters['vialons'], '116.8|116.5');
      expect(intentUri.queryParameters['vialats'], '39.5|39.7');
      expect(intentUri.queryParameters['vianames'], 'Via 1|Via 2');
      expect(action.fallbackLink.toString(), 'https://www.amap.com');
    });

    test('store actions resolve to expected stores', () {
      final storeActions = Amap().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.autonavi.minimap');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '461703208');
      expect(iosStoreAction.appName, 'gao-de-di-tu');
    });

    test('actions keep fallback flag', () {
      final viewAction = Amap.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final directionsAction = Amap.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsAction.fallbackToStore, true);
    });
  });
}

import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/yandex_maps.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Yandex Maps Actions', () {
    const center = Coordinate(latitude: 55.753716, longitude: 37.619902);
    const destination = Coordinate(latitude: 55.76009, longitude: 37.648801);

    test('open action exposes metadata and store actions', () {
      final action = YandexMaps.open();

      expect(action.customScheme, 'yandexmaps');
      expect(action.androidPackageName, 'ru.yandex.yandexmaps');
      expect(action.website.toString(), 'https://yandex.com/maps');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = YandexMaps().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'ru.yandex.yandexmaps');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '313877526');
      expect(iosStoreAction.appName, 'yandex-maps-navigator');
    });

    test('openMap action creates app, fallback, and intent URLs', () {
      final action = YandexMaps.openMap(
        center: center,
        zoom: 11,
        viewport: const YandexMapsViewport(longitudeDelta: 10.5, latitudeDelta: 9.5),
        layer: YandexMapsMapLayer.hybrid,
        showTraffic: true,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.fallbackToStore, true);
      expect(action.center, center);
      expect(action.zoom, 11);
      expect(action.viewport.toString(), '10.5,9.5');
      expect(action.layer, YandexMapsMapLayer.hybrid);
      expect(action.showTraffic, true);

      expect(action.appLink.scheme, 'yandexmaps');
      expect(action.appLink.host, 'maps.yandex.com');
      expect(action.appLink.path, '/');
      expect(action.appLink.queryParameters['ll'], '37.619902,55.753716');
      expect(action.appLink.queryParameters['z'], '11');
      expect(action.appLink.queryParameters['spn'], '10.5,9.5');
      expect(action.appLink.queryParameters['l'], 'skl,trf');

      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'yandex.com');
      expect(action.fallbackLink.path, '/maps/');
      expect(action.fallbackLink.queryParameters['ll'], '37.619902,55.753716');
      expect(action.fallbackLink.queryParameters['l'], 'skl,trf');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'ru.yandex.yandexmaps');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(intentUri.queryParameters['l'], 'skl,trf');
    });

    test('view action creates placemark URLs', () {
      final action = YandexMaps.view(
        coordinate: center,
        zoom: 12,
        layer: YandexMapsMapLayer.satellite,
        showTraffic: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, center);
      expect(action.zoom, 12);
      expect(action.layer, YandexMapsMapLayer.satellite);
      expect(action.showTraffic, true);
      expect(action.appLink.host, 'maps.yandex.ru');
      expect(action.appLink.queryParameters['pt'], '37.619902,55.753716');
      expect(action.appLink.queryParameters['z'], '12');
      expect(action.appLink.queryParameters['l'], 'sat,trf');
      expect(action.fallbackLink.queryParameters['pt'], '37.619902,55.753716');
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['pt'], '37.619902,55.753716');
    });

    test('search action creates query URLs', () {
      final action = YandexMaps.search(
        query: 'cafe with wi-fi',
        center: center,
        zoom: 16,
        viewport: const YandexMapsViewport(longitudeDelta: 0.05, latitudeDelta: 0.05),
        layer: YandexMapsMapLayer.publicMap,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapSearchAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.query, 'cafe with wi-fi');
      expect(action.center, center);
      expect(action.zoom, 16);
      expect(action.viewport.toString(), '0.05,0.05');
      expect(action.layer, YandexMapsMapLayer.publicMap);
      expect(action.showTraffic, false);
      expect(action.fallbackToStore, true);
      expect(action.appLink.queryParameters['ll'], '37.619902,55.753716');
      expect(action.appLink.queryParameters['z'], '16');
      expect(action.appLink.queryParameters['spn'], '0.05,0.05');
      expect(action.appLink.queryParameters['text'], 'cafe with wi-fi');
      expect(action.appLink.queryParameters['l'], 'pmap');
      expect(action.fallbackLink.queryParameters['text'], 'cafe with wi-fi');
      expect(action.fallbackLink.queryParameters['l'], 'map');
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['text'], 'cafe with wi-fi');
    });

    test('public map web fallback preserves traffic with the standard map layer', () {
      final action = YandexMaps.openMap(
        layer: YandexMapsMapLayer.publicMap,
        showTraffic: true,
      );

      expect(action.appLink.queryParameters['l'], 'pmap,trf');
      expect(action.fallbackLink.queryParameters['l'], 'map,trf');
    });

    test('organization action creates object card URLs', () {
      final action = YandexMaps.organization(objectId: '1221676748');

      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.objectId, '1221676748');
      expect(action.appLink.queryParameters['oid'], '1221676748');
      expect(action.fallbackLink.toString(), 'https://yandex.com/maps/org/1221676748');
      expect(action.fallbackLink.queryParameters, isEmpty);
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['oid'], '1221676748');
    });

    test('whatIsHere action creates object lookup URLs', () {
      final action = YandexMaps.whatIsHere(
        coordinate: center,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, center);
      expect(action.zoom, 17);
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), startsWith('yandexmaps://?'));
      expect(action.appLink.queryParameters['whatshere[point]'], '37.619902,55.753716');
      expect(action.appLink.queryParameters['whatshere[zoom]'], '17');
      expect(action.fallbackLink.queryParameters['whatshere[point]'], '37.619902,55.753716');
      expect(
        Uri.parse(action.androidIntentOptions.data!).queryParameters['whatshere[zoom]'],
        '17',
      );
    });

    test('directionsWithCoords action creates route URLs', () {
      final action = YandexMaps.directionsWithCoords(
        origin: center,
        destination: destination,
        waypoints: const [
          YandexMapsWaypoint(coordinate: Coordinate(latitude: 55.745719, longitude: 37.604337)),
        ],
        mode: YandexMapsTravelMode.transit,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, center);
      expect(action.destination, destination);
      expect(action.waypoints.length, 1);
      expect(action.waypoints.first.coordinate.latitude, 55.745719);
      expect(action.mode, YandexMapsTravelMode.transit);
      expect(action.fallbackToStore, true);
      expect(
        action.appLink.queryParameters['rtext'],
        '55.753716,37.619902~55.745719,37.604337~55.76009,37.648801',
      );
      expect(action.appLink.queryParameters['rtt'], 'mt');
      expect(action.fallbackLink.queryParameters['rtt'], 'mt');
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['rtt'], 'mt');
    });

    test('directionsWithCoords action defaults to destination-only driving route', () {
      final action = YandexMaps.directionsWithCoords(destination: destination);

      expect(action.origin, null);
      expect(action.waypoints, isEmpty);
      expect(action.mode, YandexMapsTravelMode.driving);
      expect(action.appLink.queryParameters['rtext'], '55.76009,37.648801');
      expect(action.appLink.queryParameters['rtt'], 'auto');
    });

    test('directionsWithCoords action supports walking mode', () {
      final action = YandexMaps.directionsWithCoords(
        destination: destination,
        mode: YandexMapsTravelMode.walking,
      );

      expect(action.mode.value, 'pd');
      expect(action.appLink.queryParameters['rtt'], 'pd');
    });

    test('panorama action creates panorama URLs', () {
      final action = YandexMaps.panorama(
        coordinate: center,
        direction: const YandexMapsPanoramaDirection(azimuth: 228.97, elevation: 6.060547),
        span: const YandexMapsPanoramaSpan(horizontal: 130, vertical: 71.919192),
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, center);
      expect(action.direction.toString(), '228.97,6.060547');
      expect(action.span.toString(), '130.0,71.919192');
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), startsWith('yandexmaps://?'));
      expect(action.appLink.queryParameters['panorama[point]'], '37.619902,55.753716');
      expect(action.appLink.queryParameters['panorama[direction]'], '228.97,6.060547');
      expect(action.appLink.queryParameters['panorama[span]'], '130.0,71.919192');
      expect(action.fallbackLink.queryParameters['panorama[span]'], '130.0,71.919192');
      expect(
        Uri.parse(action.androidIntentOptions.data!).queryParameters['panorama[direction]'],
        '228.97,6.060547',
      );
    });
  });
}

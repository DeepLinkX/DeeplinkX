// Keep helper models non-const so coverage records their constructors.
// ignore_for_file: prefer_const_constructors

import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/yandex_navigator.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Yandex Navigator Actions', () {
    const origin = Coordinate(latitude: 55.753716, longitude: 37.619902);
    const destination = Coordinate(latitude: 55.76009, longitude: 37.648801);
    final launchParams = YandexNavigatorLaunchParams(
      client: 'client-id',
      signature: 'signed-value',
    );

    test('open action exposes metadata and store actions', () {
      final action = YandexNavigator.open();

      expect(action.customScheme, 'yandexnavi');
      expect(action.androidPackageName, 'ru.yandex.yandexnavi');
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
      final storeActions = YandexNavigator().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'ru.yandex.yandexnavi');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '474500851');
      expect(iosStoreAction.appName, 'yandex-navi-navigation-maps');
    });

    test('view action creates point URLs', () {
      final action = YandexNavigator.view(
        coordinate: origin,
        zoom: 12,
        showBalloon: false,
        description: 'cafe with wi-fi',
        launchParams: launchParams,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, origin);
      expect(action.zoom, 12);
      expect(action.showBalloon, false);
      expect(action.description, 'cafe with wi-fi');
      expect(action.launchParams, launchParams);
      expect(action.fallbackToStore, true);
      expect(action.appLink.scheme, 'yandexnavi');
      expect(action.appLink.host, 'show_point_on_map');
      expect(action.appLink.queryParameters['lat'], '55.753716');
      expect(action.appLink.queryParameters['lon'], '37.619902');
      expect(action.appLink.queryParameters['zoom'], '12');
      expect(action.appLink.queryParameters['no-balloon'], '1');
      expect(action.appLink.queryParameters['desc'], 'cafe with wi-fi');
      expect(action.appLink.queryParameters['client'], 'client-id');
      expect(action.appLink.queryParameters['signature'], 'signed-value');
      expect(action.fallbackLink.host, 'yandex.com');
      expect(action.fallbackLink.path, '/maps/');
      expect(action.fallbackLink.queryParameters['ll'], '37.619902,55.753716');
      expect(action.fallbackLink.queryParameters['z'], '12');
      expect(action.fallbackLink.queryParameters['l'], 'map');
      expect(action.fallbackLink.queryParameters.containsKey('pt'), false);
      expect(action.fallbackLink.queryParameters.containsKey('desc'), false);
      expect(action.fallbackLink.queryParameters.containsKey('client'), false);
      expect(action.fallbackLink.queryParameters.containsKey('signature'), false);
      expect(action.fallbackLink.queryParameters.containsKey('no-balloon'), false);

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'ru.yandex.yandexnavi');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(intentUri.queryParameters['no-balloon'], '1');
    });

    test('view action defaults to visible balloon and zoom 18', () {
      final action = YandexNavigator.view(coordinate: origin);

      expect(action.zoom, 18);
      expect(action.showBalloon, true);
      expect(action.description, null);
      expect(action.launchParams, null);
      expect(action.appLink.queryParameters['no-balloon'], '0');
      expect(action.appLink.queryParameters['zoom'], '18');
      expect(action.appLink.queryParameters.containsKey('desc'), false);
      expect(action.fallbackLink.queryParameters['pt'], '37.619902,55.753716');
      expect(action.fallbackLink.queryParameters['z'], '18');
      expect(action.fallbackLink.queryParameters.containsKey('ll'), false);
    });

    test('search action creates search URLs', () {
      final action = YandexNavigator.search(
        query: 'gas station',
        launchParams: launchParams,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapSearchAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.query, 'gas station');
      expect(action.launchParams, launchParams);
      expect(action.fallbackToStore, true);
      expect(action.appLink.host, 'map_search');
      expect(action.appLink.queryParameters['text'], 'gas station');
      expect(action.appLink.queryParameters['client'], 'client-id');
      expect(action.appLink.queryParameters['signature'], 'signed-value');
      expect(action.fallbackLink.queryParameters['text'], 'gas station');
      expect(action.fallbackLink.queryParameters['l'], 'map');
      expect(action.fallbackLink.queryParameters.containsKey('client'), false);
      expect(action.fallbackLink.queryParameters.containsKey('signature'), false);
      expect(action.fallbackLink.toString(), contains('gas+station'));
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['text'], 'gas station');
    });

    test('directionsWithCoords action creates route URLs', () {
      final action = YandexNavigator.directionsWithCoords(
        origin: origin,
        destination: destination,
        waypoints: [
          YandexNavigatorWaypoint(coordinate: Coordinate(latitude: 55.745719, longitude: 37.604337)),
          YandexNavigatorWaypoint(coordinate: Coordinate(latitude: 55.75, longitude: 37.62)),
        ],
        launchParams: launchParams,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, origin);
      expect(action.destination, destination);
      expect(action.waypoints.length, 2);
      expect(action.launchParams, launchParams);
      expect(action.fallbackToStore, true);
      expect(action.appLink.host, 'build_route_on_map');
      expect(action.appLink.queryParameters['lat_to'], '55.76009');
      expect(action.appLink.queryParameters['lon_to'], '37.648801');
      expect(action.appLink.queryParameters['lat_from'], '55.753716');
      expect(action.appLink.queryParameters['lon_from'], '37.619902');
      expect(action.appLink.queryParameters['lat_via_0'], '55.745719');
      expect(action.appLink.queryParameters['lon_via_0'], '37.604337');
      expect(action.appLink.queryParameters['lat_via_1'], '55.75');
      expect(action.appLink.queryParameters['lon_via_1'], '37.62');
      expect(action.appLink.queryParameters['client'], 'client-id');
      expect(action.appLink.queryParameters['signature'], 'signed-value');
      expect(
        action.fallbackLink.queryParameters['rtext'],
        '55.753716,37.619902~55.745719,37.604337~55.75,37.62~55.76009,37.648801',
      );
      expect(action.fallbackLink.queryParameters['rtt'], 'auto');
      expect(action.fallbackLink.queryParameters.containsKey('client'), false);
      expect(action.fallbackLink.queryParameters.containsKey('signature'), false);
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['lat_to'], '55.76009');
    });

    test('directionsWithCoords action supports destination-only routes', () {
      final action = YandexNavigator.directionsWithCoords(destination: destination);

      expect(action.origin, null);
      expect(action.waypoints, isEmpty);
      expect(action.launchParams, null);
      expect(action.appLink.queryParameters['lat_to'], '55.76009');
      expect(action.appLink.queryParameters['lon_to'], '37.648801');
      expect(action.appLink.queryParameters.containsKey('lat_from'), false);
      expect(action.appLink.queryParameters.containsKey('lon_from'), false);
      expect(action.appLink.queryParameters.containsKey('lat_via_0'), false);
      expect(action.fallbackLink.queryParameters['rtext'], '~55.76009,37.648801');
      expect(action.fallbackLink.queryParameters['rtt'], 'auto');
    });

    test('directionsWithCoords preserves current location before waypoints', () {
      final action = YandexNavigator.directionsWithCoords(
        destination: destination,
        waypoints: [
          YandexNavigatorWaypoint(coordinate: Coordinate(latitude: 55.745719, longitude: 37.604337)),
        ],
      );

      expect(
        action.fallbackLink.queryParameters['rtext'],
        '~55.745719,37.604337~55.76009,37.648801',
      );
    });

    test('view zoom must be between 1 and 18', () {
      expect(
        () => YandexNavigator.view(coordinate: origin, zoom: 0),
        throwsArgumentError,
      );
      expect(
        () => YandexNavigator.view(coordinate: origin, zoom: 19),
        throwsArgumentError,
      );
    });
  });
}

import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const origin = Coordinate(latitude: 37.5665, longitude: 126.9780);
  const destination = Coordinate(latitude: 37.5209436, longitude: 127.1230074);
  const waypointCoordinate = Coordinate(latitude: 37.464007, longitude: 126.9522394);
  const launchParams = NaverMapLaunchParams(
    androidAppName: 'io.github.deeplinkx.demo',
    iosAppName: 'com.example.deeplinkXExample',
  );

  group('NAVER Map actions', () {
    test('open action exposes metadata and store actions', () {
      final action = NaverMap.open(fallbackToStore: true);

      expect(action.customScheme, 'nmap');
      expect(action.androidPackageName, 'com.nhn.android.nmap');
      expect(action.website.toString(), 'https://map.naver.com/');
      expect(action.supportedPlatforms, [PlatformType.ios, PlatformType.android]);
      expect(action.macosBundleIdentifier, isNull);
      expect(action.fallbackToStore, isTrue);
      expect(action.storeActions, hasLength(2));
      expect(action, isA<App>());
      expect(action, isA<DownloadableApp>());
    });

    test('store actions resolve to the official listings', () {
      final storeActions = NaverMap().storeActions;
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;

      expect(playStoreAction.packageName, 'com.nhn.android.nmap');
      expect(playStoreAction.platform, PlatformType.android);
      expect(iosStoreAction.appId, '311867728');
      expect(iosStoreAction.appName, 'naver-maps-navigation');
      expect(iosStoreAction.platform, PlatformType.ios);
    });

    test('helper models and travel modes expose their values', () {
      // Intentionally non-const so coverage records the immutable constructors.
      // ignore: prefer_const_constructors
      final params = NaverMapLaunchParams(androidAppName: 'android.id', iosAppName: 'ios.id');
      // ignore: prefer_const_constructors
      final waypoint = NaverMapWaypoint(coordinate: waypointCoordinate, title: 'Seoul National University');

      expect(params.androidAppName, 'android.id');
      expect(params.iosAppName, 'ios.id');
      expect(waypoint.coordinate, waypointCoordinate);
      expect(waypoint.title, 'Seoul National University');
      expect(NaverMapTravelMode.driving.value, 'car');
      expect(NaverMapTravelMode.publicTransit.value, 'public');
      expect(NaverMapTravelMode.walking.value, 'walk');
      expect(NaverMapTravelMode.bicycling.value, 'bicycle');
    });

    test('named view uses a marker and platform-specific app names', () {
      final action = NaverMap.view(
        coordinate: destination,
        launchParams: launchParams,
        title: 'Olympic Park',
        zoom: 18,
        fallbackToStore: true,
      );

      expect(action, isA<MapViewAction>());
      expect(action, isA<IntentAppLinkAction>());
      expect(action, isA<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.title, 'Olympic Park');
      expect(action.zoom, 18);
      expect(action.launchParams, launchParams);
      expect(action.fallbackToStore, isTrue);
      expect(action.appLink.scheme, 'nmap');
      expect(action.appLink.host, 'place');
      expect(action.appLink.path, '');
      expect(
        action.appLink.queryParameters,
        {
          'lat': '37.5209436',
          'lng': '127.1230074',
          'name': 'Olympic Park',
          'appname': 'com.example.deeplinkXExample',
        },
      );
      expect(action.appLink.queryParameters.containsKey('zoom'), isFalse);

      final androidUri = Uri.parse(action.androidIntentOptions.data!);
      expect(androidUri.queryParameters['appname'], 'io.github.deeplinkx.demo');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.category, 'android.intent.category.BROWSABLE');
      expect(action.androidIntentOptions.package, 'com.nhn.android.nmap');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(
        action.fallbackLink.toString(),
        'https://map.naver.com/p/?lng=127.1230074&lat=37.5209436&title=Olympic+Park&zoom=18&type=0',
      );
    });

    test('coordinate-only view uses the main map and default zoom', () {
      final action = NaverMap.view(coordinate: destination, launchParams: launchParams);

      expect(action.title, isNull);
      expect(action.zoom, 16);
      expect(action.appLink.host, 'map');
      expect(
        action.appLink.queryParameters,
        {
          'lat': '37.5209436',
          'lng': '127.1230074',
          'zoom': '16',
          'appname': 'com.example.deeplinkXExample',
        },
      );
      expect(
        action.fallbackLink.toString(),
        'https://map.naver.com/p/?lng=127.1230074&lat=37.5209436&zoom=16&type=0',
      );
    });

    test('integrated search preserves the query in native and web links', () {
      final action = NaverMap.search(
        query: 'coffee & tea',
        launchParams: launchParams,
        fallbackToStore: true,
      );

      expect(action, isA<MapSearchAction>());
      expect(action.query, 'coffee & tea');
      expect(action.launchParams, launchParams);
      expect(action.fallbackToStore, isTrue);
      expect(action.appLink.host, 'search');
      expect(action.appLink.path, '');
      expect(
        action.appLink.queryParameters,
        {
          'query': 'coffee & tea',
          'appname': 'com.example.deeplinkXExample',
        },
      );
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['appname'], 'io.github.deeplinkx.demo');
      expect(action.fallbackLink.toString(), 'https://map.naver.com/p/search/coffee%20&%20tea');
    });

    test('bus search uses the documented native path and web search fallback', () {
      final action = NaverMap.busSearch(query: '222', launchParams: launchParams);

      expect(action, isA<MapSearchAction>());
      expect(action.query, '222');
      expect(action.launchParams, launchParams);
      expect(action.appLink.host, 'search');
      expect(action.appLink.path, '/bus');
      expect(
        action.appLink.queryParameters,
        {
          'query': '222',
          'appname': 'com.example.deeplinkXExample',
        },
      );
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['appname'], 'io.github.deeplinkx.demo');
      expect(action.fallbackLink.toString(), 'https://map.naver.com/p/search/222');
    });

    test('directions serialize modes, names, and ordered waypoints', () {
      final action = NaverMap.directionsWithCoords(
        origin: origin,
        originTitle: 'Seoul City Hall',
        destination: destination,
        destinationTitle: 'Olympic Park',
        waypoints: const [
          NaverMapWaypoint(coordinate: waypointCoordinate, title: 'Seoul National University'),
          NaverMapWaypoint(coordinate: Coordinate(latitude: 37.4979502, longitude: 127.0276368)),
        ],
        mode: NaverMapTravelMode.publicTransit,
        launchParams: launchParams,
        fallbackToStore: true,
      );

      expect(action, isA<MapDirectionsWithCoordsAction>());
      expect(action.destination, destination);
      expect(action.origin, origin);
      expect(action.destinationTitle, 'Olympic Park');
      expect(action.originTitle, 'Seoul City Hall');
      expect(action.waypoints, hasLength(2));
      expect(action.mode, NaverMapTravelMode.publicTransit);
      expect(action.launchParams, launchParams);
      expect(action.fallbackToStore, isTrue);
      expect(action.appLink.host, 'route');
      expect(action.appLink.path, '/public');
      expect(
        action.appLink.queryParameters,
        {
          'slat': '37.5665',
          'slng': '126.978',
          'sname': 'Seoul City Hall',
          'dlat': '37.5209436',
          'dlng': '127.1230074',
          'dname': 'Olympic Park',
          'v1lat': '37.464007',
          'v1lng': '126.9522394',
          'v1name': 'Seoul National University',
          'v2lat': '37.4979502',
          'v2lng': '127.0276368',
          'appname': 'com.example.deeplinkXExample',
        },
      );
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['appname'], 'io.github.deeplinkx.demo');
      expect(
        action.fallbackLink.toString(),
        'https://map.naver.com/p/?lng=127.1230074&lat=37.5209436&title=Olympic+Park&zoom=15&type=0',
      );
    });

    test('directions support current location and every native travel mode', () {
      for (final mode in NaverMapTravelMode.values) {
        final action = NaverMap.directionsWithCoords(
          destination: destination,
          mode: mode,
          launchParams: launchParams,
        );

        expect(action.origin, isNull);
        expect(action.destinationTitle, isNull);
        expect(action.originTitle, isNull);
        expect(action.waypoints, isEmpty);
        expect(action.appLink.path, '/${mode.value}');
        expect(action.appLink.queryParameters.containsKey('slat'), isFalse);
        expect(action.fallbackLink.queryParameters.containsKey('title'), isFalse);
      }
    });

    test('navigation uses current location, waypoints, and destination fallback', () {
      final action = NaverMap.navigate(
        destination: destination,
        destinationTitle: 'Olympic Park',
        waypoints: const [NaverMapWaypoint(coordinate: waypointCoordinate, title: 'University')],
        launchParams: launchParams,
        fallbackToStore: true,
      );

      expect(action, isA<MapDirectionsWithCoordsAction>());
      expect(action.destination, destination);
      expect(action.origin, isNull);
      expect(action.destinationTitle, 'Olympic Park');
      expect(action.originTitle, isNull);
      expect(action.waypoints.single.title, 'University');
      expect(action.launchParams, launchParams);
      expect(action.fallbackToStore, isTrue);
      expect(action.appLink.host, 'navigation');
      expect(action.appLink.path, '');
      expect(action.appLink.queryParameters['v1name'], 'University');
      expect(action.appLink.queryParameters['appname'], 'com.example.deeplinkXExample');
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['appname'], 'io.github.deeplinkx.demo');
      expect(action.fallbackLink.queryParameters['title'], 'Olympic Park');
    });

    test('navigation accepts an explicit origin', () {
      final action = NaverMap.navigate(
        origin: origin,
        originTitle: 'Seoul City Hall',
        destination: destination,
        launchParams: launchParams,
      );

      expect(action.origin, origin);
      expect(action.originTitle, 'Seoul City Hall');
      expect(action.appLink.queryParameters['sname'], 'Seoul City Hall');
    });

    test('safe driving opens native navigation and falls back to the homepage', () {
      final action = NaverMap.safeDriving(launchParams: launchParams, fallbackToStore: true);

      expect(action, isA<IntentAppLinkAction>());
      expect(action, isA<Fallbackable>());
      expect(action.launchParams, launchParams);
      expect(action.fallbackToStore, isTrue);
      expect(action.appLink.toString(), 'nmap://navigation?appname=com.example.deeplinkXExample');
      expect(
        action.androidIntentOptions.data,
        'nmap://navigation?appname=io.github.deeplinkx.demo',
      );
      expect(action.androidIntentOptions.category, 'android.intent.category.BROWSABLE');
      expect(action.fallbackLink.toString(), 'https://map.naver.com/');
    });
  });

  group('NAVER Map validation', () {
    test('rejects empty platform identifiers', () {
      expect(
        () => NaverMap.search(
          query: 'coffee',
          launchParams: const NaverMapLaunchParams(androidAppName: ' ', iosAppName: 'ios.id'),
        ),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.safeDriving(
          launchParams: const NaverMapLaunchParams(androidAppName: 'android.id', iosAppName: ''),
        ),
        throwsArgumentError,
      );
    });

    test('rejects unsupported coordinates', () {
      expect(
        () => NaverMap.view(
          coordinate: const Coordinate(latitude: 31, longitude: 127),
          launchParams: launchParams,
        ),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.view(
          coordinate: const Coordinate(latitude: 37, longitude: 133),
          launchParams: launchParams,
        ),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.directionsWithCoords(
          destination: const Coordinate(latitude: 45, longitude: 127),
          launchParams: launchParams,
        ),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.navigate(
          origin: const Coordinate(latitude: 37, longitude: 121),
          destination: destination,
          launchParams: launchParams,
        ),
        throwsArgumentError,
      );
    });

    test('rejects invalid zoom and text values', () {
      expect(
        () => NaverMap.view(coordinate: destination, title: ' ', launchParams: launchParams),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.view(coordinate: destination, zoom: 3, launchParams: launchParams),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.view(coordinate: destination, zoom: 21, launchParams: launchParams),
        throwsArgumentError,
      );
      expect(() => NaverMap.search(query: '', launchParams: launchParams), throwsArgumentError);
      expect(() => NaverMap.busSearch(query: ' ', launchParams: launchParams), throwsArgumentError);
    });

    test('rejects invalid route names and origin combinations', () {
      expect(
        () => NaverMap.directionsWithCoords(
          destination: destination,
          destinationTitle: '',
          launchParams: launchParams,
        ),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.navigate(
          destination: destination,
          origin: origin,
          originTitle: ' ',
          launchParams: launchParams,
        ),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.directionsWithCoords(
          destination: destination,
          originTitle: 'Missing origin',
          launchParams: launchParams,
        ),
        throwsArgumentError,
      );
    });

    test('rejects too many or invalid waypoints', () {
      expect(
        () => NaverMap.directionsWithCoords(
          destination: destination,
          launchParams: launchParams,
          waypoints: List.filled(6, const NaverMapWaypoint(coordinate: waypointCoordinate)),
        ),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.navigate(
          destination: destination,
          launchParams: launchParams,
          waypoints: const [NaverMapWaypoint(coordinate: Coordinate(latitude: 30, longitude: 127))],
        ),
        throwsArgumentError,
      );
      expect(
        () => NaverMap.directionsWithCoords(
          destination: destination,
          launchParams: launchParams,
          waypoints: const [NaverMapWaypoint(coordinate: waypointCoordinate, title: '')],
        ),
        throwsArgumentError,
      );
    });
  });
}

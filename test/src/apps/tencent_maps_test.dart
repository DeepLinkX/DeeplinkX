import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tencent Maps actions', () {
    const origin = Coordinate(latitude: 39.994745, longitude: 116.247282);
    const destination = Coordinate(latitude: 39.867192, longitude: 116.493187);
    const waypoint = Coordinate(latitude: 30.248015, longitude: 120.207788);
    const referer = 'test-developer-key';

    test('open action exposes metadata and the current store fallback', () {
      final action = TencentMaps.open(fallbackToStore: true);

      expect(action.customScheme, 'qqmap');
      expect(action.androidPackageName, 'com.tencent.map');
      expect(action.website.toString(), 'https://pr.map.qq.com/j/tmap/download');
      expect(action.supportedPlatforms, [PlatformType.ios, PlatformType.android]);
      expect(action.macosBundleIdentifier, isNull);
      expect(action.fallbackToStore, isTrue);
      expect(action.storeActions, hasLength(1));
      expect(action, isA<App>());
      expect(action, isA<DownloadableApp>());
    });

    test('store fallback uses the iOS App Store listing only', () {
      final storeAction = TencentMaps().storeActions.single as IOSAppStoreOpenAppPageAction;

      expect(storeAction.appId, '481623196');
      expect(storeAction.appName, 'tencent-map');
      expect(storeAction.platform, PlatformType.ios);
    });

    test('coordinate types and travel modes expose provider values', () {
      expect(TencentMapsCoordType.gps.value, '1');
      expect(TencentMapsCoordType.tencent.value, '2');
      expect(TencentMapsTravelMode.driving.value, 'drive');
      expect(TencentMapsTravelMode.transit.value, 'bus');
      expect(TencentMapsTravelMode.walking.value, 'walk');
      expect(TencentMapsTravelMode.bicycling.value, 'bike');
    });

    test('waypoint formats a native pass segment', () {
      const routeWaypoint = TencentMapsWaypoint(title: 'Metro Station', coordinate: waypoint);

      expect(routeWaypoint.title, 'Metro Station');
      expect(routeWaypoint.coordinate, waypoint);
      expect(routeWaypoint.value, 'name:Metro Station;coord:30.248015,120.207788;');
    });

    test('view creates native and web marker links', () {
      final action = TencentMaps.view(
        coordinate: destination,
        title: 'Tencent Office',
        address: 'Beijing',
        coordType: TencentMapsCoordType.gps,
        referer: referer,
        fallbackToStore: true,
      );

      expect(action, isA<MapViewAction>());
      expect(action, isA<IntentAppLinkAction>());
      expect(action, isA<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.title, 'Tencent Office');
      expect(action.address, 'Beijing');
      expect(action.coordType, TencentMapsCoordType.gps);
      expect(action.referer, referer);
      expect(action.fallbackToStore, isTrue);
      expect(action.appLink.scheme, 'qqmap');
      expect(action.appLink.host, 'map');
      expect(action.appLink.path, '/marker');
      expect(
        action.appLink.queryParameters,
        {
          'marker': 'coord:39.867192,116.493187;title:Tencent Office;addr:Beijing',
          'referer': referer,
        },
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.androidIntentOptions.package, 'com.tencent.map');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'apis.map.qq.com');
      expect(action.fallbackLink.path, '/uri/v1/marker');
      expect(
        action.fallbackLink.queryParameters,
        {
          'marker': 'coord:39.867192,116.493187;title:Tencent Office;addr:Beijing',
          'referer': referer,
          'coord_type': '1',
        },
      );
    });

    test('coordinate-only view uses native and web geocoder links', () {
      final action = TencentMaps.view(
        coordinate: destination,
        referer: referer,
      );

      expect(action.title, isNull);
      expect(action.address, isNull);
      expect(action.coordType, TencentMapsCoordType.tencent);
      expect(action.appLink.path, '/geocoder');
      expect(
        action.appLink.queryParameters,
        {
          'coord': '39.867192,116.493187',
          'referer': referer,
        },
      );
      expect(action.fallbackLink.path, '/uri/v1/geocoder');
      expect(
        action.fallbackLink.queryParameters,
        {
          'coord': '39.867192,116.493187',
          'referer': referer,
          'coord_type': '2',
        },
      );
    });

    test('view rejects incomplete marker details', () {
      expect(
        () => TencentMaps.view(
          coordinate: destination,
          title: 'Tencent Office',
          referer: referer,
        ),
        throwsArgumentError,
      );
      expect(
        () => TencentMaps.view(
          coordinate: destination,
          address: 'Beijing',
          referer: referer,
        ),
        throwsArgumentError,
      );
    });

    test('search creates native and web keyword links', () {
      final action = TencentMaps.search(
        query: 'coffee & tea',
        region: 'Shanghai',
        referer: referer,
        fallbackToStore: true,
      );

      expect(action, isA<MapSearchAction>());
      expect(action, isA<IntentAppLinkAction>());
      expect(action, isA<Fallbackable>());
      expect(action.query, 'coffee & tea');
      expect(action.region, 'Shanghai');
      expect(action.referer, referer);
      expect(action.fallbackToStore, isTrue);
      expect(action.appLink.path, '/search');
      expect(
        action.appLink.queryParameters,
        {
          'keyword': 'coffee & tea',
          'region': 'Shanghai',
          'referer': referer,
        },
      );
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink.path, '/uri/v1/search');
      expect(action.fallbackLink.queryParameters, action.appLink.queryParameters);
      expect(action.appLink.toString(), contains('coffee+%26+tea'));
    });

    test('search omits an absent region', () {
      final action = TencentMaps.search(query: 'coffee', referer: referer);

      expect(action.region, isNull);
      expect(action.appLink.queryParameters.containsKey('region'), isFalse);
    });

    test('nearby search separates native and web coordinate parameters', () {
      final action = TencentMaps.nearbySearch(
        query: 'restaurant',
        center: origin,
        radius: 800,
        coordType: TencentMapsCoordType.gps,
        referer: referer,
      );

      expect(action, isA<MapSearchAction>());
      expect(action.query, 'restaurant');
      expect(action.center, origin);
      expect(action.radius, 800);
      expect(action.coordType, TencentMapsCoordType.gps);
      expect(action.referer, referer);
      expect(
        action.appLink.queryParameters,
        {
          'keyword': 'restaurant',
          'center': '39.994745,116.247282',
          'radius': '800',
          'referer': referer,
        },
      );
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(
        action.fallbackLink.queryParameters,
        {
          'keyword': 'restaurant',
          'center': '39.994745,116.247282',
          'radius': '800',
          'referer': referer,
          'coord_type': '1',
        },
      );
    });

    test('nearby search supports the provider current-location value', () {
      final action = TencentMaps.nearbySearch(query: 'hotel', referer: referer);

      expect(action.center, isNull);
      expect(action.radius, 1000);
      expect(action.coordType, TencentMapsCoordType.tencent);
      expect(action.appLink.queryParameters['center'], 'CurrentLocation');
      expect(action.fallbackLink.queryParameters['center'], 'CurrentLocation');
      expect(action.fallbackLink.queryParameters['coord_type'], '2');
    });

    test('nearby search rejects a non-positive radius', () {
      expect(
        () => TencentMaps.nearbySearch(query: 'hotel', radius: 0, referer: referer),
        throwsArgumentError,
      );
    });

    test('directions creates distinct native and web routes', () {
      final action = TencentMaps.directionsWithCoords(
        origin: origin,
        originTitle: 'Tsinghua',
        destination: destination,
        destinationTitle: 'Community',
        destinationPoiId: '12609347545913930473',
        waypoints: const [TencentMapsWaypoint(title: 'Metro Station', coordinate: waypoint)],
        mode: TencentMapsTravelMode.transit,
        coordType: TencentMapsCoordType.gps,
        referer: referer,
        fallbackToStore: true,
      );

      expect(action, isA<MapDirectionsWithCoordsAction>());
      expect(action, isA<IntentAppLinkAction>());
      expect(action, isA<Fallbackable>());
      expect(action.origin, origin);
      expect(action.originTitle, 'Tsinghua');
      expect(action.destination, destination);
      expect(action.destinationTitle, 'Community');
      expect(action.destinationPoiId, '12609347545913930473');
      expect(action.waypoints, hasLength(1));
      expect(action.mode, TencentMapsTravelMode.transit);
      expect(action.coordType, TencentMapsCoordType.gps);
      expect(action.referer, referer);
      expect(action.fallbackToStore, isTrue);
      expect(action.appLink.path, '/routeplan');
      expect(
        action.appLink.queryParameters,
        {
          'type': 'bus',
          'from': 'Tsinghua',
          'fromcoord': '39.994745,116.247282',
          'to': 'Community',
          'tocoord': '39.867192,116.493187',
          'touid': '12609347545913930473',
          'passes': 'name:Metro Station;coord:30.248015,120.207788;|',
          'referer': referer,
        },
      );
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink.path, '/uri/v1/routeplan');
      expect(
        action.fallbackLink.queryParameters,
        {
          'type': 'bus',
          'from': 'Tsinghua',
          'fromcoord': '39.994745,116.247282',
          'to': 'Community',
          'tocoord': '39.867192,116.493187',
          'coord_type': '1',
          'referer': referer,
        },
      );
      expect(action.fallbackLink.queryParameters.containsKey('touid'), isFalse);
      expect(action.fallbackLink.queryParameters.containsKey('passes'), isFalse);
    });

    test('directions defaults to current origin and a web destination label', () {
      final action = TencentMaps.directionsWithCoords(
        destination: destination,
        referer: referer,
      );

      expect(action.origin, isNull);
      expect(action.destinationTitle, isNull);
      expect(action.originTitle, isNull);
      expect(action.destinationPoiId, isNull);
      expect(action.waypoints, isEmpty);
      expect(action.mode, TencentMapsTravelMode.driving);
      expect(action.coordType, TencentMapsCoordType.tencent);
      expect(action.appLink.queryParameters['fromcoord'], 'CurrentLocation');
      expect(action.appLink.queryParameters.containsKey('from'), isFalse);
      expect(action.appLink.queryParameters.containsKey('to'), isFalse);
      expect(action.appLink.queryParameters.containsKey('passes'), isFalse);
      expect(action.fallbackLink.queryParameters['to'], 'Destination');
      expect(action.fallbackLink.queryParameters.containsKey('fromcoord'), isFalse);
      expect(action.fallbackLink.queryParameters['coord_type'], '2');
    });

    test('bicycling uses a native route and destination-preserving web fallback', () {
      final action = TencentMaps.directionsWithCoords(
        destination: destination,
        destinationTitle: 'Community',
        mode: TencentMapsTravelMode.bicycling,
        coordType: TencentMapsCoordType.gps,
        referer: referer,
      );

      expect(action.appLink.path, '/routeplan');
      expect(action.appLink.queryParameters['type'], 'bike');
      expect(action.fallbackLink.path, '/uri/v1/geocoder');
      expect(
        action.fallbackLink.queryParameters,
        {
          'coord': '39.867192,116.493187',
          'coord_type': '1',
          'referer': referer,
        },
      );
    });

    test('directions rejects more than 15 waypoints', () {
      final waypoints = List.generate(
        16,
        (final index) => TencentMapsWaypoint(title: 'Waypoint $index', coordinate: waypoint),
      );

      expect(
        () => TencentMaps.directionsWithCoords(
          destination: destination,
          waypoints: waypoints,
          referer: referer,
        ),
        throwsArgumentError,
      );
    });

    test('all keyed actions reject an empty developer key', () {
      expect(
        () => TencentMaps.view(coordinate: destination, referer: ' '),
        throwsArgumentError,
      );
      expect(
        () => TencentMaps.search(query: 'coffee', referer: ''),
        throwsArgumentError,
      );
      expect(
        () => TencentMaps.nearbySearch(query: 'coffee', referer: ''),
        throwsArgumentError,
      );
      expect(
        () => TencentMaps.directionsWithCoords(destination: destination, referer: ''),
        throwsArgumentError,
      );
    });
  });
}

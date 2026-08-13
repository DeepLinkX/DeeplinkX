import 'package:deeplink_x/src/src.dart';

/// Map layers supported by Mapy.com URL actions.
enum MapyCzMapSet {
  /// Standard road map.
  basic('basic'),

  /// Outdoor and hiking map.
  outdoor('outdoor'),

  /// Winter sports map.
  winter('winter'),

  /// Aerial imagery.
  aerial('aerial'),

  /// Traffic map.
  traffic('traffic');

  const MapyCzMapSet(this.value);

  /// Provider query value.
  final String value;
}

/// Route planning modes supported by Mapy.com URL actions.
enum MapyCzRouteType {
  /// Fastest route by car.
  carFast('car_fast'),

  /// Fastest route by car using live traffic.
  carFastTraffic('car_fast_traffic'),

  /// Shortest route by car.
  carShort('car_short'),

  /// Fast walking route.
  footFast('foot_fast'),

  /// Hiking route.
  footHiking('foot_hiking'),

  /// Road cycling route.
  bikeRoad('bike_road'),

  /// Mountain biking route.
  bikeMountain('bike_mountain');

  const MapyCzRouteType(this.value);

  /// Provider query value.
  final String value;
}

/// Mapy.com (formerly Mapy.cz) navigation app for iOS and Android.
class MapyCz extends App implements DownloadableApp {
  /// Creates a new [MapyCz] instance.
  MapyCz({this.fallbackToStore = false});

  /// Creates an action to open Mapy.com (use with `launchApp`).
  factory MapyCz.open({final bool fallbackToStore = false}) => MapyCz(fallbackToStore: fallbackToStore);

  /// Store actions for Mapy.com.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'cz.seznam.mapy'),
        IOSAppStore.openAppPage(appId: '411411020', appName: 'mapy-com-offline-maps-gps'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'cz.seznam.mapy';

  /// Custom scheme used for installation checks on iOS.
  @override
  String get customScheme => 'szn-mapy';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fall back to stores if the app is missing.
  @override
  bool fallbackToStore;

  /// Mapy.com web fallback.
  @override
  Uri get website => Uri.parse('https://mapy.com/');

  /// Creates an action that shows [coordinate] on Mapy.com.
  static MapyCzViewAction view({
    required final Coordinate coordinate,
    final int zoom = 16,
    final MapyCzMapSet mapSet = MapyCzMapSet.basic,
    final bool marker = true,
    final bool fallbackToStore = false,
  }) =>
      MapyCzViewAction(
        coordinate: coordinate,
        zoom: zoom,
        mapSet: mapSet,
        marker: marker,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a Mapy.com search action.
  static MapyCzSearchAction search({
    required final String query,
    final Coordinate? center,
    final int? zoom,
    final MapyCzMapSet mapSet = MapyCzMapSet.basic,
    final bool fallbackToStore = false,
  }) {
    _validateQuery(query);
    return MapyCzSearchAction(
      query: query,
      center: center,
      zoom: zoom,
      mapSet: mapSet,
      fallbackToStore: fallbackToStore,
    );
  }

  /// Creates an action that plans a route to [destination].
  static MapyCzDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final List<Coordinate> waypoints = const [],
    final MapyCzRouteType routeType = MapyCzRouteType.carFast,
    final MapyCzMapSet mapSet = MapyCzMapSet.basic,
    final bool navigate = false,
    final bool fallbackToStore = false,
  }) {
    _validateWaypoints(waypoints);
    return MapyCzDirectionsWithCoordsAction(
      destination: destination,
      origin: origin,
      waypoints: waypoints,
      routeType: routeType,
      mapSet: mapSet,
      navigate: navigate,
      fallbackToStore: fallbackToStore,
    );
  }
}

/// Mapy.com show-coordinate action.
class MapyCzViewAction extends MapyCz implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [MapyCzViewAction].
  MapyCzViewAction({
    required this.coordinate,
    required this.zoom,
    required this.mapSet,
    required this.marker,
    required super.fallbackToStore,
  });

  /// Coordinate to show on the map.
  @override
  final Coordinate coordinate;

  /// Map zoom level.
  final int zoom;

  /// Map layer to display.
  final MapyCzMapSet mapSet;

  /// Whether to display a marker at [coordinate].
  final bool marker;

  @override
  Uri get appLink => _mapyUri(
        'showmap',
        {
          'mapset': mapSet.value,
          'center': _longitudeLatitude(coordinate),
          'zoom': zoom.toString(),
          'marker': marker.toString(),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => appLink;
}

/// Mapy.com text-search action.
class MapyCzSearchAction extends MapyCz
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapSearchAction {
  /// Creates a new [MapyCzSearchAction].
  MapyCzSearchAction({
    required this.query,
    required this.center,
    required this.zoom,
    required this.mapSet,
    required super.fallbackToStore,
  });

  /// Search query.
  @override
  final String query;

  /// Optional search center.
  final Coordinate? center;

  /// Optional map zoom level.
  final int? zoom;

  /// Map layer to display.
  final MapyCzMapSet mapSet;

  @override
  Uri get appLink => _mapyUri(
        'search',
        {
          'mapset': mapSet.value,
          'query': query,
          if (center != null) 'center': _longitudeLatitude(center!),
          if (zoom != null) 'zoom': zoom.toString(),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => appLink;
}

/// Mapy.com coordinate-route action.
class MapyCzDirectionsWithCoordsAction extends MapyCz
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [MapyCzDirectionsWithCoordsAction].
  MapyCzDirectionsWithCoordsAction({
    required this.destination,
    required this.origin,
    required this.waypoints,
    required this.routeType,
    required this.mapSet,
    required this.navigate,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional intermediate coordinates, up to 15.
  final List<Coordinate> waypoints;

  /// Route planning mode.
  final MapyCzRouteType routeType;

  /// Map layer to display.
  final MapyCzMapSet mapSet;

  /// Whether to start navigation immediately in supported app versions.
  final bool navigate;

  @override
  Uri get appLink => _mapyUri(
        'route',
        {
          'mapset': mapSet.value,
          if (origin != null) 'start': _longitudeLatitude(origin!),
          'end': _longitudeLatitude(destination),
          'routeType': routeType.value,
          if (waypoints.isNotEmpty) 'waypoints': waypoints.map(_longitudeLatitude).join(';'),
          if (navigate) 'navigate': 'true',
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => appLink;
}

String _longitudeLatitude(final Coordinate coordinate) => '${coordinate.longitude},${coordinate.latitude}';

Uri _mapyUri(final String function, final Map<String, String> queryParameters) => Uri(
      scheme: 'https',
      host: 'mapy.com',
      path: '/fnc/v1/$function',
      queryParameters: queryParameters,
    );

AndroidIntentOption _intentOptions(final Uri appLink) => AndroidIntentOption(
      action: 'action_view',
      data: appLink.toString(),
      package: 'cz.seznam.mapy',
      flags: const [0x10000000],
    );

void _validateQuery(final String query) {
  if (query.trim().isEmpty) {
    throw ArgumentError.value(query, 'query', 'must not be blank');
  }
}

void _validateWaypoints(final List<Coordinate> waypoints) {
  if (waypoints.length > 15) {
    throw ArgumentError.value(waypoints, 'waypoints', 'must contain at most 15 items');
  }
}

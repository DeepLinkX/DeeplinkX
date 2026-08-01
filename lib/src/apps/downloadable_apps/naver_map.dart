import 'package:deeplink_x/src/src.dart';

const _androidBrowsableCategory = 'android.intent.category.BROWSABLE';
const _newTaskFlag = 0x10000000;
const _minimumLatitude = 31.43;
const _maximumLatitude = 44.35;
const _minimumLongitude = 122.37;
const _maximumLongitude = 132.00;

/// NAVER Map app for iOS and Android.
class NaverMap extends App implements DownloadableApp {
  /// Creates a new [NaverMap] instance.
  NaverMap({this.fallbackToStore = false});

  /// Creates an action to open NAVER Map.
  factory NaverMap.open({final bool fallbackToStore = false}) => NaverMap(fallbackToStore: fallbackToStore);

  /// Store actions for NAVER Map.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.nhn.android.nmap'),
        IOSAppStore.openAppPage(appId: '311867728', appName: 'naver-maps-navigation'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.nhn.android.nmap';

  /// Custom scheme.
  @override
  String get customScheme => 'nmap';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// NAVER Map website.
  @override
  Uri get website => Uri.parse('https://map.naver.com/');

  /// Creates an action that shows [coordinate] in NAVER Map.
  ///
  /// When [title] is supplied, NAVER Map displays a marker. Otherwise it
  /// centers the main map at [coordinate].
  static NaverMapViewAction view({
    required final Coordinate coordinate,
    required final NaverMapLaunchParams launchParams,
    final String? title,
    final int zoom = 16,
    final bool fallbackToStore = false,
  }) {
    _validateLaunchParams(launchParams);
    _validateCoordinate(coordinate, 'coordinate');
    _validateOptionalText(title, 'title');
    _validateZoom(zoom);
    return NaverMapViewAction(
      coordinate: coordinate,
      launchParams: launchParams,
      fallbackToStore: fallbackToStore,
      title: title,
      zoom: zoom,
    );
  }

  /// Creates an integrated map search action.
  static NaverMapSearchAction search({
    required final String query,
    required final NaverMapLaunchParams launchParams,
    final bool fallbackToStore = false,
  }) {
    _validateLaunchParams(launchParams);
    _validateRequiredText(query, 'query');
    return NaverMapSearchAction(
      query: query,
      launchParams: launchParams,
      fallbackToStore: fallbackToStore,
    );
  }

  /// Creates a bus-number search action.
  static NaverMapBusSearchAction busSearch({
    required final String query,
    required final NaverMapLaunchParams launchParams,
    final bool fallbackToStore = false,
  }) {
    _validateLaunchParams(launchParams);
    _validateRequiredText(query, 'query');
    return NaverMapBusSearchAction(
      query: query,
      launchParams: launchParams,
      fallbackToStore: fallbackToStore,
    );
  }

  /// Creates a coordinate route-planning action.
  static NaverMapDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    required final NaverMapLaunchParams launchParams,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final List<NaverMapWaypoint> waypoints = const [],
    final NaverMapTravelMode mode = NaverMapTravelMode.driving,
    final bool fallbackToStore = false,
  }) {
    _validateRoute(
      destination: destination,
      launchParams: launchParams,
      origin: origin,
      destinationTitle: destinationTitle,
      originTitle: originTitle,
      waypoints: waypoints,
    );
    return NaverMapDirectionsWithCoordsAction(
      destination: destination,
      launchParams: launchParams,
      mode: mode,
      fallbackToStore: fallbackToStore,
      origin: origin,
      destinationTitle: destinationTitle,
      originTitle: originTitle,
      waypoints: waypoints,
    );
  }

  /// Creates a turn-by-turn navigation action.
  static NaverMapNavigationAction navigate({
    required final Coordinate destination,
    required final NaverMapLaunchParams launchParams,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final List<NaverMapWaypoint> waypoints = const [],
    final bool fallbackToStore = false,
  }) {
    _validateRoute(
      destination: destination,
      launchParams: launchParams,
      origin: origin,
      destinationTitle: destinationTitle,
      originTitle: originTitle,
      waypoints: waypoints,
    );
    return NaverMapNavigationAction(
      destination: destination,
      launchParams: launchParams,
      fallbackToStore: fallbackToStore,
      origin: origin,
      destinationTitle: destinationTitle,
      originTitle: originTitle,
      waypoints: waypoints,
    );
  }

  /// Opens NAVER Map navigation in safe-driving mode.
  static NaverMapSafeDrivingAction safeDriving({
    required final NaverMapLaunchParams launchParams,
    final bool fallbackToStore = false,
  }) {
    _validateLaunchParams(launchParams);
    return NaverMapSafeDrivingAction(
      launchParams: launchParams,
      fallbackToStore: fallbackToStore,
    );
  }
}

/// Platform-specific identifiers required by every NAVER Map action URL.
class NaverMapLaunchParams {
  /// Creates NAVER Map launch parameters.
  const NaverMapLaunchParams({
    required this.androidAppName,
    required this.iosAppName,
  });

  /// Calling Android app's application ID.
  final String androidAppName;

  /// Calling iOS app's bundle ID.
  final String iosAppName;
}

/// NAVER Map route modes.
enum NaverMapTravelMode {
  /// Driving route.
  driving('car'),

  /// Public-transit route.
  publicTransit('public'),

  /// Walking route.
  walking('walk'),

  /// Bicycling route.
  bicycling('bicycle');

  /// Creates a NAVER Map travel mode.
  const NaverMapTravelMode(this.value);

  /// Provider route path value.
  final String value;
}

/// A waypoint used by NAVER Map route and navigation actions.
class NaverMapWaypoint {
  /// Creates a NAVER Map waypoint.
  const NaverMapWaypoint({required this.coordinate, this.title});

  /// Waypoint coordinate.
  final Coordinate coordinate;

  /// Optional waypoint name.
  final String? title;
}

/// Shows a coordinate or named marker in NAVER Map.
class NaverMapViewAction extends NaverMap implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a [NaverMapViewAction].
  NaverMapViewAction({
    required this.coordinate,
    required this.launchParams,
    required this.zoom,
    required super.fallbackToStore,
    this.title,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Optional marker title.
  final String? title;

  /// Map zoom level used for map centering and web fallback.
  final int zoom;

  /// Calling-app identifiers.
  final NaverMapLaunchParams launchParams;

  bool get _usesMarker => title != null;

  Map<String, String> _nativeQueryParameters(final String appName) => {
        'lat': coordinate.latitude.toString(),
        'lng': coordinate.longitude.toString(),
        if (_usesMarker) 'name': title! else 'zoom': zoom.toString(),
        'appname': appName,
      };

  Uri _nativeUri(final String appName) => _naverUri(
        _usesMarker ? 'place' : 'map',
        _nativeQueryParameters(appName),
      );

  @override
  Uri get appLink => _nativeUri(launchParams.iosAppName);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(
        _nativeUri(launchParams.androidAppName),
      );

  @override
  Uri get fallbackLink => _naverWebCoordinateUri(
        coordinate,
        title: title,
        zoom: zoom,
      );
}

/// Searches NAVER Map by keyword.
class NaverMapSearchAction extends NaverMap implements IntentAppLinkAction, Fallbackable, MapSearchAction {
  /// Creates a [NaverMapSearchAction].
  NaverMapSearchAction({
    required this.query,
    required this.launchParams,
    required super.fallbackToStore,
  });

  /// Search query.
  @override
  final String query;

  /// Calling-app identifiers.
  final NaverMapLaunchParams launchParams;

  Uri _nativeUri(final String appName) => _naverUri('search', {
        'query': query,
        'appname': appName,
      });

  @override
  Uri get appLink => _nativeUri(launchParams.iosAppName);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(
        _nativeUri(launchParams.androidAppName),
      );

  @override
  Uri get fallbackLink => _naverWebSearchUri(query);
}

/// Searches NAVER Map by bus number.
class NaverMapBusSearchAction extends NaverMap implements IntentAppLinkAction, Fallbackable, MapSearchAction {
  /// Creates a [NaverMapBusSearchAction].
  NaverMapBusSearchAction({
    required this.query,
    required this.launchParams,
    required super.fallbackToStore,
  });

  /// Bus-number query.
  @override
  final String query;

  /// Calling-app identifiers.
  final NaverMapLaunchParams launchParams;

  Uri _nativeUri(final String appName) => _naverUri(
        'search',
        {
          'query': query,
          'appname': appName,
        },
        path: 'bus',
      );

  @override
  Uri get appLink => _nativeUri(launchParams.iosAppName);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(
        _nativeUri(launchParams.androidAppName),
      );

  @override
  Uri get fallbackLink => _naverWebSearchUri(query);
}

/// Builds a coordinate route in NAVER Map.
class NaverMapDirectionsWithCoordsAction extends NaverMap
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a [NaverMapDirectionsWithCoordsAction].
  NaverMapDirectionsWithCoordsAction({
    required this.destination,
    required this.launchParams,
    required this.mode,
    required super.fallbackToStore,
    this.origin,
    this.destinationTitle,
    this.originTitle,
    this.waypoints = const [],
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate. NAVER Map uses current location when omitted.
  final Coordinate? origin;

  /// Optional destination name.
  final String? destinationTitle;

  /// Optional origin name.
  final String? originTitle;

  /// Ordered route waypoints, up to five.
  final List<NaverMapWaypoint> waypoints;

  /// Route mode.
  final NaverMapTravelMode mode;

  /// Calling-app identifiers.
  final NaverMapLaunchParams launchParams;

  Uri _nativeUri(final String appName) => _naverUri(
        'route',
        _routeQueryParameters(
          destination: destination,
          appName: appName,
          origin: origin,
          destinationTitle: destinationTitle,
          originTitle: originTitle,
          waypoints: waypoints,
        ),
        path: mode.value,
      );

  @override
  Uri get appLink => _nativeUri(launchParams.iosAppName);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(
        _nativeUri(launchParams.androidAppName),
      );

  @override
  Uri get fallbackLink => _naverWebCoordinateUri(
        destination,
        title: destinationTitle,
      );
}

/// Starts turn-by-turn navigation in NAVER Map.
class NaverMapNavigationAction extends NaverMap
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a [NaverMapNavigationAction].
  NaverMapNavigationAction({
    required this.destination,
    required this.launchParams,
    required super.fallbackToStore,
    this.origin,
    this.destinationTitle,
    this.originTitle,
    this.waypoints = const [],
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate. NAVER Map uses current location when omitted.
  final Coordinate? origin;

  /// Optional destination name.
  final String? destinationTitle;

  /// Optional origin name.
  final String? originTitle;

  /// Ordered navigation waypoints, up to five.
  final List<NaverMapWaypoint> waypoints;

  /// Calling-app identifiers.
  final NaverMapLaunchParams launchParams;

  Uri _nativeUri(final String appName) => _naverUri(
        'navigation',
        _routeQueryParameters(
          destination: destination,
          appName: appName,
          origin: origin,
          destinationTitle: destinationTitle,
          originTitle: originTitle,
          waypoints: waypoints,
        ),
      );

  @override
  Uri get appLink => _nativeUri(launchParams.iosAppName);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(
        _nativeUri(launchParams.androidAppName),
      );

  @override
  Uri get fallbackLink => _naverWebCoordinateUri(
        destination,
        title: destinationTitle,
      );
}

/// Opens NAVER Map navigation in safe-driving mode.
class NaverMapSafeDrivingAction extends NaverMap implements IntentAppLinkAction, Fallbackable {
  /// Creates a [NaverMapSafeDrivingAction].
  NaverMapSafeDrivingAction({
    required this.launchParams,
    required super.fallbackToStore,
  });

  /// Calling-app identifiers.
  final NaverMapLaunchParams launchParams;

  Uri _nativeUri(final String appName) => _naverUri('navigation', {
        'appname': appName,
      });

  @override
  Uri get appLink => _nativeUri(launchParams.iosAppName);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(
        _nativeUri(launchParams.androidAppName),
      );

  @override
  Uri get fallbackLink => website;
}

Map<String, String> _routeQueryParameters({
  required final Coordinate destination,
  required final String appName,
  required final Coordinate? origin,
  required final String? destinationTitle,
  required final String? originTitle,
  required final List<NaverMapWaypoint> waypoints,
}) {
  final queryParameters = <String, String>{
    if (origin != null) 'slat': origin.latitude.toString(),
    if (origin != null) 'slng': origin.longitude.toString(),
    if (originTitle != null) 'sname': originTitle,
    'dlat': destination.latitude.toString(),
    'dlng': destination.longitude.toString(),
    if (destinationTitle != null) 'dname': destinationTitle,
  };
  for (var index = 0; index < waypoints.length; index++) {
    final waypoint = waypoints[index];
    final number = index + 1;
    queryParameters
      ..['v${number}lat'] = waypoint.coordinate.latitude.toString()
      ..['v${number}lng'] = waypoint.coordinate.longitude.toString();
    if (waypoint.title != null) {
      queryParameters['v${number}name'] = waypoint.title!;
    }
  }
  queryParameters['appname'] = appName;
  return queryParameters;
}

Uri _naverUri(
  final String host,
  final Map<String, String> queryParameters, {
  final String? path,
}) =>
    Uri(
      scheme: 'nmap',
      host: host,
      path: path == null ? '' : '/$path',
      queryParameters: queryParameters,
    );

AndroidIntentOption _androidIntentOptions(final Uri uri) => AndroidIntentOption(
      action: 'action_view',
      category: _androidBrowsableCategory,
      data: uri.toString(),
      package: 'com.nhn.android.nmap',
      flags: const [_newTaskFlag],
    );

Uri _naverWebCoordinateUri(
  final Coordinate coordinate, {
  final String? title,
  final int zoom = 15,
}) =>
    Uri(
      scheme: 'https',
      host: 'map.naver.com',
      path: '/p/',
      queryParameters: {
        'lng': coordinate.longitude.toString(),
        'lat': coordinate.latitude.toString(),
        if (title != null) 'title': title,
        'zoom': zoom.toString(),
        'type': '0',
      },
    );

Uri _naverWebSearchUri(final String query) => Uri(
      scheme: 'https',
      host: 'map.naver.com',
      pathSegments: ['p', 'search', query],
    );

void _validateRoute({
  required final Coordinate destination,
  required final NaverMapLaunchParams launchParams,
  required final Coordinate? origin,
  required final String? destinationTitle,
  required final String? originTitle,
  required final List<NaverMapWaypoint> waypoints,
}) {
  _validateLaunchParams(launchParams);
  _validateCoordinate(destination, 'destination');
  if (origin != null) {
    _validateCoordinate(origin, 'origin');
  }
  _validateOptionalText(destinationTitle, 'destinationTitle');
  _validateOptionalText(originTitle, 'originTitle');
  if (originTitle != null && origin == null) {
    throw ArgumentError('originTitle requires origin coordinates');
  }
  if (waypoints.length > 5) {
    throw ArgumentError.value(waypoints.length, 'waypoints', 'NAVER Map supports at most five waypoints');
  }
  for (var index = 0; index < waypoints.length; index++) {
    final waypoint = waypoints[index];
    _validateCoordinate(waypoint.coordinate, 'waypoints[$index].coordinate');
    _validateOptionalText(waypoint.title, 'waypoints[$index].title');
  }
}

void _validateLaunchParams(final NaverMapLaunchParams launchParams) {
  _validateRequiredText(launchParams.androidAppName, 'launchParams.androidAppName');
  _validateRequiredText(launchParams.iosAppName, 'launchParams.iosAppName');
}

void _validateCoordinate(final Coordinate coordinate, final String name) {
  if (coordinate.latitude < _minimumLatitude || coordinate.latitude > _maximumLatitude) {
    throw ArgumentError.value(
      coordinate.latitude,
      '$name.latitude',
      'must be between $_minimumLatitude and $_maximumLatitude for NAVER Map URLs',
    );
  }
  if (coordinate.longitude < _minimumLongitude || coordinate.longitude > _maximumLongitude) {
    throw ArgumentError.value(
      coordinate.longitude,
      '$name.longitude',
      'must be between $_minimumLongitude and $_maximumLongitude for NAVER Map URLs',
    );
  }
}

void _validateZoom(final int zoom) {
  if (zoom < 4 || zoom > 20) {
    throw ArgumentError.value(zoom, 'zoom', 'must be between 4 and 20 for NAVER Map URLs');
  }
}

void _validateRequiredText(final String value, final String name) {
  if (value.trim().isEmpty) {
    throw ArgumentError.value(value, name, 'must not be empty');
  }
}

void _validateOptionalText(final String? value, final String name) {
  if (value != null) {
    _validateRequiredText(value, name);
  }
}

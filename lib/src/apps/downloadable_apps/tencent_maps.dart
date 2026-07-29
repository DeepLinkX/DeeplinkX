import 'package:deeplink_x/src/src.dart';

const _currentLocation = 'CurrentLocation';
const _newTaskFlag = 0x10000000;

/// Tencent Maps app for iOS and Android.
class TencentMaps extends App implements DownloadableApp {
  /// Creates a new [TencentMaps] instance.
  TencentMaps({this.fallbackToStore = false});

  /// Creates an action to open Tencent Maps.
  factory TencentMaps.open({final bool fallbackToStore = false}) => TencentMaps(fallbackToStore: fallbackToStore);

  /// Store actions for Tencent Maps.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        IOSAppStore.openAppPage(appId: '481623196', appName: 'tencent-map'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.tencent.map';

  /// Custom scheme.
  @override
  String get customScheme => 'qqmap';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// Official Tencent Maps cross-platform download page.
  @override
  Uri get website => Uri.parse('https://pr.map.qq.com/j/tmap/download');

  /// Creates an action that displays [coordinate] on the map.
  ///
  /// Supply both [title] and [address] to show a custom marker. Omit both to
  /// let Tencent Maps reverse-geocode the coordinate.
  static TencentMapsViewAction view({
    required final Coordinate coordinate,
    required final String referer,
    final String? title,
    final String? address,
    final TencentMapsCoordType coordType = TencentMapsCoordType.tencent,
    final bool fallbackToStore = false,
  }) {
    _validateReferer(referer);
    _validateMarkerDetails(title: title, address: address);
    return TencentMapsViewAction(
      coordinate: coordinate,
      referer: referer,
      coordType: coordType,
      fallbackToStore: fallbackToStore,
      title: title,
      address: address,
    );
  }

  /// Creates an action that searches by keyword and optional city.
  static TencentMapsSearchAction search({
    required final String query,
    required final String referer,
    final String? region,
    final bool fallbackToStore = false,
  }) {
    _validateReferer(referer);
    return TencentMapsSearchAction(
      query: query,
      referer: referer,
      fallbackToStore: fallbackToStore,
      region: region,
    );
  }

  /// Creates an action that searches near [center], or current location.
  static TencentMapsNearbySearchAction nearbySearch({
    required final String query,
    required final String referer,
    final Coordinate? center,
    final int radius = 1000,
    final TencentMapsCoordType coordType = TencentMapsCoordType.tencent,
    final bool fallbackToStore = false,
  }) {
    _validateReferer(referer);
    _validateRadius(radius);
    return TencentMapsNearbySearchAction(
      query: query,
      referer: referer,
      radius: radius,
      coordType: coordType,
      fallbackToStore: fallbackToStore,
      center: center,
    );
  }

  /// Creates a coordinate route planning action.
  static TencentMapsDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    required final String referer,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final String? destinationPoiId,
    final List<TencentMapsWaypoint> waypoints = const [],
    final TencentMapsTravelMode mode = TencentMapsTravelMode.driving,
    final TencentMapsCoordType coordType = TencentMapsCoordType.tencent,
    final bool fallbackToStore = false,
  }) {
    _validateReferer(referer);
    _validateWaypoints(waypoints);
    return TencentMapsDirectionsWithCoordsAction(
      destination: destination,
      referer: referer,
      mode: mode,
      coordType: coordType,
      fallbackToStore: fallbackToStore,
      origin: origin,
      destinationTitle: destinationTitle,
      originTitle: originTitle,
      destinationPoiId: destinationPoiId,
      waypoints: waypoints,
    );
  }
}

/// Tencent Maps coordinate type.
enum TencentMapsCoordType {
  /// GPS coordinates.
  gps('1'),

  /// Tencent Maps coordinates.
  tencent('2');

  /// Creates a new [TencentMapsCoordType].
  const TencentMapsCoordType(this.value);

  /// URI value.
  final String value;
}

/// Tencent Maps route modes.
enum TencentMapsTravelMode {
  /// Driving route.
  driving('drive'),

  /// Public transit route.
  transit('bus'),

  /// Walking route.
  walking('walk'),

  /// Bicycling route.
  bicycling('bike');

  /// Creates a new [TencentMapsTravelMode].
  const TencentMapsTravelMode(this.value);

  /// URI value.
  final String value;
}

/// A Tencent Maps route waypoint.
class TencentMapsWaypoint {
  /// Creates a new [TencentMapsWaypoint].
  const TencentMapsWaypoint({
    required this.title,
    required this.coordinate,
  });

  /// Waypoint name.
  final String title;

  /// Waypoint coordinate.
  final Coordinate coordinate;

  /// URI value before the provider-required pipe separator.
  String get value => 'name:$title;coord:${_latLng(coordinate)};';
}

/// Displays a marker or reverse-geocoded coordinate in Tencent Maps.
class TencentMapsViewAction extends TencentMaps implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [TencentMapsViewAction].
  TencentMapsViewAction({
    required this.coordinate,
    required this.referer,
    required this.coordType,
    required super.fallbackToStore,
    this.title,
    this.address,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Optional marker title.
  final String? title;

  /// Optional marker address.
  final String? address;

  /// Coordinate type used by the web fallback.
  final TencentMapsCoordType coordType;

  /// Tencent developer key.
  final String referer;

  bool get _usesMarker => title != null;

  String get _marker => [
        'coord:${_latLng(coordinate)}',
        'title:$title',
        'addr:$address',
      ].join(';');

  Map<String, String> get _nativeQueryParameters => {
        if (_usesMarker) 'marker': _marker else 'coord': _latLng(coordinate),
        'referer': referer,
      };

  Map<String, String> get _webQueryParameters => {
        ..._nativeQueryParameters,
        'coord_type': coordType.value,
      };

  String get _path => _usesMarker ? 'marker' : 'geocoder';

  @override
  Uri get appLink => _tencentMapsUri(_path, _nativeQueryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => _tencentWebUri(_path, _webQueryParameters);
}

/// Searches Tencent Maps by keyword and optional city region.
class TencentMapsSearchAction extends TencentMaps implements IntentAppLinkAction, Fallbackable, MapSearchAction {
  /// Creates a new [TencentMapsSearchAction].
  TencentMapsSearchAction({
    required this.query,
    required this.referer,
    required super.fallbackToStore,
    this.region,
  });

  /// Search query.
  @override
  final String query;

  /// Optional city region.
  final String? region;

  /// Tencent developer key.
  final String referer;

  Map<String, String> get _queryParameters => {
        'keyword': query,
        if (region != null) 'region': region!,
        'referer': referer,
      };

  @override
  Uri get appLink => _tencentMapsUri('search', _queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => _tencentWebUri('search', _queryParameters);
}

/// Searches Tencent Maps near a coordinate or the current location.
class TencentMapsNearbySearchAction extends TencentMaps implements IntentAppLinkAction, Fallbackable, MapSearchAction {
  /// Creates a new [TencentMapsNearbySearchAction].
  TencentMapsNearbySearchAction({
    required this.query,
    required this.referer,
    required this.radius,
    required this.coordType,
    required super.fallbackToStore,
    this.center,
  });

  /// Search query.
  @override
  final String query;

  /// Optional search center. When null, Tencent Maps uses current location.
  final Coordinate? center;

  /// Search radius in meters.
  final int radius;

  /// Coordinate type used by the web fallback.
  final TencentMapsCoordType coordType;

  /// Tencent developer key.
  final String referer;

  Map<String, String> get _nativeQueryParameters => {
        'keyword': query,
        'center': center == null ? _currentLocation : _latLng(center!),
        'radius': radius.toString(),
        'referer': referer,
      };

  Map<String, String> get _webQueryParameters => {
        ..._nativeQueryParameters,
        'coord_type': coordType.value,
      };

  @override
  Uri get appLink => _tencentMapsUri('search', _nativeQueryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => _tencentWebUri('search', _webQueryParameters);
}

/// Builds a coordinate route in Tencent Maps.
class TencentMapsDirectionsWithCoordsAction extends TencentMaps
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [TencentMapsDirectionsWithCoordsAction].
  TencentMapsDirectionsWithCoordsAction({
    required this.destination,
    required this.referer,
    required this.mode,
    required this.coordType,
    required super.fallbackToStore,
    this.origin,
    this.destinationTitle,
    this.originTitle,
    this.destinationPoiId,
    this.waypoints = const [],
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate. When null, Tencent Maps uses current location.
  final Coordinate? origin;

  /// Optional destination title.
  final String? destinationTitle;

  /// Optional origin title.
  final String? originTitle;

  /// Optional destination POI ID used by the native app.
  final String? destinationPoiId;

  /// Optional native waypoints, up to 15.
  final List<TencentMapsWaypoint> waypoints;

  /// Route mode.
  final TencentMapsTravelMode mode;

  /// Coordinate type used by the web fallback.
  final TencentMapsCoordType coordType;

  /// Tencent developer key.
  final String referer;

  Map<String, String> get _nativeQueryParameters => {
        'type': mode.value,
        if (originTitle != null) 'from': originTitle!,
        'fromcoord': origin == null ? _currentLocation : _latLng(origin!),
        if (destinationTitle != null) 'to': destinationTitle!,
        'tocoord': _latLng(destination),
        if (destinationPoiId != null) 'touid': destinationPoiId!,
        if (waypoints.isNotEmpty) 'passes': '${waypoints.map((final waypoint) => waypoint.value).join('|')}|',
        'referer': referer,
      };

  Map<String, String> get _webRouteQueryParameters => {
        'type': mode.value,
        if (origin != null && originTitle != null) 'from': originTitle!,
        if (origin != null) 'fromcoord': _latLng(origin!),
        'to': destinationTitle ?? 'Destination',
        'tocoord': _latLng(destination),
        'coord_type': coordType.value,
        'referer': referer,
      };

  Map<String, String> get _webDestinationQueryParameters => {
        'coord': _latLng(destination),
        'coord_type': coordType.value,
        'referer': referer,
      };

  @override
  Uri get appLink => _tencentMapsUri('routeplan', _nativeQueryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => mode == TencentMapsTravelMode.bicycling
      ? _tencentWebUri('geocoder', _webDestinationQueryParameters)
      : _tencentWebUri('routeplan', _webRouteQueryParameters);
}

String _latLng(final Coordinate coordinate) => '${coordinate.latitude},${coordinate.longitude}';

Uri _tencentMapsUri(final String path, final Map<String, String> queryParameters) => Uri(
      scheme: 'qqmap',
      host: 'map',
      path: '/$path',
      queryParameters: queryParameters,
    );

Uri _tencentWebUri(final String path, final Map<String, String> queryParameters) => Uri(
      scheme: 'https',
      host: 'apis.map.qq.com',
      path: '/uri/v1/$path',
      queryParameters: queryParameters,
    );

AndroidIntentOption _intentOptions(final Uri appLink) => AndroidIntentOption(
      action: 'action_view',
      data: appLink.toString(),
      package: 'com.tencent.map',
      flags: const [_newTaskFlag],
    );

void _validateReferer(final String referer) {
  if (referer.trim().isEmpty) {
    throw ArgumentError.value(referer, 'referer', 'must be a non-empty Tencent developer key');
  }
}

void _validateMarkerDetails({required final String? title, required final String? address}) {
  if ((title == null) != (address == null)) {
    throw ArgumentError('title and address must either both be provided or both be omitted');
  }
}

void _validateRadius(final int radius) {
  if (radius <= 0) {
    throw ArgumentError.value(radius, 'radius', 'must be greater than zero');
  }
}

void _validateWaypoints(final List<TencentMapsWaypoint> waypoints) {
  if (waypoints.length > 15) {
    throw ArgumentError.value(waypoints, 'waypoints', 'must contain at most 15 items');
  }
}

import 'package:deeplink_x/src/src.dart';

const _defaultReferer = 'deeplink_x';
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
        PlayStore.openAppPage(packageName: 'com.tencent.map'),
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

  /// Tencent Maps website.
  @override
  Uri get website => Uri.parse('https://map.qq.com');

  /// Creates an action that marks [coordinate] on the map.
  static TencentMapsViewAction view({
    required final Coordinate coordinate,
    final String title = 'Location',
    final String? address,
    final TencentMapsCoordType coordType = TencentMapsCoordType.tencent,
    final String referer = _defaultReferer,
    final bool fallbackToStore = false,
  }) =>
      TencentMapsViewAction(
        coordinate: coordinate,
        title: title,
        coordType: coordType,
        referer: referer,
        fallbackToStore: fallbackToStore,
        address: address,
      );

  /// Creates an action that searches by keyword and optional city.
  static TencentMapsSearchAction search({
    required final String query,
    final String? region,
    final String referer = _defaultReferer,
    final bool fallbackToStore = false,
  }) =>
      TencentMapsSearchAction(
        query: query,
        referer: referer,
        fallbackToStore: fallbackToStore,
        region: region,
      );

  /// Creates an action that searches near [center], or current location.
  static TencentMapsNearbySearchAction nearbySearch({
    required final String query,
    final Coordinate? center,
    final int radius = 1000,
    final TencentMapsCoordType coordType = TencentMapsCoordType.tencent,
    final String referer = _defaultReferer,
    final bool fallbackToStore = false,
  }) =>
      TencentMapsNearbySearchAction(
        query: query,
        radius: radius,
        coordType: coordType,
        referer: referer,
        fallbackToStore: fallbackToStore,
        center: center,
      );

  /// Creates a coordinate route planning action.
  static TencentMapsDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final String? destinationPoiId,
    final List<TencentMapsWaypoint> waypoints = const [],
    final TencentMapsTravelMode mode = TencentMapsTravelMode.driving,
    final String referer = _defaultReferer,
    final bool fallbackToStore = false,
  }) =>
      TencentMapsDirectionsWithCoordsAction(
        destination: destination,
        mode: mode,
        referer: referer,
        fallbackToStore: fallbackToStore,
        origin: origin,
        destinationTitle: destinationTitle,
        originTitle: originTitle,
        destinationPoiId: destinationPoiId,
        waypoints: waypoints,
      );
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

  /// URI value.
  String get value => 'name:$title;coord:${_latLng(coordinate)}';
}

/// Shows a marker in Tencent Maps.
class TencentMapsViewAction extends TencentMaps implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [TencentMapsViewAction].
  TencentMapsViewAction({
    required this.coordinate,
    required this.title,
    required this.coordType,
    required this.referer,
    required super.fallbackToStore,
    this.address,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Marker title.
  final String title;

  /// Optional marker address.
  final String? address;

  /// Coordinate type.
  final TencentMapsCoordType coordType;

  /// Tencent URI referer.
  final String referer;

  String get _marker => [
        'coord:${_latLng(coordinate)}',
        'title:$title',
        if (address != null) 'addr:$address',
      ].join(';');

  Map<String, String> get _queryParameters => {
        'marker': _marker,
        'coord_type': coordType.value,
        'referer': referer,
      };

  @override
  Uri get appLink => _tencentMapsUri('marker', _queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => _tencentWebUri('marker', _queryParameters);
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

  /// Tencent URI referer.
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
    required this.radius,
    required this.coordType,
    required this.referer,
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

  /// Coordinate type.
  final TencentMapsCoordType coordType;

  /// Tencent URI referer.
  final String referer;

  Map<String, String> get _queryParameters => {
        'keyword': query,
        'center': center == null ? _currentLocation : _latLng(center!),
        'radius': radius.toString(),
        'coord_type': coordType.value,
        'referer': referer,
      };

  @override
  Uri get appLink => _tencentMapsUri('search', _queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => _tencentWebUri('search', _queryParameters);
}

/// Builds a coordinate route in Tencent Maps.
class TencentMapsDirectionsWithCoordsAction extends TencentMaps
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [TencentMapsDirectionsWithCoordsAction].
  TencentMapsDirectionsWithCoordsAction({
    required this.destination,
    required this.mode,
    required this.referer,
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

  /// Optional destination POI ID.
  final String? destinationPoiId;

  /// Optional waypoints, up to the provider-supported limit.
  final List<TencentMapsWaypoint> waypoints;

  /// Route mode.
  final TencentMapsTravelMode mode;

  /// Tencent URI referer.
  final String referer;

  Map<String, String> get _queryParameters => {
        'type': mode.value,
        if (originTitle != null) 'from': originTitle!,
        'fromcoord': origin == null ? _currentLocation : _latLng(origin!),
        if (destinationTitle != null) 'to': destinationTitle!,
        'tocoord': _latLng(destination),
        if (destinationPoiId != null) 'touid': destinationPoiId!,
        if (waypoints.isNotEmpty) 'passes': waypoints.map((final waypoint) => waypoint.value).join('|'),
        'referer': referer,
      };

  @override
  Uri get appLink => _tencentMapsUri('routeplan', _queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _intentOptions(appLink);

  @override
  Uri get fallbackLink => _tencentWebUri('routeplan', _queryParameters);
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

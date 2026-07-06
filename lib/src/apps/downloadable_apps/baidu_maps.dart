import 'package:deeplink_x/src/src.dart';

const _sourceApplication = 'deeplink_x';
const _currentLocation = '我的位置';
const _newTaskFlag = 0x10000000;

/// Baidu Maps application.
///
/// Implements Baidu Maps URI actions for Android and iOS.
class BaiduMaps extends App implements DownloadableApp {
  /// Creates a new [BaiduMaps] instance.
  BaiduMaps({this.fallbackToStore = false});

  /// Creates an action to open the Baidu Maps app.
  factory BaiduMaps.open({final bool fallbackToStore = false}) => BaiduMaps(fallbackToStore: fallbackToStore);

  /// Store actions for Baidu Maps.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.baidu.BaiduMap'),
        IOSAppStore.openAppPage(appId: '452186370', appName: 'baidu-maps'),
      ];

  /// Android package name for Baidu Maps.
  @override
  String get androidPackageName => 'com.baidu.BaiduMap';

  /// Baidu Maps custom URL scheme.
  @override
  String get customScheme => 'baidumap';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to stores when Baidu Maps is missing.
  @override
  bool fallbackToStore;

  /// Baidu Maps website.
  @override
  Uri get website => Uri.parse('https://map.baidu.com');

  /// Creates an action that shows a coordinate marker.
  static BaiduMapsViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final String? content,
    final int? zoom,
    final BaiduMapsCoordType coordType = BaiduMapsCoordType.bd09ll,
    final bool traffic = false,
    final bool fallbackToStore = false,
  }) =>
      BaiduMapsViewAction(
        coordinate: coordinate,
        coordType: coordType,
        traffic: traffic,
        fallbackToStore: fallbackToStore,
        title: title,
        content: content,
        zoom: zoom,
      );

  /// Creates an action that searches for places.
  static BaiduMapsSearchAction search({
    required final String query,
    final String? region,
    final Coordinate? center,
    final BaiduMapsBounds? bounds,
    final int? radius,
    final int? zoom,
    final BaiduMapsCoordType coordType = BaiduMapsCoordType.bd09ll,
    final bool fallbackToStore = false,
  }) =>
      BaiduMapsSearchAction(
        query: query,
        coordType: coordType,
        fallbackToStore: fallbackToStore,
        region: region,
        center: center,
        bounds: bounds,
        radius: radius,
        zoom: zoom,
      );

  /// Creates an action that searches nearby places.
  static BaiduMapsNearbySearchAction nearbySearch({
    required final String query,
    final Coordinate? center,
    final int? radius,
    final BaiduMapsCoordType coordType = BaiduMapsCoordType.bd09ll,
    final bool fallbackToStore = false,
  }) =>
      BaiduMapsNearbySearchAction(
        query: query,
        coordType: coordType,
        fallbackToStore: fallbackToStore,
        center: center,
        radius: radius,
      );

  /// Creates an action that searches a transit line.
  static BaiduMapsLineAction line({
    required final String name,
    final String? region,
    final int? zoom,
    final bool fallbackToStore = false,
  }) =>
      BaiduMapsLineAction(
        name: name,
        fallbackToStore: fallbackToStore,
        region: region,
        zoom: zoom,
      );

  /// Creates an action that plans a route to [destination].
  static BaiduMapsDirectionsAction directions({
    required final String destination,
    final String? origin,
    final String? region,
    final BaiduMapsTravelMode mode = BaiduMapsTravelMode.driving,
    final BaiduMapsCoordType coordType = BaiduMapsCoordType.bd09ll,
    final bool fallbackToStore = false,
  }) =>
      BaiduMapsDirectionsAction(
        destination: destination,
        mode: mode,
        coordType: coordType,
        fallbackToStore: fallbackToStore,
        origin: origin,
        region: region,
      );

  /// Creates an action that plans a route to [destination] coordinates.
  static BaiduMapsDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final String? region,
    final BaiduMapsTravelMode mode = BaiduMapsTravelMode.driving,
    final BaiduMapsCoordType coordType = BaiduMapsCoordType.bd09ll,
    final bool fallbackToStore = false,
  }) =>
      BaiduMapsDirectionsWithCoordsAction(
        destination: destination,
        mode: mode,
        coordType: coordType,
        fallbackToStore: fallbackToStore,
        origin: origin,
        destinationTitle: destinationTitle,
        originTitle: originTitle,
        region: region,
      );

  /// Creates an action that starts native turn-by-turn navigation.
  static BaiduMapsNavigateAction navigate({
    required final Coordinate destination,
    final BaiduMapsNavigationMode mode = BaiduMapsNavigationMode.driving,
    final BaiduMapsCoordType coordType = BaiduMapsCoordType.bd09ll,
    final bool fallbackToStore = false,
  }) =>
      BaiduMapsNavigateAction(
        destination: destination,
        mode: mode,
        coordType: coordType,
        fallbackToStore: fallbackToStore,
      );
}

/// Coordinate system used by Baidu Maps URI actions.
enum BaiduMapsCoordType {
  /// Baidu latitude/longitude coordinates.
  bd09ll('bd09ll'),

  /// Baidu Mercator coordinates.
  bd09mc('bd09mc'),

  /// GCJ-02 coordinates.
  gcj02('gcj02'),

  /// WGS84 coordinates.
  wgs84('wgs84');

  /// Creates a new [BaiduMapsCoordType].
  const BaiduMapsCoordType(this.value);

  /// URI query value.
  final String value;
}

/// Route planning modes supported by Baidu Maps URI route planning.
enum BaiduMapsTravelMode {
  /// Driving route.
  driving('driving'),

  /// Public transit route.
  transit('transit'),

  /// Walking route.
  walking('walking'),

  /// Bicycling route.
  riding('riding');

  /// Creates a new [BaiduMapsTravelMode].
  const BaiduMapsTravelMode(this.value);

  /// URI query value.
  final String value;
}

/// Native navigation modes supported by Baidu Maps.
enum BaiduMapsNavigationMode {
  /// Driving navigation.
  driving(androidPath: 'navi', iosPath: 'navi'),

  /// Walking navigation.
  walking(androidPath: 'walknavi', iosPath: 'walknavi'),

  /// Bicycling navigation.
  riding(androidPath: 'bikenavi', iosPath: 'ridenavi');

  /// Creates a new [BaiduMapsNavigationMode].
  const BaiduMapsNavigationMode({
    required this.androidPath,
    required this.iosPath,
  });

  /// Android URI path segment.
  final String androidPath;

  /// iOS URI path segment.
  final String iosPath;
}

/// Bounds for Baidu Maps search.
class BaiduMapsBounds {
  /// Creates a new [BaiduMapsBounds].
  const BaiduMapsBounds({
    required this.southWest,
    required this.northEast,
  });

  /// South-west coordinate of the search box.
  final Coordinate southWest;

  /// North-east coordinate of the search box.
  final Coordinate northEast;

  /// URI query value.
  String get value => '${southWest.latitude},${southWest.longitude},${northEast.latitude},${northEast.longitude}';
}

/// Shows a coordinate marker in Baidu Maps.
class BaiduMapsViewAction extends BaiduMaps implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [BaiduMapsViewAction].
  BaiduMapsViewAction({
    required this.coordinate,
    required this.coordType,
    required this.traffic,
    required super.fallbackToStore,
    this.title,
    this.content,
    this.zoom,
  });

  /// Coordinate to mark.
  @override
  final Coordinate coordinate;

  /// Optional marker title.
  final String? title;

  /// Optional marker content text.
  final String? content;

  /// Optional zoom level.
  final int? zoom;

  /// Coordinate system of [coordinate].
  final BaiduMapsCoordType coordType;

  /// Whether to show real-time traffic.
  final bool traffic;

  @override
  Uri get appLink => _baiduUri(
        'marker',
        {
          'location': coordinate.toString(),
          if (title != null) 'title': title!,
          if (content != null) 'content': content!,
          if (zoom != null) 'zoom': zoom!.toString(),
          'coord_type': coordType.value,
          if (traffic) 'traffic': 'on',
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(appLink);

  @override
  Uri get fallbackLink => website;
}

/// Searches for places in Baidu Maps.
class BaiduMapsSearchAction extends BaiduMaps implements IntentAppLinkAction, Fallbackable, MapSearchAction {
  /// Creates a new [BaiduMapsSearchAction].
  BaiduMapsSearchAction({
    required this.query,
    required this.coordType,
    required super.fallbackToStore,
    this.region,
    this.center,
    this.bounds,
    this.radius,
    this.zoom,
  });

  /// Search query.
  @override
  final String query;

  /// Optional city or region.
  final String? region;

  /// Optional search center coordinate.
  final Coordinate? center;

  /// Optional search bounds.
  final BaiduMapsBounds? bounds;

  /// Optional nearby-search radius in meters.
  final int? radius;

  /// Optional zoom level.
  final int? zoom;

  /// Coordinate system for [center] and [bounds].
  final BaiduMapsCoordType coordType;

  @override
  Uri get appLink => _baiduUri(
        'place/search',
        {
          'query': query,
          if (region != null) 'region': region!,
          if (center != null) 'location': center!.toString(),
          if (bounds != null) 'bounds': bounds!.value,
          if (radius != null) 'radius': radius!.toString(),
          if (zoom != null) 'zoom': zoom!.toString(),
          'coord_type': coordType.value,
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(appLink);

  @override
  Uri get fallbackLink => website;
}

/// Searches nearby places in Baidu Maps.
class BaiduMapsNearbySearchAction extends BaiduMaps implements IntentAppLinkAction, Fallbackable {
  /// Creates a new [BaiduMapsNearbySearchAction].
  BaiduMapsNearbySearchAction({
    required this.query,
    required this.coordType,
    required super.fallbackToStore,
    this.center,
    this.radius,
  });

  /// Nearby search query.
  final String query;

  /// Optional search center coordinate.
  final Coordinate? center;

  /// Optional search radius in meters.
  final int? radius;

  /// Coordinate system for [center].
  final BaiduMapsCoordType coordType;

  @override
  Uri get appLink => _baiduUri(
        'place/nearby',
        {
          'query': query,
          if (center != null) 'location': center!.toString(),
          if (radius != null) 'radius': radius!.toString(),
          'coord_type': coordType.value,
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(appLink);

  @override
  Uri get fallbackLink => website;
}

/// Searches for a transit line in Baidu Maps.
class BaiduMapsLineAction extends BaiduMaps implements IntentAppLinkAction, Fallbackable {
  /// Creates a new [BaiduMapsLineAction].
  BaiduMapsLineAction({
    required this.name,
    required super.fallbackToStore,
    this.region,
    this.zoom,
  });

  /// Transit line name.
  final String name;

  /// Optional city or region.
  final String? region;

  /// Optional zoom level.
  final int? zoom;

  @override
  Uri get appLink => _baiduUri(
        'line',
        {
          'name': name,
          if (region != null) 'region': region!,
          if (zoom != null) 'zoom': zoom!.toString(),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(appLink);

  @override
  Uri get fallbackLink => website;
}

/// Plans a route to a text destination in Baidu Maps.
class BaiduMapsDirectionsAction extends BaiduMaps implements IntentAppLinkAction, Fallbackable, MapDirectionsAction {
  /// Creates a new [BaiduMapsDirectionsAction].
  BaiduMapsDirectionsAction({
    required this.destination,
    required this.mode,
    required this.coordType,
    required super.fallbackToStore,
    this.origin,
    this.region,
  });

  /// Destination address or place name.
  @override
  final String destination;

  /// Optional origin address or place name.
  final String? origin;

  /// Optional city or region.
  final String? region;

  /// Route travel mode.
  final BaiduMapsTravelMode mode;

  /// Coordinate system used by route planning.
  final BaiduMapsCoordType coordType;

  @override
  Uri get appLink => _baiduUri(
        'direction',
        {
          'origin': origin ?? _currentLocation,
          'destination': destination,
          if (region != null) 'region': region!,
          'mode': mode.value,
          'coord_type': coordType.value,
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(appLink);

  @override
  Uri get fallbackLink => website;
}

/// Plans a route to coordinate destinations in Baidu Maps.
class BaiduMapsDirectionsWithCoordsAction extends BaiduMaps
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [BaiduMapsDirectionsWithCoordsAction].
  BaiduMapsDirectionsWithCoordsAction({
    required this.destination,
    required this.mode,
    required this.coordType,
    required super.fallbackToStore,
    this.origin,
    this.destinationTitle,
    this.originTitle,
    this.region,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional destination display name.
  final String? destinationTitle;

  /// Optional origin display name.
  final String? originTitle;

  /// Optional city or region.
  final String? region;

  /// Route travel mode.
  final BaiduMapsTravelMode mode;

  /// Coordinate system used by route planning.
  final BaiduMapsCoordType coordType;

  @override
  Uri get appLink => _baiduUri(
        'direction',
        {
          'origin': origin != null ? _routePoint(origin!, originTitle) : originTitle ?? _currentLocation,
          'destination': _routePoint(destination, destinationTitle),
          if (region != null) 'region': region!,
          'mode': mode.value,
          'coord_type': coordType.value,
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(appLink);

  @override
  Uri get fallbackLink => website;
}

/// Starts native turn-by-turn navigation in Baidu Maps.
class BaiduMapsNavigateAction extends BaiduMaps implements IntentAppLinkAction, Fallbackable {
  /// Creates a new [BaiduMapsNavigateAction].
  BaiduMapsNavigateAction({
    required this.destination,
    required this.mode,
    required this.coordType,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  final Coordinate destination;

  /// Native navigation mode.
  final BaiduMapsNavigationMode mode;

  /// Coordinate system of [destination].
  final BaiduMapsCoordType coordType;

  @override
  Uri get appLink => _navigationLink(mode.iosPath);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(_navigationLink(mode.androidPath));

  @override
  Uri get fallbackLink => website;

  Uri _navigationLink(final String path) => _baiduUri(
        path,
        {
          _navigationLocationKey: destination.toString(),
          'coord_type': coordType.value,
        },
      );

  String get _navigationLocationKey {
    if (mode == BaiduMapsNavigationMode.driving) {
      return 'location';
    }
    return 'destination';
  }
}

Uri _baiduUri(final String path, final Map<String, String> parameters) => Uri(
      scheme: 'baidumap',
      host: 'map',
      path: path,
      queryParameters: {
        ...parameters,
        'src': _sourceApplication,
      },
    );

AndroidIntentOption _androidIntentOptions(final Uri data) => AndroidIntentOption(
      action: 'action_view',
      data: data.toString(),
      package: 'com.baidu.BaiduMap',
      flags: const [_newTaskFlag],
    );

String _routePoint(final Coordinate coordinate, final String? name) {
  final latLng = 'latlng:${coordinate.latitude},${coordinate.longitude}';
  if (name == null) {
    return latLng;
  }
  return '$latLng|name:$name';
}

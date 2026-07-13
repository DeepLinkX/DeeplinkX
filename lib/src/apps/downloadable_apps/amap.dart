import 'package:deeplink_x/src/src.dart';

const String _defaultSourceApplication = 'deeplink_x';

/// Amap (Gaode Maps) application.
///
/// Provides deep links for Amap on Android and iOS using the official Amap URI
/// schemes.
class Amap extends App implements DownloadableApp {
  /// Creates a new [Amap] instance.
  Amap({this.fallbackToStore = false});

  /// Creates an action to open the Amap app.
  factory Amap.open({final bool fallbackToStore = false}) => Amap(fallbackToStore: fallbackToStore);

  /// Store actions to open Amap in platform app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.autonavi.minimap'),
        IOSAppStore.openAppPage(appId: '461703208', appName: 'gao-de-di-tu'),
      ];

  /// Android package name for Amap.
  @override
  String get androidPackageName => 'com.autonavi.minimap';

  /// iOS custom scheme for Amap.
  @override
  String get customScheme => 'iosamap';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms for Amap.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to stores when Amap is unavailable.
  @override
  bool fallbackToStore;

  /// Amap web fallback.
  @override
  Uri get website => Uri.parse('https://www.amap.com');

  /// Creates an action to show the user's current location in Amap.
  static AmapMyLocationAction myLocation({
    final String sourceApplication = _defaultSourceApplication,
    final bool fallbackToStore = false,
  }) =>
      AmapMyLocationAction(
        sourceApplication: sourceApplication,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to show a coordinate marker in Amap.
  static AmapViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final String sourceApplication = _defaultSourceApplication,
    final bool convertFromWgs84 = false,
    final bool fallbackToStore = false,
  }) =>
      AmapViewAction(
        coordinate: coordinate,
        title: title,
        sourceApplication: sourceApplication,
        convertFromWgs84: convertFromWgs84,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to search for places in Amap.
  static AmapSearchAction search({
    required final String query,
    final AmapBounds? bounds,
    final String sourceApplication = _defaultSourceApplication,
    final bool convertFromWgs84 = false,
    final bool fallbackToStore = false,
  }) =>
      AmapSearchAction(
        query: query,
        bounds: bounds,
        sourceApplication: sourceApplication,
        convertFromWgs84: convertFromWgs84,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a text-based directions action in Amap.
  static AmapDirectionsAction directions({
    required final String destination,
    final String sourceApplication = _defaultSourceApplication,
    final bool fallbackToStore = false,
  }) =>
      AmapDirectionsAction(
        destination: destination,
        sourceApplication: sourceApplication,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a coordinate-based directions action in Amap.
  static AmapDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final List<AmapWaypoint> waypoints = const [],
    final AmapTravelMode mode = AmapTravelMode.driving,
    final String sourceApplication = _defaultSourceApplication,
    final bool convertFromWgs84 = false,
    final bool fallbackToStore = false,
  }) =>
      AmapDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        destinationTitle: destinationTitle,
        originTitle: originTitle,
        waypoints: waypoints,
        mode: mode,
        sourceApplication: sourceApplication,
        convertFromWgs84: convertFromWgs84,
        fallbackToStore: fallbackToStore,
      );
}

/// Travel modes accepted by Amap route planning.
enum AmapTravelMode {
  /// Driving route.
  driving('0'),

  /// Public transit route.
  transit('1'),

  /// Walking route.
  walking('2'),

  /// Bicycling route.
  bicycling('3');

  /// Creates a new [AmapTravelMode].
  const AmapTravelMode(this.value);

  /// URI query value for the travel mode.
  final String value;
}

/// Bounding box used to limit Amap place search results.
class AmapBounds {
  /// Creates a new [AmapBounds].
  const AmapBounds({
    required this.topLeft,
    required this.bottomRight,
  });

  /// Upper-left coordinate of the search box.
  final Coordinate topLeft;

  /// Lower-right coordinate of the search box.
  final Coordinate bottomRight;
}

/// A waypoint used by Amap coordinate directions.
class AmapWaypoint {
  /// Creates a new [AmapWaypoint].
  const AmapWaypoint({
    required this.coordinate,
    this.title,
  });

  /// Waypoint coordinate.
  final Coordinate coordinate;

  /// Optional waypoint display name.
  final String? title;
}

/// Opens Amap at the user's current location.
class AmapMyLocationAction extends Amap implements IntentAppLinkAction, Fallbackable {
  /// Creates a new [AmapMyLocationAction].
  AmapMyLocationAction({
    required super.fallbackToStore,
    final String sourceApplication = _defaultSourceApplication,
  }) : sourceApplication = _validatedSourceApplication(sourceApplication);

  /// Identifier of the application launching Amap.
  final String sourceApplication;

  @override
  Uri get appLink => Uri(
        scheme: 'iosamap',
        host: 'myLocation',
        queryParameters: {'sourceApplication': sourceApplication},
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'android.intent.action.VIEW',
        category: 'android.intent.category.DEFAULT',
        data: Uri(
          scheme: 'androidamap',
          host: 'myLocation',
          queryParameters: {'sourceApplication': sourceApplication},
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;
}

/// Shows a coordinate marker in Amap.
class AmapViewAction extends Amap implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [AmapViewAction].
  AmapViewAction({
    required this.coordinate,
    required this.convertFromWgs84,
    required super.fallbackToStore,
    final String sourceApplication = _defaultSourceApplication,
    this.title,
  }) : sourceApplication = _validatedSourceApplication(sourceApplication);

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Optional marker title.
  final String? title;

  /// Whether Amap should convert the coordinate from WGS84 to GCJ-02.
  final bool convertFromWgs84;

  /// Identifier of the application launching Amap.
  final String sourceApplication;

  @override
  Uri get appLink => _viewLink('iosamap');

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'android.intent.action.VIEW',
        category: 'android.intent.category.DEFAULT',
        data: _viewLink('androidamap').toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;

  Uri _viewLink(final String scheme) => Uri(
        scheme: scheme,
        host: 'viewMap',
        queryParameters: {
          'sourceApplication': sourceApplication,
          'poiname': title ?? 'Pin',
          'lat': coordinate.latitude.toString(),
          'lon': coordinate.longitude.toString(),
          'dev': _devValue(convertFromWgs84),
        },
      );
}

/// Searches for places in Amap.
class AmapSearchAction extends Amap implements IntentAppLinkAction, Fallbackable, MapSearchAction {
  /// Creates a new [AmapSearchAction].
  AmapSearchAction({
    required this.query,
    required this.convertFromWgs84,
    required super.fallbackToStore,
    final String sourceApplication = _defaultSourceApplication,
    this.bounds,
  }) : sourceApplication = _validatedSourceApplication(sourceApplication);

  /// Search query.
  @override
  final String query;

  /// Optional search bounding box.
  final AmapBounds? bounds;

  /// Whether Amap should convert provided bounds from WGS84 to GCJ-02.
  final bool convertFromWgs84;

  /// Identifier of the application launching Amap.
  final String sourceApplication;

  @override
  Uri get appLink => Uri(
        scheme: 'iosamap',
        host: 'poi',
        queryParameters: _searchQueryParameters('name'),
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'android.intent.action.VIEW',
        category: 'android.intent.category.DEFAULT',
        data: Uri(
          scheme: 'androidamap',
          host: 'poi',
          queryParameters: _searchQueryParameters('keywords'),
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;

  Map<String, String> _searchQueryParameters(final String queryKey) => {
        'sourceApplication': sourceApplication,
        queryKey: query,
        if (bounds != null) ...{
          'lat1': bounds!.topLeft.latitude.toString(),
          'lon1': bounds!.topLeft.longitude.toString(),
          'lat2': bounds!.bottomRight.latitude.toString(),
          'lon2': bounds!.bottomRight.longitude.toString(),
        },
        'dev': _devValue(convertFromWgs84),
      };
}

/// Gets directions in Amap using a destination name.
class AmapDirectionsAction extends Amap implements IntentAppLinkAction, Fallbackable, MapDirectionsAction {
  /// Creates a new [AmapDirectionsAction].
  AmapDirectionsAction({
    required this.destination,
    required super.fallbackToStore,
    final String sourceApplication = _defaultSourceApplication,
  }) : sourceApplication = _validatedSourceApplication(sourceApplication);

  /// Destination name.
  @override
  final String destination;

  /// Identifier of the application launching Amap.
  final String sourceApplication;

  @override
  Uri get appLink => _iosDirectionsLink(sourceApplication, {
        'dname': destination,
        'dev': '0',
        't': AmapTravelMode.driving.value,
      });

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'android.intent.action.VIEW',
        category: 'android.intent.category.DEFAULT',
        data: Uri(
          scheme: 'androidamap',
          host: 'keywordNavi',
          queryParameters: {
            'sourceApplication': sourceApplication,
            'keyword': destination,
            'style': '2',
          },
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;
}

/// Gets directions in Amap using destination coordinates.
class AmapDirectionsWithCoordsAction extends Amap
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [AmapDirectionsWithCoordsAction].
  AmapDirectionsWithCoordsAction({
    required this.destination,
    required this.waypoints,
    required this.mode,
    required this.convertFromWgs84,
    required super.fallbackToStore,
    final String sourceApplication = _defaultSourceApplication,
    this.origin,
    this.destinationTitle,
    this.originTitle,
  }) : sourceApplication = _validatedSourceApplication(sourceApplication);

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional destination display name.
  final String? destinationTitle;

  /// Optional origin display name.
  final String? originTitle;

  /// Optional route waypoints.
  final List<AmapWaypoint> waypoints;

  /// Selected travel mode.
  final AmapTravelMode mode;

  /// Whether Amap should convert coordinates from WGS84 to GCJ-02.
  final bool convertFromWgs84;

  /// Identifier of the application launching Amap.
  final String sourceApplication;

  @override
  Uri get appLink => _iosDirectionsLink(sourceApplication, _routeQueryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'android.intent.action.VIEW',
        category: 'android.intent.category.DEFAULT',
        data: _androidDirectionsLink(sourceApplication, _routeQueryParameters).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;

  Map<String, String> get _routeQueryParameters => {
        if (origin != null) ...{
          'slat': origin!.latitude.toString(),
          'slon': origin!.longitude.toString(),
        },
        if (originTitle != null) 'sname': originTitle!,
        'dlat': destination.latitude.toString(),
        'dlon': destination.longitude.toString(),
        if (destinationTitle != null) 'dname': destinationTitle!,
        'dev': _devValue(convertFromWgs84),
        't': mode.value,
        if (waypoints.isNotEmpty) ...{
          'vian': waypoints.length.toString(),
          'vialons': waypoints.map((final waypoint) => waypoint.coordinate.longitude).join('|'),
          'vialats': waypoints.map((final waypoint) => waypoint.coordinate.latitude).join('|'),
          'vianames': waypoints.map((final waypoint) => waypoint.title ?? '').join('|'),
        },
      };
}

Uri _androidDirectionsLink(
  final String sourceApplication,
  final Map<String, String> queryParameters,
) =>
    Uri(
      scheme: 'amapuri',
      host: 'route',
      path: '/plan/',
      queryParameters: {
        'sourceApplication': sourceApplication,
        ...queryParameters,
      },
    );

Uri _iosDirectionsLink(
  final String sourceApplication,
  final Map<String, String> queryParameters,
) =>
    Uri(
      scheme: 'iosamap',
      host: 'path',
      queryParameters: {
        'sourceApplication': sourceApplication,
        ...queryParameters,
      },
    );

String _devValue(final bool convertFromWgs84) => convertFromWgs84 ? '1' : '0';

String _validatedSourceApplication(final String sourceApplication) {
  if (sourceApplication.trim().isEmpty) {
    throw ArgumentError.value(
      sourceApplication,
      'sourceApplication',
      'must not be blank',
    );
  }
  return sourceApplication;
}

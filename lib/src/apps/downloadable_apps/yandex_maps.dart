import 'package:deeplink_x/src/src.dart';

/// Yandex Maps app for iOS and Android.
///
/// Implements the public `yandexmaps` URI scheme documented by Yandex Maps.
class YandexMaps extends App implements DownloadableApp {
  /// Creates a new [YandexMaps] instance.
  YandexMaps({this.fallbackToStore = false});

  /// Creates an action to open the Yandex Maps app.
  factory YandexMaps.open({final bool fallbackToStore = false}) => YandexMaps(fallbackToStore: fallbackToStore);

  /// Opens the map with optional center, zoom, viewport, layer, and traffic.
  static YandexMapsOpenMapAction openMap({
    final Coordinate? center,
    final int? zoom,
    final YandexMapsViewport? viewport,
    final YandexMapsMapLayer layer = YandexMapsMapLayer.map,
    final bool showTraffic = false,
    final bool fallbackToStore = false,
  }) =>
      YandexMapsOpenMapAction(
        center: center,
        zoom: zoom,
        viewport: viewport,
        layer: layer,
        showTraffic: showTraffic,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to show a placemark at [coordinate].
  static YandexMapsViewAction view({
    required final Coordinate coordinate,
    final int? zoom,
    final YandexMapsMapLayer layer = YandexMapsMapLayer.map,
    final bool showTraffic = false,
    final bool fallbackToStore = false,
  }) =>
      YandexMapsViewAction(
        coordinate: coordinate,
        zoom: zoom,
        layer: layer,
        showTraffic: showTraffic,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to search for [query].
  static YandexMapsSearchAction search({
    required final String query,
    final Coordinate? center,
    final int? zoom,
    final YandexMapsViewport? viewport,
    final YandexMapsMapLayer layer = YandexMapsMapLayer.map,
    final bool showTraffic = false,
    final bool fallbackToStore = false,
  }) =>
      YandexMapsSearchAction(
        query: query,
        center: center,
        zoom: zoom,
        viewport: viewport,
        layer: layer,
        showTraffic: showTraffic,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open an organization card by Yandex organization ID.
  static YandexMapsOrganizationAction organization({
    required final String objectId,
    final bool fallbackToStore = false,
  }) =>
      YandexMapsOrganizationAction(
        objectId: objectId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action for Yandex Maps' "What's here?" object card.
  static YandexMapsWhatIsHereAction whatIsHere({
    required final Coordinate coordinate,
    final int zoom = 17,
    final bool fallbackToStore = false,
  }) =>
      YandexMapsWhatIsHereAction(
        coordinate: coordinate,
        zoom: zoom,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a coordinate-based directions action.
  static YandexMapsDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final List<YandexMapsWaypoint> waypoints = const [],
    final YandexMapsTravelMode mode = YandexMapsTravelMode.driving,
    final bool fallbackToStore = false,
  }) =>
      YandexMapsDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        waypoints: waypoints,
        mode: mode,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to show a panorama from [coordinate].
  static YandexMapsPanoramaAction panorama({
    required final Coordinate coordinate,
    final YandexMapsPanoramaDirection? direction,
    final YandexMapsPanoramaSpan? span,
    final bool fallbackToStore = false,
  }) =>
      YandexMapsPanoramaAction(
        coordinate: coordinate,
        direction: direction,
        span: span,
        fallbackToStore: fallbackToStore,
      );

  /// Store actions for Yandex Maps.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'ru.yandex.yandexmaps'),
        IOSAppStore.openAppPage(appId: '313877526', appName: 'yandex-maps-navigator'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'ru.yandex.yandexmaps';

  /// Custom scheme for Yandex Maps.
  @override
  String get customScheme => 'yandexmaps';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// Yandex Maps website.
  @override
  Uri get website => Uri.parse('https://yandex.com/maps');
}

/// Map layer values supported by Yandex Maps launch URLs.
enum YandexMapsMapLayer {
  /// Standard map layer.
  map('map'),

  /// Satellite map layer.
  satellite('sat'),

  /// Hybrid map layer.
  hybrid('skl'),

  /// Public map layer.
  publicMap('pmap');

  /// Creates a layer value.
  const YandexMapsMapLayer(this.value);

  /// URI value for the layer.
  final String value;
}

/// Travel modes supported by Yandex Maps mobile route URLs.
enum YandexMapsTravelMode {
  /// Driving route.
  driving('auto'),

  /// Public transit route.
  transit('mt'),

  /// Walking route.
  walking('pd');

  /// Creates a route mode value.
  const YandexMapsTravelMode(this.value);

  /// URI value for the route mode.
  final String value;
}

/// Viewport size in degrees for Yandex Maps `spn`.
class YandexMapsViewport {
  /// Creates a viewport size.
  const YandexMapsViewport({
    required this.longitudeDelta,
    required this.latitudeDelta,
  });

  /// Longitudinal viewport size in degrees.
  final double longitudeDelta;

  /// Latitudinal viewport size in degrees.
  final double latitudeDelta;

  @override
  String toString() => '$longitudeDelta,$latitudeDelta';
}

/// A route waypoint for Yandex Maps coordinate directions.
class YandexMapsWaypoint {
  /// Creates a waypoint.
  const YandexMapsWaypoint({required this.coordinate});

  /// Waypoint coordinate.
  final Coordinate coordinate;
}

/// Panorama view direction in degrees.
class YandexMapsPanoramaDirection {
  /// Creates a panorama view direction.
  const YandexMapsPanoramaDirection({
    required this.azimuth,
    required this.elevation,
  });

  /// Direction azimuth.
  final double azimuth;

  /// Angle of elevation above the horizon.
  final double elevation;

  @override
  String toString() => '$azimuth,$elevation';
}

/// Panorama viewport size in degrees.
class YandexMapsPanoramaSpan {
  /// Creates a panorama viewport span.
  const YandexMapsPanoramaSpan({
    required this.horizontal,
    required this.vertical,
  });

  /// Horizontal viewport size.
  final double horizontal;

  /// Vertical viewport size.
  final double vertical;

  @override
  String toString() => '$horizontal,$vertical';
}

/// Opens Yandex Maps with optional map parameters.
class YandexMapsOpenMapAction extends YandexMaps implements IntentAppLinkAction, Fallbackable {
  /// Creates a Yandex Maps open-map action.
  YandexMapsOpenMapAction({
    required super.fallbackToStore,
    this.center,
    this.zoom,
    this.viewport,
    this.layer = YandexMapsMapLayer.map,
    this.showTraffic = false,
  });

  /// Optional map center.
  final Coordinate? center;

  /// Optional map zoom.
  final int? zoom;

  /// Optional viewport size.
  final YandexMapsViewport? viewport;

  /// Map layer.
  final YandexMapsMapLayer layer;

  /// Whether to show traffic.
  final bool showTraffic;

  Map<String, String> get _queryParameters => {
        if (center != null) 'll': _lngLat(center!),
        if (zoom != null) 'z': zoom!.toString(),
        if (viewport != null) 'spn': viewport!.toString(),
        'l': _layerValue(layer, showTraffic),
      };

  @override
  Uri get appLink => _mapUri(_queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri(
        _queryParameters,
        layer: layer,
        showTraffic: showTraffic,
      );
}

/// Shows a Yandex Maps placemark at a coordinate.
class YandexMapsViewAction extends YandexMaps implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a Yandex Maps view action.
  YandexMapsViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    this.zoom,
    this.layer = YandexMapsMapLayer.map,
    this.showTraffic = false,
  });

  /// Coordinate to display as a placemark.
  @override
  final Coordinate coordinate;

  /// Optional map zoom.
  final int? zoom;

  /// Map layer.
  final YandexMapsMapLayer layer;

  /// Whether to show traffic.
  final bool showTraffic;

  Map<String, String> get _queryParameters => {
        'pt': _lngLat(coordinate),
        if (zoom != null) 'z': zoom!.toString(),
        'l': _layerValue(layer, showTraffic),
      };

  @override
  Uri get appLink => _mapUri(_queryParameters, host: 'maps.yandex.ru');

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri(
        _queryParameters,
        layer: layer,
        showTraffic: showTraffic,
      );
}

/// Searches Yandex Maps for a text query.
class YandexMapsSearchAction extends YandexMaps implements IntentAppLinkAction, Fallbackable, MapSearchAction {
  /// Creates a Yandex Maps search action.
  YandexMapsSearchAction({
    required this.query,
    required super.fallbackToStore,
    this.center,
    this.zoom,
    this.viewport,
    this.layer = YandexMapsMapLayer.map,
    this.showTraffic = false,
  });

  /// Search query.
  @override
  final String query;

  /// Optional search area center.
  final Coordinate? center;

  /// Optional map zoom.
  final int? zoom;

  /// Optional viewport size.
  final YandexMapsViewport? viewport;

  /// Map layer.
  final YandexMapsMapLayer layer;

  /// Whether to show traffic.
  final bool showTraffic;

  Map<String, String> get _queryParameters => {
        if (center != null) 'll': _lngLat(center!),
        if (zoom != null) 'z': zoom!.toString(),
        if (viewport != null) 'spn': viewport!.toString(),
        'text': query,
        'l': _layerValue(layer, showTraffic),
      };

  @override
  Uri get appLink => _mapUri(_queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri(
        _queryParameters,
        layer: layer,
        showTraffic: showTraffic,
      );
}

/// Opens a Yandex Maps organization card.
class YandexMapsOrganizationAction extends YandexMaps implements IntentAppLinkAction, Fallbackable {
  /// Creates a Yandex Maps organization action.
  YandexMapsOrganizationAction({
    required this.objectId,
    required super.fallbackToStore,
  });

  /// Yandex organization ID.
  final String objectId;

  Map<String, String> get _queryParameters => {'oid': objectId};

  @override
  Uri get appLink => _mapUri(_queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'yandex.com',
        pathSegments: ['maps', 'org', objectId],
      );
}

/// Opens the object card for a coordinate using "What's here?".
class YandexMapsWhatIsHereAction extends YandexMaps implements IntentAppLinkAction, Fallbackable {
  /// Creates a Yandex Maps "What's here?" action.
  YandexMapsWhatIsHereAction({
    required this.coordinate,
    required this.zoom,
    required super.fallbackToStore,
  });

  /// Object coordinate.
  final Coordinate coordinate;

  /// Map zoom.
  final int zoom;

  Map<String, String> get _queryParameters => {
        'whatshere[point]': _lngLat(coordinate),
        'whatshere[zoom]': zoom.toString(),
      };

  @override
  Uri get appLink => _rootUri(_queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri(_queryParameters);
}

/// Builds a coordinate route in Yandex Maps.
class YandexMapsDirectionsWithCoordsAction extends YandexMaps
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a Yandex Maps coordinate directions action.
  YandexMapsDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.waypoints = const [],
    this.mode = YandexMapsTravelMode.driving,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional route waypoints.
  final List<YandexMapsWaypoint> waypoints;

  /// Route travel mode.
  final YandexMapsTravelMode mode;

  Map<String, String> get _queryParameters => {
        'rtext': [
          if (origin != null) _latLng(origin!),
          for (final waypoint in waypoints) _latLng(waypoint.coordinate),
          _latLng(destination),
        ].join('~'),
        'rtt': mode.value,
      };

  @override
  Uri get appLink => _mapUri(_queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri(_queryParameters);
}

/// Opens a Yandex Maps panorama from a coordinate.
class YandexMapsPanoramaAction extends YandexMaps implements IntentAppLinkAction, Fallbackable {
  /// Creates a Yandex Maps panorama action.
  YandexMapsPanoramaAction({
    required this.coordinate,
    required super.fallbackToStore,
    this.direction,
    this.span,
  });

  /// Panorama coordinate.
  final Coordinate coordinate;

  /// Optional panorama direction.
  final YandexMapsPanoramaDirection? direction;

  /// Optional panorama viewport span.
  final YandexMapsPanoramaSpan? span;

  Map<String, String> get _queryParameters => {
        'panorama[point]': _lngLat(coordinate),
        if (direction != null) 'panorama[direction]': direction!.toString(),
        if (span != null) 'panorama[span]': span!.toString(),
      };

  @override
  Uri get appLink => _rootUri(_queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri(_queryParameters);
}

String _lngLat(final Coordinate coordinate) => '${coordinate.longitude},${coordinate.latitude}';

String _latLng(final Coordinate coordinate) => coordinate.toString();

String _layerValue(final YandexMapsMapLayer layer, final bool showTraffic) =>
    showTraffic ? '${layer.value},trf' : layer.value;

Uri _mapUri(
  final Map<String, String> queryParameters, {
  final String host = 'maps.yandex.com',
}) =>
    Uri(
      scheme: 'yandexmaps',
      host: host,
      path: '/',
      queryParameters: queryParameters,
    );

Uri _rootUri(final Map<String, String> queryParameters) =>
    Uri.parse('yandexmaps://').replace(queryParameters: queryParameters);

Uri _webMapUri(
  final Map<String, String> queryParameters, {
  final YandexMapsMapLayer? layer,
  final bool showTraffic = false,
}) {
  final webQueryParameters = {
    ...queryParameters,
    if (layer != null)
      'l': _layerValue(
        layer == YandexMapsMapLayer.publicMap ? YandexMapsMapLayer.map : layer,
        showTraffic,
      ),
  };

  return Uri(
    scheme: 'https',
    host: 'yandex.com',
    path: 'maps/',
    queryParameters: webQueryParameters,
  );
}

AndroidIntentOption _androidIntentOptions(final IntentAppLinkAction action) => AndroidIntentOption(
      action: 'action_view',
      data: action.appLink.toString(),
      package: 'ru.yandex.yandexmaps',
      flags: const [0x10000000],
    );

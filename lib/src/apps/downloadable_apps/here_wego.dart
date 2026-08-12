import 'package:deeplink_x/src/src.dart';

/// HERE WeGo app for iOS and Android.
class HereWeGo extends App implements DownloadableApp {
  /// Creates a new [HereWeGo.new] instance.
  HereWeGo({this.fallbackToStore = false});

  /// Creates an action to open HERE WeGo.
  factory HereWeGo.open({final bool fallbackToStore = false}) => HereWeGo(fallbackToStore: fallbackToStore);

  /// Store actions for HERE WeGo.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.here.app.maps'),
        IOSAppStore.openAppPage(appId: '955837609', appName: 'here-wego-maps-navigation'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.here.app.maps';

  /// Legacy custom scheme used for iOS installation checks and app opening.
  ///
  /// Current first-party documentation specifies HTTPS share links, not this
  /// scheme. Its handling must be verified on a device before relying on it.
  @override
  String get customScheme => 'here-location';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// HERE WeGo website.
  @override
  Uri get website => Uri.parse('https://wego.here.com');

  /// Creates an action that shows [coordinate] in HERE WeGo.
  ///
  /// [zoom] must be between 0 and 20. It is ignored by the mobile app.
  static HereWeGoViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final int zoom = 16,
    final bool fallbackToStore = false,
  }) =>
      HereWeGoViewAction(
        coordinate: coordinate,
        zoom: zoom,
        fallbackToStore: fallbackToStore,
        title: title,
      );

  /// Creates a coordinate route planning action.
  ///
  /// Uses the current location when [origin] is omitted. [originTitle] is
  /// ignored without an explicit origin. Route mode availability depends on
  /// the receiving client.
  static HereWeGoDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final HereWeGoTravelMode mode = HereWeGoTravelMode.driving,
    final bool fallbackToStore = false,
  }) =>
      HereWeGoDirectionsWithCoordsAction(
        destination: destination,
        mode: mode,
        fallbackToStore: fallbackToStore,
        origin: origin,
        destinationTitle: destinationTitle,
        originTitle: originTitle,
      );
}

/// HERE WeGo route modes.
enum HereWeGoTravelMode {
  /// Driving route.
  driving('d'),

  /// Public transit route.
  transit('pt'),

  /// Walking route.
  walking('w'),

  /// Bicycling route, when supported by the receiving client.
  bicycling('b');

  /// Creates a new [HereWeGoTravelMode].
  const HereWeGoTravelMode(this.value);

  /// HERE route mode value.
  final String value;
}

/// Shows a location in HERE WeGo.
class HereWeGoViewAction extends HereWeGo implements UniversalLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [HereWeGoViewAction.new].
  ///
  /// Throws a [RangeError] if [zoom] is outside the range 0 to 20.
  HereWeGoViewAction({
    required this.coordinate,
    required this.zoom,
    required super.fallbackToStore,
    this.title,
  }) {
    if (zoom < 0 || zoom > 20) {
      throw RangeError.range(zoom, 0, 20, 'zoom');
    }
  }

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Optional location title.
  final String? title;

  /// The web map zoom level from 0 to 20, ignored by the HERE WeGo mobile app.
  final int zoom;

  @override
  Uri get universalLink => _hereUri(
        'l/${_locationSegment(coordinate, title)}',
        {'z': zoom.toString()},
      );

  @override
  Uri get fallbackLink => universalLink;
}

/// Builds a coordinate route in HERE WeGo.
class HereWeGoDirectionsWithCoordsAction extends HereWeGo
    implements UniversalLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [HereWeGoDirectionsWithCoordsAction.new].
  HereWeGoDirectionsWithCoordsAction({
    required this.destination,
    required this.mode,
    required super.fallbackToStore,
    this.origin,
    this.destinationTitle,
    this.originTitle,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional destination title.
  final String? destinationTitle;

  /// Optional origin title.
  final String? originTitle;

  /// Route mode.
  final HereWeGoTravelMode mode;

  String get _routePath {
    final destinationSegment = _locationSegment(destination, destinationTitle);
    final originSegment = origin == null ? 'mylocation' : _locationSegment(origin!, originTitle);
    return [
      'r',
      originSegment,
      destinationSegment,
    ].join('/');
  }

  @override
  Uri get universalLink => _hereUri(_routePath, {'m': mode.value});

  @override
  Uri get fallbackLink => universalLink;
}

String _locationSegment(final Coordinate coordinate, final String? title) {
  final coordinates = coordinate.toString();
  if (title == null || title.isEmpty) {
    return coordinates;
  }
  return '$coordinates,${Uri.encodeComponent(title)}';
}

Uri _hereUri(final String path, final Map<String, String> queryParameters) =>
    Uri.parse('https://share.here.com/$path').replace(queryParameters: queryParameters);

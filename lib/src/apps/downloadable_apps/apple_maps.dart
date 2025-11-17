import 'package:deeplink_x/src/src.dart';

/// Apple Maps application (iOS only).
///
/// Provides deeplink actions that mirror the native Maps URL scheme documented
/// by Apple: https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html
class AppleMaps extends App implements DownloadableApp {
  /// Creates a new [AppleMaps] instance.
  AppleMaps({this.fallbackToStore = false});

  /// Creates an action to open the Apple Maps app (use with `launchApp`).
  factory AppleMaps.open({final bool fallbackToStore = false}) => AppleMaps(fallbackToStore: fallbackToStore);

  /// App store actions to open Apple Maps page (iOS only).
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        IOSAppStore.openAppPage(appId: '915056765', appName: 'apple-maps'),
      ];

  /// Android not supported.
  @override
  String? get androidPackageName => null;

  /// Custom URL scheme for Apple Maps.
  @override
  String get customScheme => 'maps';

  /// macOS bundle identifier for Apple Maps.
  @override
  String? get macosBundleIdentifier => 'com.apple.Maps';

  /// Supported platforms list (iOS and macOS).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.macos];

  /// Whether to redirect to store when app not installed.
  @override
  bool fallbackToStore;

  /// Apple Maps website for fallback.
  @override
  Uri get website => Uri.parse('https://maps.apple.com');

  /// Creates an action to view a map centered on [coordinate] (optional [zoom]).
  static AppleMapsViewAction view({
    required final Coordinate coordinate,
    final double? zoom,
    final bool fallbackToStore = false,
  }) =>
      AppleMapsViewAction(
        coordinate: coordinate,
        zoom: zoom,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to search using [query].
  static AppleMapsSearchAction search({
    required final String query,
    final bool fallbackToStore = false,
  }) =>
      AppleMapsSearchAction(
        query: query,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to navigate to [destination] with optional [origin] and [mode].
  static AppleMapsDirectionsAction directions({
    required final String destination,
    final String? origin,
    final AppleMapsTransportType? mode,
    final bool fallbackToStore = false,
  }) =>
      AppleMapsDirectionsAction(
        destination: destination,
        origin: origin,
        mode: mode,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to navigate using coordinates.
  static AppleMapsDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final AppleMapsTransportType? mode,
    final bool fallbackToStore = false,
  }) =>
      AppleMapsDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        mode: mode,
        fallbackToStore: fallbackToStore,
      );
}

/// Supported transport types for Apple Maps directions.
enum AppleMapsTransportType {
  /// Driving directions.
  driving('d'),

  /// Walking directions.
  walking('w'),

  /// Transit/ride share directions.
  transit('r');

  /// Creates a new [AppleMapsTransportType] instance.
  const AppleMapsTransportType(this.value);

  /// Parameter value used in URL queries.
  final String value;
}

/// Apple Maps search action using custom scheme.
class AppleMapsSearchAction extends AppleMaps implements AppLinkAppAction, Fallbackable {
  /// Creates a new [AppleMapsSearchAction].
  AppleMapsSearchAction({
    required this.query,
    required super.fallbackToStore,
  });

  /// Search query.
  final String query;

  @override
  Uri get appLink => Uri(
        scheme: 'maps',
        queryParameters: {
          'q': query,
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.apple.com',
        path: '/',
        queryParameters: {
          'q': query,
        },
      );
}

/// Apple Maps view action.
class AppleMapsViewAction extends AppleMaps implements AppLinkAppAction, Fallbackable {
  /// Creates a new [AppleMapsViewAction].
  AppleMapsViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    this.zoom,
  });

  /// Map center coordinate.
  final Coordinate coordinate;

  /// Optional zoom.
  final double? zoom;

  @override
  Uri get appLink => Uri(
        scheme: 'maps',
        queryParameters: {
          'll': coordinate.toString(),
          if (zoom != null) 'z': zoom!.toString(),
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.apple.com',
        path: '/',
        queryParameters: {
          'll': coordinate.toString(),
          if (zoom != null) 'z': zoom!.toString(),
        },
      );
}

/// Apple Maps directions action using addresses/place names.
class AppleMapsDirectionsAction extends AppleMaps implements AppLinkAppAction, Fallbackable {
  /// Creates a new [AppleMapsDirectionsAction].
  AppleMapsDirectionsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.mode,
  });

  /// Destination address or name.
  final String destination;

  /// Optional origin address or name.
  final String? origin;

  /// Optional transport type.
  final AppleMapsTransportType? mode;

  @override
  Uri get appLink => Uri(
        scheme: 'maps',
        queryParameters: {
          'daddr': destination,
          if (origin != null) 'saddr': origin,
          if (mode != null) 'dirflg': mode!.value,
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.apple.com',
        path: '/',
        queryParameters: {
          'daddr': destination,
          if (origin != null) 'saddr': origin,
          if (mode != null) 'dirflg': mode!.value,
        },
      );
}

/// Apple Maps directions action using coordinates.
class AppleMapsDirectionsWithCoordsAction extends AppleMaps implements AppLinkAppAction, Fallbackable {
  /// Creates a new [AppleMapsDirectionsWithCoordsAction].
  AppleMapsDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.mode,
  });

  /// Destination coordinates.
  final Coordinate destination;

  /// Optional origin coordinates.
  final Coordinate? origin;

  /// Optional transport type.
  final AppleMapsTransportType? mode;

  @override
  Uri get appLink => Uri(
        scheme: 'maps',
        queryParameters: {
          'daddr': destination.toString(),
          if (origin != null) 'saddr': origin!.toString(),
          if (mode != null) 'dirflg': mode!.value,
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.apple.com',
        path: '/',
        queryParameters: {
          'daddr': destination.toString(),
          if (origin != null) 'saddr': origin!.toString(),
          if (mode != null) 'dirflg': mode!.value,
        },
      );
}

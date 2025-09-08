import 'package:deeplink_x/src/src.dart';

/// Waze application.
///
/// Implements [DownloadableApp] with universal-link based actions for
/// iOS and Android as documented by Waze:
/// https://developers.google.com/waze/deeplinks
class Waze extends App implements DownloadableApp {
  /// Creates a new [Waze] instance.
  Waze({this.fallbackToStore = false});

  /// Creates an action to open the Waze app (use with `launchApp`).
  factory Waze.open({final bool fallbackToStore = false}) => Waze(fallbackToStore: fallbackToStore);

  /// App store actions to open Waze app page.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.waze'),
        IOSAppStore.openAppPage(appId: '323229106', appName: 'waze-navigation-live-traffic'),
      ];

  /// Android package of Waze.
  @override
  String get androidPackageName => 'com.waze';

  /// Custom URL scheme of Waze for installation checks.
  @override
  String get customScheme => 'waze';

  /// macOS not supported for Waze.
  @override
  String? macosBundleIdentifier;

  /// Supported platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to store when app not installed.
  @override
  bool fallbackToStore;

  /// Waze website.
  @override
  Uri get website => Uri.parse('https://www.waze.com');

  /// Creates an action to view a map centered on [coordinate].
  static WazeViewAction view({
    required final Coordinate coordinate,
    final bool fallbackToStore = false,
  }) =>
      WazeViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to search using [query].
  /// Note: No web fallback is provided for this action.
  static WazeSearchAction search({
    required final String query,
    final bool fallbackToStore = false,
  }) =>
      WazeSearchAction(
        query: query,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to navigate to [destination] with optional [zoom].
  static WazeDirectionsAction directions({
    required final String destination,
    final int? zoom,
    final bool fallbackToStore = false,
  }) =>
      WazeDirectionsAction(
        destination: destination,
        zoom: zoom,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to navigate to [destination] coordinates with optional [zoom].
  static WazeDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final int? zoom,
    final bool fallbackToStore = false,
  }) =>
      WazeDirectionsWithCoordsAction(
        destination: destination,
        zoom: zoom,
        fallbackToStore: fallbackToStore,
      );
}

/// Waze view map action using universal link.
class WazeViewAction extends Waze implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [WazeViewAction].
  WazeViewAction({
    required this.coordinate,
    required super.fallbackToStore,
  });

  /// Map center coordinate.
  final Coordinate coordinate;

  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'waze.com',
        path: 'ul',
        queryParameters: {
          'll': coordinate.toString(),
        },
      );

  @override
  Uri get fallbackLink => universalLink;
}

/// Waze search action using universal link. No web fallback provided.
class WazeSearchAction extends Waze implements UniversalLinkAppAction {
  /// Creates a new [WazeSearchAction].
  WazeSearchAction({
    required this.query,
    required super.fallbackToStore,
  });

  /// Search query string (q).
  final String query;

  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'waze.com',
        path: 'ul',
        queryParameters: {
          'q': query,
        },
      );
}

/// Waze directions action to a destination string.
class WazeDirectionsAction extends Waze implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [WazeDirectionsAction].
  WazeDirectionsAction({
    required this.destination,
    required super.fallbackToStore,
    this.zoom,
  });

  /// Destination address or place (q).
  final String destination;

  /// Optional zoom (z) level.
  final int? zoom;

  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'waze.com',
        path: 'ul',
        queryParameters: {
          'q': destination,
          'navigate': 'yes',
          if (zoom != null) 'z': zoom!.toString(),
        },
      );

  @override
  Uri get fallbackLink => universalLink;
}

/// Waze directions action to destination coordinates.
class WazeDirectionsWithCoordsAction extends Waze implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [WazeDirectionsWithCoordsAction].
  WazeDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.zoom,
  });

  /// Destination coordinates (ll).
  final Coordinate destination;

  /// Optional zoom (z) level.
  final int? zoom;

  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'waze.com',
        path: 'ul',
        queryParameters: {
          'll': destination.toString(),
          'navigate': 'yes',
          if (zoom != null) 'z': zoom!.toString(),
        },
      );

  @override
  Uri get fallbackLink => universalLink;
}

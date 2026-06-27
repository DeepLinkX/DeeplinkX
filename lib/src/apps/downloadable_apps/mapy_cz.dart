import 'package:deeplink_x/src/src.dart';

/// Mapy.cz / Mapy.com navigation app (iOS and Android).
class MapyCz extends App implements DownloadableApp {
  /// Creates a new [MapyCz] instance.
  MapyCz({this.fallbackToStore = false});

  /// Creates an action to open Mapy.cz (use with `launchApp`).
  factory MapyCz.open({final bool fallbackToStore = false}) => MapyCz(fallbackToStore: fallbackToStore);

  /// Store actions for Mapy.cz.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'cz.seznam.mapy'),
        IOSAppStore.openAppPage(appId: '411411020', appName: 'mapy-com-maps-gps-offline'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'cz.seznam.mapy';

  /// Custom scheme for install detection on iOS.
  @override
  String get customScheme => 'szn-mapy';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fallback to stores if the app is missing.
  @override
  bool fallbackToStore;

  /// Mapy.cz web fallback.
  @override
  Uri get website => Uri.parse('https://mapy.cz/');

  /// Creates an action that shows [coordinate] on Mapy.cz.
  static MapyCzViewAction view({
    required final Coordinate coordinate,
    final int zoom = 16,
    final bool fallbackToStore = false,
  }) =>
      MapyCzViewAction(
        coordinate: coordinate,
        zoom: zoom,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that opens directions/location detail for [destination].
  static MapyCzDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final bool fallbackToStore = false,
  }) =>
      MapyCzDirectionsWithCoordsAction(
        destination: destination,
        fallbackToStore: fallbackToStore,
      );
}

/// Mapy.cz show coordinate action.
class MapyCzViewAction extends MapyCz implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [MapyCzViewAction].
  MapyCzViewAction({
    required this.coordinate,
    required this.zoom,
    required super.fallbackToStore,
  });

  /// Coordinate to show on the map.
  @override
  final Coordinate coordinate;

  /// Map zoom level.
  final int zoom;

  @override
  Uri get appLink => _mapyLocationUri(
        coordinate: coordinate,
        queryParameters: {'z': zoom.toString()},
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => appLink;
}

/// Mapy.cz coordinate directions/location action.
class MapyCzDirectionsWithCoordsAction extends MapyCz
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [MapyCzDirectionsWithCoordsAction].
  MapyCzDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  @override
  Uri get appLink => _mapyLocationUri(coordinate: destination);

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => appLink;
}

Uri _mapyLocationUri({
  required final Coordinate coordinate,
  final Map<String, String> queryParameters = const {},
}) =>
    Uri(
      scheme: 'https',
      host: 'mapy.cz',
      path: 'zakladni',
      queryParameters: {
        'id': '${coordinate.longitude},${coordinate.latitude}',
        ...queryParameters,
        'source': 'coor',
      },
    );

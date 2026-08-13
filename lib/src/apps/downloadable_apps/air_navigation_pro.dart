import 'package:deeplink_x/src/src.dart';

/// Air Navigation Pro app (iOS and Android).
class AirNavigationPro extends App implements DownloadableApp {
  /// Creates a new [AirNavigationPro] instance.
  AirNavigationPro({this.fallbackToStore = false});

  /// Creates an action to open Air Navigation Pro (use with `launchApp`).
  factory AirNavigationPro.open({final bool fallbackToStore = false}) =>
      AirNavigationPro(fallbackToStore: fallbackToStore);

  /// Store actions for Air Navigation Pro.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.xample.airnavigation'),
        IOSAppStore.openAppPage(appId: '301046057', appName: 'air-navigation-pro'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.xample.airnavigation';

  /// Custom scheme for install detection and iOS deeplinks.
  @override
  String get customScheme => 'airnavpro';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fallback to stores if the app is missing.
  @override
  bool fallbackToStore;

  /// Air Navigation Pro website fallback.
  @override
  Uri get website => Uri.parse('https://airnavigation.aero/');

  /// Creates an action that opens the coordinate using Air Navigation Pro's direct-to URL.
  static AirNavigationProViewAction view({
    required final Coordinate coordinate,
    final bool fallbackToStore = false,
  }) =>
      AirNavigationProViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that opens Air Navigation Pro's direct-to flow.
  static AirNavigationProDirectToAction directTo({
    required final Coordinate destination,
    final bool fallbackToStore = false,
  }) =>
      AirNavigationProDirectToAction(
        destination: destination,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that starts directions to [destination].
  static AirNavigationProDirectToAction directionsWithCoords({
    required final Coordinate destination,
    final bool fallbackToStore = false,
  }) =>
      directTo(
        destination: destination,
        fallbackToStore: fallbackToStore,
      );
}

String _airNavigationProLocation(final Coordinate coordinate) => '${coordinate.latitude}_${coordinate.longitude},0.0';

Uri _airNavigationProAppLink(final Coordinate coordinate) => Uri.parse('airnavpro://direct-to').replace(
      queryParameters: {
        'coordinates': 'wgs84-decimal',
        'location': _airNavigationProLocation(coordinate),
      },
    );

Uri _airNavigationProWebLink(final Coordinate coordinate) => Uri(
      scheme: 'https',
      host: 'airnavigation.aero',
      path: 'direct-to',
      queryParameters: {
        'coordinates': 'wgs84-decimal',
        'location': _airNavigationProLocation(coordinate),
      },
    );

/// Air Navigation Pro view action.
class AirNavigationProViewAction extends AirNavigationPro
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [AirNavigationProViewAction].
  AirNavigationProViewAction({
    required this.coordinate,
    required super.fallbackToStore,
  });

  /// Coordinate to open with Air Navigation Pro's direct-to flow.
  @override
  final Coordinate coordinate;

  @override
  Uri get appLink => _airNavigationProAppLink(coordinate);

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: fallbackLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => _airNavigationProWebLink(coordinate);
}

/// Air Navigation Pro direct-to action.
class AirNavigationProDirectToAction extends AirNavigationPro
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [AirNavigationProDirectToAction].
  AirNavigationProDirectToAction({
    required this.destination,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  @override
  Uri get appLink => _airNavigationProAppLink(destination);

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: fallbackLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => _airNavigationProWebLink(destination);
}

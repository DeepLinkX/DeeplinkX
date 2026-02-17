import 'package:deeplink_x/src/src.dart';

/// Sygic GPS Navigation app (iOS and Android).
///
/// Implements the Sygic custom URI scheme documented by Sygic for launching
/// coordinates in view or navigation mode.
class Sygic extends App implements DownloadableApp {
  /// Creates a new [Sygic] instance.
  Sygic({this.fallbackToStore = false});

  /// Creates an action to open the Sygic app (use with `launchApp`).
  factory Sygic.open({final bool fallbackToStore = false}) => Sygic(fallbackToStore: fallbackToStore);

  /// Store actions for Sygic GPS Navigation.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.sygic.aura'),
        IOSAppStore.openAppPage(appId: '585193266', appName: 'sygic-gps-navigation-offline'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.sygic.aura';

  /// Custom scheme for install detection and deeplinks.
  @override
  String get customScheme => 'com.sygic.aura';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fallback to store if the app is missing.
  @override
  bool fallbackToStore;

  /// Sygic website for general fallback.
  @override
  Uri get website => Uri.parse('https://www.sygic.com/gps-navigation');

  /// Creates an action that shows a coordinate on the map.
  static SygicViewAction view({
    required final Coordinate coordinate,
    final bool fallbackToStore = false,
  }) =>
      SygicViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that starts navigation to the [destination] coordinates.
  static SygicDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final SygicTransportMode mode = SygicTransportMode.drive,
    final bool fallbackToStore = false,
  }) =>
      SygicDirectionsWithCoordsAction(
        destination: destination,
        mode: mode,
        fallbackToStore: fallbackToStore,
      );
}

/// Sygic renders modes accepted by the coordinate URI.
enum SygicTransportMode {
  /// Driving navigation (default).
  drive('drive'),

  /// Walking navigation.
  walk('walk');

  /// Creates a new [SygicTransportMode].
  const SygicTransportMode(this.value);

  /// Value injected into the Sygic coordinate URI.
  final String value;
}

/// Sygic show coordinate action.
class SygicViewAction extends Sygic implements AppLinkAppAction, Fallbackable {
  /// Creates a new [SygicViewAction].
  SygicViewAction({
    required this.coordinate,
    required super.fallbackToStore,
  });

  /// Coordinate to show on the map.
  final Coordinate coordinate;

  @override
  Uri get appLink => Uri.parse(
        [
          'com.sygic.aura://coordinate',
          coordinate.longitude,
          coordinate.latitude,
          'show',
        ].join('|'),
      );

  @override
  Uri get fallbackLink => website;
}

/// Sygic turn-by-turn navigation action.
class SygicDirectionsWithCoordsAction extends Sygic implements AppLinkAppAction, Fallbackable {
  /// Creates a new [SygicDirectionsWithCoordsAction].
  SygicDirectionsWithCoordsAction({
    required this.destination,
    required this.mode,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  final Coordinate destination;

  /// Selected transport mode.
  final SygicTransportMode mode;

  @override
  Uri get appLink => Uri.parse(
        [
          'com.sygic.aura://coordinate',
          destination.longitude,
          destination.latitude,
          mode.value,
        ].join('|'),
      );

  @override
  Uri get fallbackLink => website;
}

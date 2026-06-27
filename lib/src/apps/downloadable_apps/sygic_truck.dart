import 'package:deeplink_x/src/src.dart';

const _newTaskFlag = 0x10000000;

/// Sygic Truck & RV Navigation app for iOS and Android.
class SygicTruck extends App implements DownloadableApp {
  /// Creates a new [SygicTruck] instance.
  SygicTruck({this.fallbackToStore = false});

  /// Creates an action to open Sygic Truck.
  factory SygicTruck.open({final bool fallbackToStore = false}) => SygicTruck(fallbackToStore: fallbackToStore);

  /// Store actions for Sygic Truck.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.sygic.truck'),
        IOSAppStore.openAppPage(appId: '992127700', appName: 'sygic-truck-rv-navigation'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.sygic.truck';

  /// Custom scheme for install detection and deeplinks.
  @override
  String get customScheme => 'com.sygic.aura';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// Sygic Truck website.
  @override
  Uri get website => Uri.parse('https://www.sygic.com/truck-gps-navigation');

  /// Creates an action that shows [coordinate] in Sygic Truck.
  static SygicTruckViewAction view({
    required final Coordinate coordinate,
    final bool fallbackToStore = false,
  }) =>
      SygicTruckViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a coordinate navigation action.
  static SygicTruckDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final bool fallbackToStore = false,
  }) =>
      SygicTruckDirectionsWithCoordsAction(
        destination: destination,
        fallbackToStore: fallbackToStore,
      );
}

/// Shows a coordinate in Sygic Truck.
class SygicTruckViewAction extends SygicTruck implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [SygicTruckViewAction].
  SygicTruckViewAction({
    required this.coordinate,
    required super.fallbackToStore,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  @override
  Uri get appLink => _sygicTruckCoordinateUri(coordinate, 'show');

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [_newTaskFlag],
      );

  @override
  Uri get fallbackLink => website;
}

/// Builds a coordinate route in Sygic Truck.
class SygicTruckDirectionsWithCoordsAction extends SygicTruck
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [SygicTruckDirectionsWithCoordsAction].
  SygicTruckDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  @override
  Uri get appLink => _sygicTruckCoordinateUri(destination, 'drive');

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [_newTaskFlag],
      );

  @override
  Uri get fallbackLink => website;
}

Uri _sygicTruckCoordinateUri(final Coordinate coordinate, final String action) => Uri.parse(
      [
        'com.sygic.aura://coordinate',
        coordinate.longitude,
        coordinate.latitude,
        action,
      ].join('|'),
    );

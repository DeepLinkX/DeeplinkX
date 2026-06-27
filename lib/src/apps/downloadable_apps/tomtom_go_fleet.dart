import 'package:deeplink_x/src/src.dart';

const _newTaskFlag = 0x10000000;

/// TomTom Go Fleet app for iOS and Android.
class TomTomGoFleet extends App implements DownloadableApp {
  /// Creates a new [TomTomGoFleet] instance.
  TomTomGoFleet({this.fallbackToStore = false});

  /// Creates an action to open TomTom Go Fleet.
  factory TomTomGoFleet.open({final bool fallbackToStore = false}) => TomTomGoFleet(fallbackToStore: fallbackToStore);

  /// Store actions for TomTom Go Fleet.
  ///
  /// The public store listing exposed by upstream map launcher metadata is
  /// Android-only; iOS still supports scheme detection and web fallback.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.tomtom.gplay.navapp.gofleet'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.tomtom.gplay.navapp.gofleet';

  /// Custom scheme.
  @override
  String get customScheme => 'tomtomgofleet';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// TomTom fleet website.
  @override
  Uri get website => Uri.parse('https://www.tomtom.com/solutions/fleet-management-logistics/');

  /// Creates an action that shows [coordinate] in TomTom Go Fleet.
  static TomTomGoFleetViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final bool fallbackToStore = false,
  }) =>
      TomTomGoFleetViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
        title: title,
      );

  /// Creates a coordinate navigation action.
  static TomTomGoFleetDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final bool fallbackToStore = false,
  }) =>
      TomTomGoFleetDirectionsWithCoordsAction(
        destination: destination,
        fallbackToStore: fallbackToStore,
      );
}

/// Shows a coordinate in TomTom Go Fleet.
class TomTomGoFleetViewAction extends TomTomGoFleet implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [TomTomGoFleetViewAction].
  TomTomGoFleetViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    this.title,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Optional marker title.
  final String? title;

  @override
  Uri get appLink => _geoUri(coordinate, title);

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: _geoUri(coordinate, title).toString(),
        package: androidPackageName,
        flags: const [_newTaskFlag],
      );

  @override
  Uri get fallbackLink => website;
}

/// Builds a coordinate route in TomTom Go Fleet.
class TomTomGoFleetDirectionsWithCoordsAction extends TomTomGoFleet
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [TomTomGoFleetDirectionsWithCoordsAction].
  TomTomGoFleetDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  @override
  Uri get appLink => Uri.parse(_navigationData(destination));

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: _navigationData(destination),
        package: androidPackageName,
        flags: const [_newTaskFlag],
      );

  @override
  Uri get fallbackLink => website;
}

Uri _geoUri(final Coordinate coordinate, final String? title) {
  final coordinateText = coordinate.toString();
  final titleText = title == null || title.isEmpty ? '' : Uri.encodeComponent(title);
  return Uri.parse('geo:$coordinateText?q=$coordinateText$titleText');
}

String _navigationData(final Coordinate destination) => 'google.navigation:?q=${destination.toString()}';

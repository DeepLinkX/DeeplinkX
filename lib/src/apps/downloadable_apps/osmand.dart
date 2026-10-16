import 'package:deeplink_x/src/src.dart';

/// OsmAnd app for iOS and Android.
class OsmAnd extends App implements DownloadableApp {
  /// Creates a new [OsmAnd.new] instance.
  OsmAnd({this.fallbackToStore = false});

  /// Creates an action to open the OsmAnd app.
  factory OsmAnd.open({final bool fallbackToStore = false}) => OsmAnd(fallbackToStore: fallbackToStore);

  /// Creates an action to show [coordinate] on the map.
  static OsmAndViewAction view({
    required final Coordinate coordinate,
    final int zoom = 15,
    final bool fallbackToStore = false,
  }) =>
      OsmAndViewAction(
        coordinate: coordinate,
        zoom: zoom,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a coordinate-based directions action.
  ///
  /// Requests native directions from the current location. The web fallback
  /// preselects the destination; the user may need to choose a starting point.
  static OsmAndDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final bool fallbackToStore = false,
  }) =>
      OsmAndDirectionsWithCoordsAction(
        destination: destination,
        fallbackToStore: fallbackToStore,
      );

  /// Store actions for OsmAnd.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'net.osmand'),
        IOSAppStore.openAppPage(
          appId: '934850257',
          appName: 'osmand-maps-travel-navigate',
        ),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'net.osmand';

  /// The legacy scheme used for iOS installation checks and whole-app opening.
  ///
  /// Navigation actions use HTTPS links instead. Current source registers a
  /// configurable scheme; this legacy value still needs device validation.
  @override
  String get customScheme => 'osmandmaps';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// OsmAnd website used as the app fallback.
  @override
  Uri get website => Uri.parse('https://osmand.net');
}

/// Shows a coordinate in OsmAnd.
class OsmAndViewAction extends OsmAnd implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates an OsmAnd view action.
  OsmAndViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    required this.zoom,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Map zoom.
  final int zoom;

  Map<String, String> get _queryParameters => {
        'lat': coordinate.latitude.toString(),
        'lon': coordinate.longitude.toString(),
        'z': zoom.toString(),
      };

  @override
  Uri get appLink => fallbackLink;

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: Uri(
          scheme: 'https',
          host: 'osmand.net',
          path: 'go',
          queryParameters: _queryParameters,
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'osmand.net',
        path: 'map/',
        queryParameters: {'pin': coordinate.toString()},
        fragment: '$zoom/${coordinate.latitude}/${coordinate.longitude}',
      );
}

/// Builds a coordinate route in OsmAnd.
class OsmAndDirectionsWithCoordsAction extends OsmAnd
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates an OsmAnd coordinate directions action.
  OsmAndDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  @override
  Uri get appLink => Uri(
        scheme: 'https',
        host: 'osmand.net',
        path: 'map/',
        queryParameters: {
          'end': destination.toString(),
          'finish': destination.toString(),
        },
        fragment: '15/${destination.latitude}/${destination.longitude}',
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: 'osmand.navigation:q=${destination.toString()}',
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'osmand.net',
        path: 'map/',
        queryParameters: {'finish': destination.toString()},
        fragment: '15/${destination.latitude}/${destination.longitude}',
      );
}

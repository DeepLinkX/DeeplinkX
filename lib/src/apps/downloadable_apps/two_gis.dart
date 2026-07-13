import 'package:deeplink_x/src/src.dart';

/// 2GIS app for iOS and Android.
class TwoGis extends App implements DownloadableApp {
  /// Creates a new [TwoGis] instance.
  TwoGis({this.fallbackToStore = false});

  /// Creates an action to open the 2GIS app.
  factory TwoGis.open({final bool fallbackToStore = false}) => TwoGis(fallbackToStore: fallbackToStore);

  /// Creates an action to show [coordinate] on the map.
  ///
  /// Android 2GIS does not support a marker-by-coordinate URI, so the Android
  /// intent opens the supported route flow to the coordinate.
  static TwoGisViewAction view({
    required final Coordinate coordinate,
    final bool fallbackToStore = false,
  }) =>
      TwoGisViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a coordinate-based directions action.
  static TwoGisDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final TwoGisTravelMode mode = TwoGisTravelMode.driving,
    final bool fallbackToStore = false,
  }) =>
      TwoGisDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        mode: mode,
        fallbackToStore: fallbackToStore,
      );

  /// Store actions for 2GIS.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'ru.dublgis.dgismobile'),
        IOSAppStore.openAppPage(
          appId: '481627348',
          appName: '2gis-map-navigation-tracker',
        ),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'ru.dublgis.dgismobile';

  /// Custom scheme for 2GIS.
  @override
  String get customScheme => 'dgis';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// 2GIS website used as the app fallback.
  @override
  Uri get website => Uri.parse('https://2gis.ru');
}

/// 2GIS travel modes.
enum TwoGisTravelMode {
  /// Compatibility alias for car routing.
  @Deprecated('Use TwoGisTravelMode.driving instead.')
  auto('car', androidValue: 'car'),

  /// Car routing.
  driving('car', androidValue: 'car'),

  /// Public transit routing.
  transit('ctx', androidValue: 'bus'),

  /// Walking routing.
  walking('pedestrian', androidValue: 'pedestrian');

  const TwoGisTravelMode(this.value, {required this.androidValue});

  /// Provider-documented URI path value used by custom links and fallbacks.
  final String value;

  /// URI path value accepted by the current Android app.
  final String androidValue;
}

/// Shows a coordinate in 2GIS.
class TwoGisViewAction extends TwoGis implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a 2GIS view action.
  TwoGisViewAction({
    required this.coordinate,
    required super.fallbackToStore,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  @override
  Uri get appLink => _twoGisUri('geo/${_lngLat(coordinate)}');

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: _twoGisUri('routeSearch/rsType/car/to/${_lngLat(coordinate)}').toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => _twoGisWebUri('geo/${_lngLat(coordinate)}');
}

/// Builds a coordinate route in 2GIS.
class TwoGisDirectionsWithCoordsAction extends TwoGis
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a 2GIS coordinate directions action.
  TwoGisDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.mode = TwoGisTravelMode.driving,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Travel mode.
  final TwoGisTravelMode mode;

  String _routePath(final String travelMode) => [
        'routeSearch',
        'rsType',
        travelMode,
        if (origin != null) ...['from', _lngLat(origin!)],
        'to',
        _lngLat(destination),
      ].join('/');

  @override
  Uri get appLink => _twoGisUri(_routePath(mode.value));

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: _twoGisUri(_routePath(mode.androidValue)).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => _twoGisWebUri(_routePath(mode.value));
}

String _lngLat(final Coordinate coordinate) => '${coordinate.longitude},${coordinate.latitude}';

Uri _twoGisUri(final String path) => Uri.parse('dgis://2gis.ru/$path');

Uri _twoGisWebUri(final String path) => Uri.parse('https://2gis.ru/$path');

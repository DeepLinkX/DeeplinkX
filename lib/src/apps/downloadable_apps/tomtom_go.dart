import 'package:deeplink_x/src/src.dart';

const _newTaskFlag = 0x10000000;

/// TomTom Go app for iOS and Android.
class TomTomGo extends App implements DownloadableApp {
  /// Creates a new [TomTomGo] instance.
  TomTomGo({this.fallbackToStore = false});

  /// Creates an action to open TomTom Go.
  factory TomTomGo.open({final bool fallbackToStore = false}) => TomTomGo(fallbackToStore: fallbackToStore);

  /// Store actions for TomTom Go.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.tomtom.gplay.navapp'),
        IOSAppStore.openAppPage(appId: '884963367', appName: 'tomtom-go-expert-truck-gps'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.tomtom.gplay.navapp';

  /// Custom scheme.
  @override
  String get customScheme => 'tomtomgo';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// TomTom Go website.
  @override
  Uri get website => Uri.parse('https://www.tomtom.com/navigation/mobile-apps/go-navigation-app/');

  /// Creates an action that shows [coordinate] in TomTom Go.
  ///
  /// On iOS, TomTom Go only exposes its navigation URL, so the iOS app link
  /// opens the same coordinate through the navigation endpoint.
  static TomTomGoViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final bool fallbackToStore = false,
  }) =>
      TomTomGoViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
        title: title,
      );

  /// Creates a coordinate navigation action.
  static TomTomGoDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final bool fallbackToStore = false,
  }) =>
      TomTomGoDirectionsWithCoordsAction(
        destination: destination,
        fallbackToStore: fallbackToStore,
      );
}

/// Shows a coordinate in TomTom Go.
class TomTomGoViewAction extends TomTomGo implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [TomTomGoViewAction].
  TomTomGoViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    this.title,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Optional marker title for Android.
  final String? title;

  @override
  Uri get appLink => _tomTomNavigateUri(coordinate);

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

/// Builds a coordinate route in TomTom Go.
class TomTomGoDirectionsWithCoordsAction extends TomTomGo
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [TomTomGoDirectionsWithCoordsAction].
  TomTomGoDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  @override
  Uri get appLink => _tomTomNavigateUri(destination);

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: 'google.navigation:q=${destination.toString()}',
        package: androidPackageName,
        flags: const [_newTaskFlag],
      );

  @override
  Uri get fallbackLink => website;
}

Uri _tomTomNavigateUri(final Coordinate coordinate) => Uri(
      scheme: 'tomtomgo',
      host: 'x-callback-url',
      path: 'navigate',
      queryParameters: {'destination': coordinate.toString()},
    );

Uri _geoUri(final Coordinate coordinate, final String? title) {
  final coordinateText = coordinate.toString();
  final titleText = title == null || title.isEmpty ? '' : '(${Uri.encodeComponent(title)})';
  return Uri.parse('geo:$coordinateText?q=$coordinateText$titleText');
}

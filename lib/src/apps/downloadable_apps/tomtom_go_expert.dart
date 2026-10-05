import 'package:deeplink_x/src/src.dart';

const _newTaskFlag = 0x10000000;

/// Experimental TomTom GO Expert app and navigation actions.
///
/// This unpublished draft preserves proposed links from the PR; their GO Expert
/// contract and device behavior have not been verified. Store identities and
/// branding are confirmed separately. See `doc/apps/tomtom_go_expert.md`.
class TomTomGoExpert extends App implements DownloadableApp {
  /// Creates a new [TomTomGoExpert] instance.
  TomTomGoExpert({this.fallbackToStore = false});

  /// Creates an action to open TomTom GO Expert.
  factory TomTomGoExpert.open({final bool fallbackToStore = false}) => TomTomGoExpert(fallbackToStore: fallbackToStore);

  /// Store actions for TomTom GO Expert.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.tomtom.gplay.navapp'),
        IOSAppStore.openAppPage(appId: '884963367', appName: 'tomtom-go-expert-truck-gps'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.tomtom.gplay.navapp';

  /// Proposed, unverified iOS scheme.
  @override
  String get customScheme => 'tomtomgo';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Target platforms for this unverified draft.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// TomTom GO Expert website.
  @override
  Uri get website => Uri.parse('https://www.tomtom.com/navigation/mobile-apps/go-expert-app/');

  /// Creates a proposed view action for [coordinate].
  ///
  /// The proposed iOS link uses a navigation endpoint, not a view-only endpoint.
  /// This link and the Android intent remain unverified for GO Expert.
  static TomTomGoExpertViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final bool fallbackToStore = false,
  }) =>
      TomTomGoExpertViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
        title: title,
      );

  /// Creates an experimental coordinate navigation action.
  ///
  /// The generated links are proposals, not a verified provider contract.
  static TomTomGoExpertDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final bool fallbackToStore = false,
  }) =>
      TomTomGoExpertDirectionsWithCoordsAction(
        destination: destination,
        fallbackToStore: fallbackToStore,
      );
}

/// Experimental coordinate view action for TomTom GO Expert.
class TomTomGoExpertViewAction extends TomTomGoExpert implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [TomTomGoExpertViewAction].
  TomTomGoExpertViewAction({
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

/// Experimental coordinate navigation action for TomTom GO Expert.
class TomTomGoExpertDirectionsWithCoordsAction extends TomTomGoExpert
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [TomTomGoExpertDirectionsWithCoordsAction].
  TomTomGoExpertDirectionsWithCoordsAction({
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

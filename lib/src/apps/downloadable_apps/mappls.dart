import 'package:deeplink_x/src/src.dart';

/// Mappls MapmyIndia navigation app (iOS and Android).
class Mappls extends App implements DownloadableApp {
  /// Creates a new [Mappls] instance.
  Mappls({this.fallbackToStore = false});

  /// Creates an action to open Mappls (use with `launchApp`).
  factory Mappls.open({final bool fallbackToStore = false}) => Mappls(fallbackToStore: fallbackToStore);

  /// Store actions for Mappls.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.mmi.maps'),
        IOSAppStore.openAppPage(appId: '723492531', appName: 'mappls-mapmyindia-maps'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.mmi.maps';

  /// Custom scheme for install detection.
  @override
  String get customScheme => 'mappls';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fallback to stores if the app is missing.
  @override
  bool fallbackToStore;

  /// Mappls web fallback.
  @override
  Uri get website => Uri.parse('https://www.mappls.com/');

  /// Creates an action that shows [coordinate] on Mappls.
  static MapplsViewAction view({
    required final Coordinate coordinate,
    final bool fallbackToStore = false,
  }) =>
      MapplsViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that starts directions to [destination].
  static MapplsDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final String? destinationTitle,
    final MapplsTravelMode mode = MapplsTravelMode.driving,
    final bool fallbackToStore = false,
  }) =>
      MapplsDirectionsWithCoordsAction(
        destination: destination,
        destinationTitle: destinationTitle,
        mode: mode,
        fallbackToStore: fallbackToStore,
      );
}

/// Travel modes supported by Mappls directions links.
enum MapplsTravelMode {
  /// Driving route.
  driving('driving'),

  /// Walking route.
  walking('walking'),

  /// Bicycling route.
  bicycling('biking'),

  /// Transit/default route.
  transit('d');

  /// Creates a new [MapplsTravelMode].
  const MapplsTravelMode(this.value);

  /// Value injected into the Mappls route URL.
  final String value;
}

/// Mappls show coordinate action.
class MapplsViewAction extends Mappls implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [MapplsViewAction].
  MapplsViewAction({
    required this.coordinate,
    required super.fallbackToStore,
  });

  /// Coordinate to show on the map.
  @override
  final Coordinate coordinate;

  @override
  Uri get appLink => Uri(
        scheme: 'https',
        host: 'www.mappls.com',
        path: 'location/${coordinate.latitude},${coordinate.longitude}',
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

/// Mappls coordinate directions action.
class MapplsDirectionsWithCoordsAction extends Mappls
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [MapplsDirectionsWithCoordsAction].
  MapplsDirectionsWithCoordsAction({
    required this.destination,
    required this.destinationTitle,
    required this.mode,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional destination label.
  final String? destinationTitle;

  /// Selected travel mode.
  final MapplsTravelMode mode;

  @override
  Uri get appLink {
    final title = destinationTitle;
    final places = '${destination.latitude},${destination.longitude}${title == null || title.isEmpty ? '' : ',$title'}';

    return Uri(
      scheme: 'https',
      host: 'mappls.com',
      path: 'navigation',
      queryParameters: {
        'places': places,
        'mode': mode.value,
      },
    );
  }

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

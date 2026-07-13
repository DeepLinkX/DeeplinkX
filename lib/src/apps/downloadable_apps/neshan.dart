import 'package:deeplink_x/src/src.dart';

/// Neshan Map app (iOS and Android).
class Neshan extends App implements DownloadableApp {
  /// Creates a new [Neshan] instance.
  Neshan({this.fallbackToStore = false});

  /// Creates an action to open Neshan (use with `launchApp`).
  factory Neshan.open({final bool fallbackToStore = false}) => Neshan(fallbackToStore: fallbackToStore);

  /// Store actions for Neshan.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'org.rajman.neshan.traffic.tehran.navigator'),
        IOSAppStore.openAppPage(appId: '1548188093', appName: 'neshan-map'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'org.rajman.neshan.traffic.tehran.navigator';

  /// Custom scheme for install detection and iOS deeplinks.
  @override
  String get customScheme => 'neshan';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fallback to stores if the app is missing.
  @override
  bool fallbackToStore;

  /// Neshan web map fallback.
  @override
  Uri get website => Uri.parse('https://neshan.org/maps');

  /// Creates an action that shows [coordinate] on the map.
  static NeshanViewAction view({
    required final Coordinate coordinate,
    final bool fallbackToStore = false,
  }) =>
      NeshanViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that starts directions to [destination].
  static NeshanDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final bool fallbackToStore = false,
  }) =>
      NeshanDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        fallbackToStore: fallbackToStore,
      );
}

/// Neshan view action.
class NeshanViewAction extends Neshan implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [NeshanViewAction].
  NeshanViewAction({
    required this.coordinate,
    required super.fallbackToStore,
  });

  /// Coordinate to show on the map.
  @override
  final Coordinate coordinate;

  @override
  Uri get appLink => Uri.parse('neshan://').replace(
        queryParameters: {'destination': coordinate.toString()},
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: Uri(
          scheme: 'https',
          host: 'nshn.ir',
          queryParameters: {
            'lat': coordinate.latitude.toString(),
            'lng': coordinate.longitude.toString(),
          },
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'neshan.org',
        pathSegments: ['maps', 'share', coordinate.toString()],
      );
}

/// Neshan coordinate directions action.
class NeshanDirectionsWithCoordsAction extends Neshan
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [NeshanDirectionsWithCoordsAction].
  NeshanDirectionsWithCoordsAction({
    required this.destination,
    required this.origin,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate. Omit to start from current location.
  final Coordinate? origin;

  @override
  Uri get appLink {
    final routeOrigin = origin;

    return Uri.parse('neshan://').replace(
      queryParameters: {
        if (routeOrigin != null) 'origin': routeOrigin.toString(),
        'destination': destination.toString(),
      },
    );
  }

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: _androidRouteLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;

  Uri get _androidRouteLink {
    final routeOrigin = origin;

    return Uri(
      scheme: 'https',
      host: 'nshn.ir',
      path: '/',
      queryParameters: {
        if (routeOrigin != null) 'origin': routeOrigin.toString(),
        'destination': destination.toString(),
      },
    );
  }
}

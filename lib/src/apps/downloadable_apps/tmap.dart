import 'package:deeplink_x/src/src.dart';

/// TMAP navigation app (iOS and Android).
class TMap extends App implements DownloadableApp {
  /// Creates a new [TMap] instance.
  TMap({this.fallbackToStore = false});

  /// Creates an action to open TMAP (use with `launchApp`).
  factory TMap.open({final bool fallbackToStore = false}) => TMap(fallbackToStore: fallbackToStore);

  /// Store actions for TMAP.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.skt.tmap.ku'),
        IOSAppStore.openAppPage(appId: '431589174', appName: 'tmap'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.skt.tmap.ku';

  /// Custom scheme for install detection and deeplinks.
  @override
  String get customScheme => 'tmap';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fallback to stores if the app is missing.
  @override
  bool fallbackToStore;

  /// TMAP web fallback.
  @override
  Uri get website => Uri.parse('https://www.tmap.co.kr/');

  /// Creates an action that shows [coordinate] on TMAP.
  static TMapViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final bool fallbackToStore = false,
  }) =>
      TMapViewAction(
        coordinate: coordinate,
        title: title,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that starts directions to [destination].
  static TMapDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final bool fallbackToStore = false,
  }) =>
      TMapDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        destinationTitle: destinationTitle,
        originTitle: originTitle,
        fallbackToStore: fallbackToStore,
      );
}

/// TMAP show coordinate action.
class TMapViewAction extends TMap implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [TMapViewAction].
  TMapViewAction({
    required this.coordinate,
    required this.title,
    required super.fallbackToStore,
  });

  /// Coordinate to show on the map.
  @override
  final Coordinate coordinate;

  /// Optional label for the coordinate.
  final String? title;

  @override
  Uri get appLink => Uri(
        scheme: 'tmap',
        host: 'viewmap',
        queryParameters: {
          if (title != null) 'name': title,
          'x': coordinate.longitude.toString(),
          'y': coordinate.latitude.toString(),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;
}

/// TMAP coordinate directions action.
class TMapDirectionsWithCoordsAction extends TMap
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [TMapDirectionsWithCoordsAction].
  TMapDirectionsWithCoordsAction({
    required this.destination,
    required this.origin,
    required this.destinationTitle,
    required this.originTitle,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional destination label.
  final String? destinationTitle;

  /// Optional origin label.
  final String? originTitle;

  @override
  Uri get appLink {
    final routeOrigin = origin;
    final routeOriginTitle = originTitle;
    final routeDestinationTitle = destinationTitle;

    return Uri(
      scheme: 'tmap',
      host: 'route',
      queryParameters: {
        if (routeOriginTitle != null) 'startname': routeOriginTitle,
        if (routeOrigin != null) 'startx': routeOrigin.longitude.toString(),
        if (routeOrigin != null) 'starty': routeOrigin.latitude.toString(),
        if (routeDestinationTitle != null) 'goalname': routeDestinationTitle,
        'goaly': destination.latitude.toString(),
        'goalx': destination.longitude.toString(),
        'carType': '1',
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
  Uri get fallbackLink => website;
}

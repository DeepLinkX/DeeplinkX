import 'package:deeplink_x/src/src.dart';

/// KakaoMap navigation app (iOS and Android).
class KakaoMap extends App implements DownloadableApp {
  /// Creates a new [KakaoMap] instance.
  KakaoMap({this.fallbackToStore = false});

  /// Creates an action to open KakaoMap (use with `launchApp`).
  factory KakaoMap.open({final bool fallbackToStore = false}) => KakaoMap(fallbackToStore: fallbackToStore);

  /// Store actions for KakaoMap.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'net.daum.android.map'),
        IOSAppStore.openAppPage(appId: '304608425', appName: 'kakaomap-korea-no-1-map'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'net.daum.android.map';

  /// Custom scheme for install detection and deeplinks.
  @override
  String get customScheme => 'kakaomap';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fallback to stores if the app is missing.
  @override
  bool fallbackToStore;

  /// KakaoMap web fallback.
  @override
  Uri get website => Uri.parse('https://map.kakao.com/');

  /// Creates an action that shows [coordinate] on KakaoMap.
  static KakaoMapViewAction view({
    required final Coordinate coordinate,
    final bool fallbackToStore = false,
  }) =>
      KakaoMapViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that starts directions to [destination].
  static KakaoMapDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final bool fallbackToStore = false,
  }) =>
      KakaoMapDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        fallbackToStore: fallbackToStore,
      );
}

/// KakaoMap show coordinate action.
class KakaoMapViewAction extends KakaoMap
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [KakaoMapViewAction].
  KakaoMapViewAction({
    required this.coordinate,
    required super.fallbackToStore,
  });

  /// Coordinate to show on the map.
  @override
  final Coordinate coordinate;

  @override
  Uri get appLink => Uri(
        scheme: 'kakaomap',
        host: 'look',
        queryParameters: {'p': coordinate.toString()},
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

/// KakaoMap coordinate directions action.
class KakaoMapDirectionsWithCoordsAction extends KakaoMap
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [KakaoMapDirectionsWithCoordsAction].
  KakaoMapDirectionsWithCoordsAction({
    required this.destination,
    required this.origin,
    required super.fallbackToStore,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  @override
  Uri get appLink => Uri(
        scheme: 'kakaomap',
        host: 'route',
        queryParameters: {
          if (origin != null) 'sp': origin.toString(),
          'ep': destination.toString(),
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

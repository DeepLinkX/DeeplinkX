import 'package:deeplink_x/src/src.dart';

const _newTaskFlag = 0x10000000;

/// NAVER Maps app for iOS and Android.
class NaverMap extends App implements DownloadableApp {
  /// Creates a new [NaverMap] instance.
  NaverMap({this.fallbackToStore = false});

  /// Creates an action to open NAVER Maps.
  factory NaverMap.open({final bool fallbackToStore = false}) => NaverMap(fallbackToStore: fallbackToStore);

  /// Store actions for NAVER Maps.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.nhn.android.nmap'),
        IOSAppStore.openAppPage(appId: '311867728', appName: 'naver-maps-navigation'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.nhn.android.nmap';

  /// Custom scheme.
  @override
  String get customScheme => 'nmap';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// NAVER Maps website.
  @override
  Uri get website => Uri.parse('https://map.naver.com/');

  /// Creates an action that shows [coordinate] in NAVER Maps.
  static NaverMapViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final int zoom = 16,
    final bool fallbackToStore = false,
  }) =>
      NaverMapViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
        title: title,
        zoom: zoom,
      );

  /// Creates a coordinate navigation action.
  static NaverMapDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final bool fallbackToStore = false,
  }) =>
      NaverMapDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        destinationTitle: destinationTitle,
        originTitle: originTitle,
        fallbackToStore: fallbackToStore,
      );
}

/// Shows a coordinate in NAVER Maps.
class NaverMapViewAction extends NaverMap implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [NaverMapViewAction].
  NaverMapViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    required this.zoom,
    this.title,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Optional marker title.
  final String? title;

  /// Map zoom level.
  final int zoom;

  @override
  Uri get appLink => _buildNaverUri(
        host: 'place',
        queryParameters: {
          'lat': coordinate.latitude.toString(),
          'lng': coordinate.longitude.toString(),
          'zoom': zoom.toString(),
          if (title != null && title!.isNotEmpty) 'name': title!,
        },
      );

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

/// Builds a coordinate route in NAVER Maps.
class NaverMapDirectionsWithCoordsAction extends NaverMap
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [NaverMapDirectionsWithCoordsAction].
  NaverMapDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.destinationTitle,
    this.originTitle,
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
  Uri get appLink => _buildNaverUri(
        host: 'route',
        path: 'car',
        queryParameters: {
          if (origin != null) 'slat': origin!.latitude.toString(),
          if (origin != null) 'slng': origin!.longitude.toString(),
          if (originTitle != null && originTitle!.isNotEmpty) 'sname': originTitle!,
          'dlat': destination.latitude.toString(),
          'dlng': destination.longitude.toString(),
          if (destinationTitle != null && destinationTitle!.isNotEmpty) 'dname': destinationTitle!,
        },
      );

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

Uri _buildNaverUri({
  required final String host,
  required final Map<String, String> queryParameters,
  final String? path,
}) =>
    Uri(
      scheme: 'nmap',
      host: host,
      path: path,
      queryParameters: queryParameters,
    );

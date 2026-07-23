import 'package:deeplink_x/src/src.dart';

/// Yandex Navigator app for iOS and Android.
class YandexNavigator extends App implements DownloadableApp {
  /// Creates a new [YandexNavigator] instance.
  YandexNavigator({this.fallbackToStore = false});

  /// Creates an action to open the Yandex Navigator app.
  factory YandexNavigator.open({final bool fallbackToStore = false}) =>
      YandexNavigator(fallbackToStore: fallbackToStore);

  /// Creates an action to show [coordinate] on the map.
  static YandexNavigatorViewAction view({
    required final Coordinate coordinate,
    final int zoom = 18,
    final bool showBalloon = true,
    final String? description,
    final YandexNavigatorLaunchParams? launchParams,
    final bool fallbackToStore = false,
  }) =>
      YandexNavigatorViewAction(
        coordinate: coordinate,
        zoom: zoom,
        showBalloon: showBalloon,
        description: description,
        launchParams: launchParams,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to search for [query].
  static YandexNavigatorSearchAction search({
    required final String query,
    final YandexNavigatorLaunchParams? launchParams,
    final bool fallbackToStore = false,
  }) =>
      YandexNavigatorSearchAction(
        query: query,
        launchParams: launchParams,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a coordinate-based directions action.
  static YandexNavigatorDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final List<YandexNavigatorWaypoint> waypoints = const [],
    final YandexNavigatorLaunchParams? launchParams,
    final bool fallbackToStore = false,
  }) =>
      YandexNavigatorDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        waypoints: waypoints,
        launchParams: launchParams,
        fallbackToStore: fallbackToStore,
      );

  /// Store actions for Yandex Navigator.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'ru.yandex.yandexnavi'),
        IOSAppStore.openAppPage(
          appId: '474500851',
          appName: 'yandex-navi-navigation-maps',
        ),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'ru.yandex.yandexnavi';

  /// Custom scheme for Yandex Navigator.
  @override
  String get customScheme => 'yandexnavi';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// Yandex Maps website used as the web fallback.
  @override
  Uri get website => Uri.parse('https://yandex.com/maps');
}

/// Optional Yandex Navigator URL identification parameters.
class YandexNavigatorLaunchParams {
  /// Creates optional launch identification parameters.
  const YandexNavigatorLaunchParams({
    this.client,
    this.signature,
  });

  /// Client identifier issued by Yandex.
  final String? client;

  /// URL signature generated with the Yandex access key.
  final String? signature;

  Map<String, String> get _queryParameters => {
        if (client != null) 'client': client!,
        if (signature != null) 'signature': signature!,
      };
}

/// A route waypoint for Yandex Navigator coordinate directions.
class YandexNavigatorWaypoint {
  /// Creates a waypoint.
  const YandexNavigatorWaypoint({required this.coordinate});

  /// Waypoint coordinate.
  final Coordinate coordinate;
}

/// Shows a coordinate in Yandex Navigator.
class YandexNavigatorViewAction extends YandexNavigator implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a Yandex Navigator view action.
  YandexNavigatorViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    required this.zoom,
    required this.showBalloon,
    this.description,
    this.launchParams,
  }) {
    _validateZoom(zoom);
  }

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Map zoom.
  final int zoom;

  /// Whether to show the point balloon.
  final bool showBalloon;

  /// Optional point description.
  final String? description;

  /// Optional Yandex launch identification parameters.
  final YandexNavigatorLaunchParams? launchParams;

  Map<String, String> get _queryParameters => {
        'lat': coordinate.latitude.toString(),
        'lon': coordinate.longitude.toString(),
        'zoom': zoom.toString(),
        'no-balloon': showBalloon ? '0' : '1',
        if (description != null) 'desc': description!,
        ...?launchParams?._queryParameters,
      };

  @override
  Uri get appLink => _navigatorUri('show_point_on_map', _queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri({
        showBalloon ? 'pt' : 'll': _lngLat(coordinate),
        'z': zoom.toString(),
        'l': 'map',
      });
}

/// Searches Yandex Navigator for a text query.
class YandexNavigatorSearchAction extends YandexNavigator
    implements IntentAppLinkAction, Fallbackable, MapSearchAction {
  /// Creates a Yandex Navigator search action.
  YandexNavigatorSearchAction({
    required this.query,
    required super.fallbackToStore,
    this.launchParams,
  });

  /// Search query.
  @override
  final String query;

  /// Optional Yandex launch identification parameters.
  final YandexNavigatorLaunchParams? launchParams;

  Map<String, String> get _queryParameters => {
        'text': query,
        ...?launchParams?._queryParameters,
      };

  @override
  Uri get appLink => _navigatorUri('map_search', _queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri({
        'text': query,
        'l': 'map',
      });
}

/// Builds a coordinate route in Yandex Navigator.
class YandexNavigatorDirectionsWithCoordsAction extends YandexNavigator
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a Yandex Navigator coordinate directions action.
  YandexNavigatorDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.waypoints = const [],
    this.launchParams,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional via points.
  final List<YandexNavigatorWaypoint> waypoints;

  /// Optional Yandex launch identification parameters.
  final YandexNavigatorLaunchParams? launchParams;

  Map<String, String> get _queryParameters => {
        'lat_to': destination.latitude.toString(),
        'lon_to': destination.longitude.toString(),
        if (origin != null) 'lat_from': origin!.latitude.toString(),
        if (origin != null) 'lon_from': origin!.longitude.toString(),
        for (var i = 0; i < waypoints.length; i++) ...{
          'lat_via_$i': waypoints[i].coordinate.latitude.toString(),
          'lon_via_$i': waypoints[i].coordinate.longitude.toString(),
        },
        ...?launchParams?._queryParameters,
      };

  @override
  Uri get appLink => _navigatorUri('build_route_on_map', _queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _webMapUri({
        'rtext': [
          if (origin != null) origin.toString() else '',
          for (final waypoint in waypoints) waypoint.coordinate.toString(),
          destination.toString(),
        ].join('~'),
        'rtt': 'auto',
      });
}

Uri _navigatorUri(final String path, final Map<String, String> queryParameters) => Uri(
      scheme: 'yandexnavi',
      host: path,
      queryParameters: queryParameters,
    );

String _lngLat(final Coordinate coordinate) => '${coordinate.longitude},${coordinate.latitude}';

Uri _webMapUri(final Map<String, String> queryParameters) => Uri(
      scheme: 'https',
      host: 'yandex.com',
      path: 'maps/',
      queryParameters: queryParameters,
    );

AndroidIntentOption _androidIntentOptions(final IntentAppLinkAction action) => AndroidIntentOption(
      action: 'action_view',
      data: action.appLink.toString(),
      package: 'ru.yandex.yandexnavi',
      flags: const [0x10000000],
    );

void _validateZoom(final int zoom) {
  if (zoom < 1 || zoom > 18) {
    throw ArgumentError.value(
      zoom,
      'zoom',
      'must be between 1 and 18 for Yandex Navigator URLs',
    );
  }
}

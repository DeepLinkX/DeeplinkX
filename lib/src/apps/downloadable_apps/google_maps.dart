import 'package:deeplink_x/src/src.dart';

/// Google Maps application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the Google Maps app on various platforms.
class GoogleMaps extends App implements DownloadableApp {
  /// Creates a new [GoogleMaps] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed. Default is false.
  GoogleMaps({this.fallbackToStore = false});

  /// Creates an action to open the Google Maps app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed. Default is false.
  ///
  /// Returns a [GoogleMaps] instance that can be used to open the Google Maps app.
  factory GoogleMaps.open({final bool fallbackToStore = false}) => GoogleMaps(fallbackToStore: fallbackToStore);

  /// A list of actions to open the Google Maps app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.google.android.apps.maps'),
        IOSAppStore.openAppPage(appId: '585027354', appName: 'google-maps'),
      ];

  /// The Android package name for the Google Maps app.
  @override
  String get androidPackageName => 'com.google.android.apps.maps';

  /// The custom URL scheme for the Google Maps app.
  @override
  String get customScheme => 'comgooglemaps';

  /// The MacOS bundle identifier for the Google Maps app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the Google Maps app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to automatically redirect to app stores when the Google Maps app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for Google Maps.
  @override
  Uri get website => Uri.parse('https://maps.google.com');

  /// Creates an action to display a map centered on [coordinate].
  ///
  /// Parameters:
  /// - [coordinate]: The latitude and longitude to center the map on.
  /// - [zoom]: Optional zoom level between 0 and 21.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed. Default is false.
  ///
  /// Returns a [GoogleMapsViewAction] instance that can be used to display
  /// a map at the specified coordinates in the Google Maps app.
  static GoogleMapsViewAction view({
    required final Coordinate coordinate,
    final double? zoom,
    final bool fallbackToStore = false,
  }) =>
      GoogleMapsViewAction(
        coordinate: coordinate,
        zoom: zoom,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to search for a location in the Google Maps app.
  ///
  /// Parameters:
  /// - [query]: The search query or coordinates to use.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed. Default is false.
  ///
  /// Returns a [GoogleMapsSearchAction] instance that can be used to search
  /// for a location in the Google Maps app.
  static GoogleMapsSearchAction search({
    required final String query,
    final bool fallbackToStore = false,
  }) =>
      GoogleMapsSearchAction(
        query: query,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to get directions to [destination].
  ///
  /// Parameters:
  /// - [destination]: The destination address or coordinates.
  /// - [origin]: Optional starting point address or coordinates.
  /// - [mode]: Optional [GoogleMapsTravelMode] for the route.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed. Default is false.
  ///
  /// Returns a [GoogleMapsDirectionsAction] instance that can be used to
  /// display directions in the Google Maps app.
  static GoogleMapsDirectionsAction directions({
    required final String destination,
    final String? origin,
    final GoogleMapsTravelMode? mode,
    final bool fallbackToStore = false,
  }) =>
      GoogleMapsDirectionsAction(
        destination: destination,
        origin: origin,
        mode: mode,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to get directions using coordinates.
  ///
  /// Parameters:
  /// - [destination]: The destination coordinates.
  /// - [origin]: Optional starting point coordinates.
  /// - [mode]: Optional [GoogleMapsTravelMode] for the route.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed. Default is false.
  ///
  /// Returns a [GoogleMapsDirectionsWithCoordsAction] instance that can be used
  /// to display directions in the Google Maps app.
  static GoogleMapsDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final GoogleMapsTravelMode? mode,
    final bool fallbackToStore = false,
  }) =>
      GoogleMapsDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        mode: mode,
        fallbackToStore: fallbackToStore,
      );
}

/// Travel modes supported by Google Maps directions.
enum GoogleMapsTravelMode {
  /// Driving route.
  driving,

  /// Walking route.
  walking,

  /// Bicycling route.
  bicycling,

  /// Public transit route.
  transit,
}

/// An action to search for a location in the Google Maps app.
///
/// This class extends [GoogleMaps] and implements multiple interfaces to provide
/// comprehensive functionality for searching with fallback support.
class GoogleMapsSearchAction extends GoogleMaps implements IntentAppLinkAction, AppLinkAppAction, Fallbackable {
  /// Creates a new [GoogleMapsSearchAction] instance.
  ///
  /// Parameters:
  /// - [query]: The search query or coordinates to use.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed.
  GoogleMapsSearchAction({
    required this.query,
    required super.fallbackToStore,
  });

  /// The search query.
  final String query;

  @override
  Uri get appLink => Uri(
        scheme: 'comgooglemaps',
        queryParameters: {'q': query},
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: Uri(
          scheme: 'geo',
          host: '0,0',
          queryParameters: {'q': query},
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.google.com',
        queryParameters: {'q': query},
      );
}

/// An action to display a map centered on specific coordinates.
class GoogleMapsViewAction extends GoogleMaps implements IntentAppLinkAction, AppLinkAppAction, Fallbackable {
  /// Creates a new [GoogleMapsViewAction] instance.
  GoogleMapsViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    this.zoom,
  });

  /// Coordinate to center the map on.
  final Coordinate coordinate;

  /// Optional zoom level.
  final double? zoom;

  @override
  Uri get appLink => Uri(
        scheme: 'comgooglemaps',
        queryParameters: {
          'center': coordinate.toString(),
          if (zoom != null) 'zoom': zoom!.toString(),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: Uri(
          scheme: 'geo',
          path: '${coordinate.latitude},${coordinate.longitude}',
          queryParameters: {if (zoom != null) 'z': zoom!.toString()},
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.google.com',
        queryParameters: {
          'q': coordinate.toString(),
          if (zoom != null) 'z': zoom!.toString(),
        },
      );
}

/// An action to get directions using addresses or place IDs.
class GoogleMapsDirectionsAction extends GoogleMaps implements IntentAppLinkAction, AppLinkAppAction, Fallbackable {
  /// Creates a new [GoogleMapsDirectionsAction] instance.
  GoogleMapsDirectionsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.mode,
  });

  /// Destination address or coordinates.
  final String destination;

  /// Optional origin address or coordinates.
  final String? origin;

  /// Optional travel mode.
  final GoogleMapsTravelMode? mode;

  @override
  Uri get appLink => Uri(
        scheme: 'comgooglemaps',
        queryParameters: {
          'daddr': destination,
          if (origin != null) 'saddr': origin,
          if (mode != null) 'directionsmode': _iosMode(mode!),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: Uri(
          scheme: 'https',
          host: 'www.google.com',
          path: 'maps/dir/',
          queryParameters: {
            'api': '1',
            'destination': destination,
            if (origin != null) 'origin': origin,
            if (mode != null) 'travelmode': _iosMode(mode!),
          },
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.google.com',
        queryParameters: {
          'saddr': origin,
          'daddr': destination,
          if (mode != null) 'directionsmode': _iosMode(mode!),
        }..removeWhere((final _, final v) => v == null),
      );
}

/// An action to get directions using coordinates.
class GoogleMapsDirectionsWithCoordsAction extends GoogleMaps
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable {
  /// Creates a new [GoogleMapsDirectionsWithCoordsAction] instance.
  GoogleMapsDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.mode,
  });

  /// Destination coordinates.
  final Coordinate destination;

  /// Optional origin coordinates.
  final Coordinate? origin;

  /// Optional travel mode.
  final GoogleMapsTravelMode? mode;

  @override
  Uri get appLink => Uri(
        scheme: 'comgooglemaps',
        queryParameters: {
          'daddr': destination.toString(),
          if (origin != null) 'saddr': origin.toString(),
          if (mode != null) 'directionsmode': _iosMode(mode!),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: Uri(
          scheme: 'https',
          host: 'www.google.com',
          path: 'maps/dir/',
          queryParameters: {
            'api': '1',
            'destination': destination.toString(),
            if (origin != null) 'origin': origin.toString(),
            if (mode != null) 'travelmode': _iosMode(mode!),
          },
        ).toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.google.com',
        queryParameters: {
          'saddr': origin?.toString(),
          'daddr': destination.toString(),
          if (mode != null) 'directionsmode': _iosMode(mode!),
        }..removeWhere((final _, final v) => v == null),
      );
}

String _iosMode(final GoogleMapsTravelMode mode) {
  switch (mode) {
    case GoogleMapsTravelMode.driving:
      return 'driving';
    case GoogleMapsTravelMode.walking:
      return 'walking';
    case GoogleMapsTravelMode.bicycling:
      return 'bicycling';
    case GoogleMapsTravelMode.transit:
      return 'transit';
  }
}

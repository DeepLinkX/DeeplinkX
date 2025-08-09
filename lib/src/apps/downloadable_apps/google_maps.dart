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

  /// Creates an action to display a map centered on [latitude] and [longitude].
  ///
  /// Parameters:
  /// - [latitude]: The latitude coordinate.
  /// - [longitude]: The longitude coordinate.
  /// - [zoom]: Optional zoom level between 0 and 21.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed. Default is false.
  ///
  /// Returns a [GoogleMapsViewAction] instance that can be used to display
  /// a map at the specified coordinates in the Google Maps app.
  static GoogleMapsViewAction view({
    required final double latitude,
    required final double longitude,
    final double? zoom,
    final bool fallbackToStore = false,
  }) =>
      GoogleMapsViewAction(
        latitude: latitude,
        longitude: longitude,
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

  /// Creates an action to display Street View imagery.
  ///
  /// Parameters:
  /// - [latitude]: The latitude coordinate.
  /// - [longitude]: The longitude coordinate.
  /// - [heading]: Optional heading in degrees from 0 to 360.
  /// - [pitch]: Optional pitch in degrees from -90 to 90.
  /// - [fov]: Optional field of view. 1 corresponds roughly to zoom level.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Google Maps app is not installed. Default is false.
  ///
  /// Returns a [GoogleMapsStreetViewAction] instance.
  static GoogleMapsStreetViewAction streetView({
    required final double latitude,
    required final double longitude,
    final double? heading,
    final double? pitch,
    final double? fov,
    final bool fallbackToStore = false,
  }) =>
      GoogleMapsStreetViewAction(
        latitude: latitude,
        longitude: longitude,
        heading: heading,
        pitch: pitch,
        fov: fov,
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

  /// The search query or coordinates.
  final String query;

  /// The app link URL for searching in the Google Maps app on iOS.
  @override
  Uri get appLink => Uri(
        scheme: 'comgooglemaps',
        queryParameters: {'q': query},
      );

  /// Android intent options for launching the search action on Android devices.
  @override
  AndroidIntentOption get androidIntentOptions {
    final dataUri = Uri(
      scheme: 'geo',
      host: '0,0',
      queryParameters: {'q': query},
    );
    return AndroidIntentOption(
      action: 'action_view',
      data: dataUri.toString(),
      package: androidPackageName,
      flags: const [0x10000000], // Intent.FLAG_ACTIVITY_NEW_TASK
    );
  }

  /// The fallback link to use when the Google Maps app cannot be opened.
  ///
  /// This URL opens the search results on the Google Maps website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.google.com',
        queryParameters: {'q': query},
      );
}

/// An action to display a map at specific coordinates in the Google Maps app.
class GoogleMapsViewAction extends GoogleMaps implements IntentAppLinkAction, AppLinkAppAction, Fallbackable {
  /// Creates a new [GoogleMapsViewAction] instance.
  GoogleMapsViewAction({
    required this.latitude,
    required this.longitude,
    required super.fallbackToStore,
    this.zoom,
  });

  /// The latitude coordinate.
  final double latitude;

  /// The longitude coordinate.
  final double longitude;

  /// Optional zoom level between 0 and 21.
  final double? zoom;

  @override
  Uri get appLink => Uri(
        scheme: 'comgooglemaps',
        queryParameters: {
          'center': '$latitude,$longitude',
          if (zoom != null) 'zoom': zoom!.toString(),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions {
    final dataUri = Uri(
      scheme: 'geo',
      path: '$latitude,$longitude',
      queryParameters: {
        if (zoom != null) 'z': zoom!.toString(),
      },
    );
    return AndroidIntentOption(
      action: 'action_view',
      data: dataUri.toString(),
      package: androidPackageName,
      flags: const [0x10000000],
    );
  }

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.google.com',
        queryParameters: {
          'q': '$latitude,$longitude',
          if (zoom != null) 'z': zoom!.toString(),
        },
      );
}

/// An action to display directions in the Google Maps app.
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
  AndroidIntentOption get androidIntentOptions {
    final dataUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: 'maps/dir/',
      queryParameters: {
        'api': '1',
        'destination': destination,
        if (origin != null) 'origin': origin,
        if (mode != null) 'travelmode': _iosMode(mode!),
      },
    );
    return AndroidIntentOption(
      action: 'action_view',
      data: dataUri.toString(),
      package: androidPackageName,
      flags: const [0x10000000],
    );
  }

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.google.com',
        path: '',
        queryParameters: {
          'saddr': origin,
          'daddr': destination,
          if (mode != null) 'directionsmode': _iosMode(mode!),
        }..removeWhere((final _, final v) => v == null),
      );
}

/// An action to display Street View imagery in the Google Maps app.
class GoogleMapsStreetViewAction extends GoogleMaps implements IntentAppLinkAction, AppLinkAppAction, Fallbackable {
  /// Creates a new [GoogleMapsStreetViewAction] instance.
  GoogleMapsStreetViewAction({
    required this.latitude,
    required this.longitude,
    required super.fallbackToStore,
    this.heading,
    this.pitch,
    this.fov,
  });

  /// Latitude coordinate.
  final double latitude;

  /// Longitude coordinate.
  final double longitude;

  /// Optional heading in degrees from 0 to 360.
  final double? heading;

  /// Optional pitch in degrees from -90 to 90.
  final double? pitch;

  /// Optional field of view/zoom level.
  final double? fov;

  @override
  Uri get appLink => Uri(
        scheme: 'comgooglemaps',
        queryParameters: {
          'mapmode': 'streetview',
          'center': '$latitude,$longitude',
          if (heading != null) 'heading': heading!.toString(),
          if (pitch != null) 'pitch': pitch!.toString(),
          if (fov != null) 'fov': fov!.toString(),
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions {
    final dataUri = Uri(
      scheme: 'google.streetview',
      queryParameters: {
        'cbll': '$latitude,$longitude',
        if (heading != null || pitch != null || fov != null) 'cbp': '1,${heading ?? 0},,${pitch ?? 0},${fov ?? 1}',
      },
    );
    return AndroidIntentOption(
      action: 'action_view',
      data: dataUri.toString(),
      package: androidPackageName,
      flags: const [0x10000000],
    );
  }

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'maps.google.com',
        queryParameters: {
          'cbll': '$latitude,$longitude',
        },
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

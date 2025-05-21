import 'package:deeplink_x/src/src.dart';

/// Pinterest application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the Pinterest app on various platforms.
class Pinterest extends App implements DownloadableApp {
  /// Creates a new [Pinterest] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed. Default is false.
  Pinterest({this.fallbackToStore = false});

  /// Creates an action to open the Pinterest app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed. Default is false.
  ///
  /// Returns a [Pinterest] instance that can be used to open the Pinterest app.
  factory Pinterest.open({final bool fallbackToStore = false}) => Pinterest(fallbackToStore: fallbackToStore);

  /// A list of actions to open the Pinterest app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.pinterest'),
        IOSAppStore.openAppPage(appId: '429047995', appName: 'pinterest'),
      ];

  /// The Android package name for the Pinterest app.
  @override
  String get androidPackageName => 'com.pinterest';

  /// The custom URL scheme for the Pinterest app.
  @override
  String get customScheme => 'pinterest';

  /// The MacOS bundle identifier for the Pinterest app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the Pinterest app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to automatically redirect to app stores when the Pinterest app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for Pinterest.
  @override
  Uri get website => Uri.parse('https://www.pinterest.com');

  /// Creates an action to open a specific profile in the Pinterest app.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed.
  ///
  /// Returns a [PinterestOpenProfileAction] instance that can be used to open
  /// the specified profile in the Pinterest app.
  static PinterestOpenProfileAction openProfile({
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      PinterestOpenProfileAction(username: username, fallbackToStore: fallbackToStore);

  /// Creates an action to open a specific pin in the Pinterest app.
  ///
  /// Parameters:
  /// - [pinId]: The ID of the pin to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed.
  ///
  /// Returns a [PinterestOpenPinAction] instance that can be used to open
  /// the specified pin in the Pinterest app.
  static PinterestOpenPinAction openPin({
    required final String pinId,
    final bool fallbackToStore = false,
  }) =>
      PinterestOpenPinAction(pinId: pinId, fallbackToStore: fallbackToStore);

  /// Creates an action to open the Pinterest search in the Pinterest app.
  ///
  /// Parameters:
  /// - [query]: The search query to use.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed.
  ///
  /// Returns a [PinterestSearchAction] instance that can be used to open
  /// the search results in the Pinterest app.
  static PinterestSearchAction search({
    required final String query,
    final bool fallbackToStore = false,
  }) =>
      PinterestSearchAction(query: query, fallbackToStore: fallbackToStore);

  /// Creates an action to open a specific board in the Pinterest app.
  ///
  /// Parameters:
  /// - [username]: The username of the board owner.
  /// - [board]: The slug of the board (lower-case, hyphenated).
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed.
  ///
  /// Returns a [PinterestOpenBoardAction] instance that can be used to open
  /// the specified board in the Pinterest app.
  static PinterestOpenBoardAction openBoard({
    required final String username,
    required final String board,
    final bool fallbackToStore = false,
  }) =>
      PinterestOpenBoardAction(username: username, board: board, fallbackToStore: fallbackToStore);
}

/// An action to open a specific profile in the Pinterest app.
///
/// This class extends [Pinterest] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class PinterestOpenProfileAction extends Pinterest implements AppLinkAppAction, Fallbackable {
  /// Creates a new [PinterestOpenProfileAction] instance.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed.
  PinterestOpenProfileAction({
    required this.username,
    required super.fallbackToStore,
  });

  /// The username of the profile to open.
  final String username;

  /// The app link URL for opening the specified profile in the Pinterest app.
  @override
  Uri get appLink => Uri(
        scheme: 'pinterest',
        host: 'user',
        path: username,
      );

  /// The fallback link to use when the Pinterest app cannot be opened.
  ///
  /// This URL opens the specified profile on the Pinterest website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.pinterest.com',
        path: username,
      );
}

/// An action to open a specific pin in the Pinterest app.
///
/// This class extends [Pinterest] and implements multiple interfaces to provide
/// comprehensive functionality for opening pins with fallback support.
class PinterestOpenPinAction extends Pinterest implements AppLinkAppAction, Fallbackable {
  /// Creates a new [PinterestOpenPinAction] instance.
  ///
  /// Parameters:
  /// - [pinId]: The ID of the pin to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed.
  PinterestOpenPinAction({
    required this.pinId,
    required super.fallbackToStore,
  });

  /// The ID of the pin to open.
  final String pinId;

  /// The app link URL for opening the specified pin in the Pinterest app.
  @override
  Uri get appLink => Uri(
        scheme: 'pinterest',
        host: 'pin',
        path: pinId,
      );

  /// The fallback link to use when the Pinterest app cannot be opened.
  ///
  /// This URL opens the specified pin on the Pinterest website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.pinterest.com',
        pathSegments: ['pin', pinId],
      );
}

/// An action to open the Pinterest search in the Pinterest app.
///
/// This class extends [Pinterest] and implements multiple interfaces to provide
/// comprehensive functionality for searching with fallback support.
class PinterestSearchAction extends Pinterest implements AppLinkAppAction, Fallbackable {
  /// Creates a new [PinterestSearchAction] instance.
  ///
  /// Parameters:
  /// - [query]: The search query to use.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed.
  PinterestSearchAction({
    required this.query,
    required super.fallbackToStore,
  });

  /// The search query to use.
  final String query;

  /// The app link URL for opening the search in the Pinterest app.
  @override
  Uri get appLink => Uri(
        scheme: 'pinterest',
        host: 'search',
        path: 'pins',
        query: 'q=$query',
      );

  /// The fallback link to use when the Pinterest app cannot be opened.
  ///
  /// This URL opens the search results on the Pinterest website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.pinterest.com',
        pathSegments: ['search', 'pins'],
        queryParameters: {'q': query},
      );
}

/// An action to open a specific board in the Pinterest app.
///
/// This class extends [Pinterest] and implements multiple interfaces to provide
/// comprehensive functionality for opening boards with fallback support.
class PinterestOpenBoardAction extends Pinterest implements AppLinkAppAction, Fallbackable {
  /// Creates a new [PinterestOpenBoardAction] instance.
  ///
  /// Parameters:
  /// - [username]: The username of the board owner.
  /// - [board]: The slug of the board (lower-case, hyphenated).
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Pinterest app is not installed.
  PinterestOpenBoardAction({
    required this.username,
    required this.board,
    required super.fallbackToStore,
  });

  /// The username of the board owner.
  final String username;

  /// The board (lower-case, hyphenated).
  final String board;

  /// The app link URL for opening the specified board in the Pinterest app.
  @override
  Uri get appLink => Uri(
        scheme: 'pinterest',
        host: 'board',
        pathSegments: [username, board],
      );

  /// The fallback link to use when the Pinterest app cannot be opened.
  ///
  /// This URL opens the specified board on the Pinterest website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.pinterest.com',
        pathSegments: [username, board],
      );
}

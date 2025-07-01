import 'package:deeplink_x/src/src.dart';

/// Twitter application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the Twitter app on various platforms.
class Twitter extends App implements DownloadableApp {
  /// Creates a new [Twitter] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Twitter app is not installed. Default is false.
  Twitter({this.fallbackToStore = false});

  /// Creates an action to open the Twitter app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Twitter app is not installed. Default is false.
  ///
  /// Returns a [Twitter] instance that can be used to open the Twitter app.
  factory Twitter.open({final bool fallbackToStore = false}) => Twitter(fallbackToStore: fallbackToStore);

  /// A list of actions to open the Twitter app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.twitter.android'),
        IOSAppStore.openAppPage(appId: '333903271', appName: 'twitter'),
      ];

  /// The Android package name for the Twitter app.
  @override
  String get androidPackageName => 'com.twitter.android';

  /// The custom URL scheme for the Twitter app.
  @override
  String get customScheme => 'twitter';

  /// The MacOS bundle identifier for the Twitter app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the Twitter app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to automatically redirect to app stores when the Twitter app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for Twitter.
  @override
  Uri get website => Uri.parse('https://twitter.com');

  /// Creates an action to open a specific profile in the Twitter app.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Twitter app is not installed.
  ///
  /// Returns a [TwitterOpenProfileAction] instance that can be used to open
  /// the specified profile in the Twitter app.
  static TwitterOpenProfileAction openProfile({
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      TwitterOpenProfileAction(
        username: username,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific tweet in the Twitter app.
  ///
  /// Parameters:
  /// - [tweetId]: The ID of the tweet to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Twitter app is not installed.
  ///
  /// Returns a [TwitterOpenTweetAction] instance that can be used to open
  /// the specified tweet in the Twitter app.
  static TwitterOpenTweetAction openTweet({
    required final String tweetId,
    final bool fallbackToStore = false,
  }) =>
      TwitterOpenTweetAction(
        tweetId: tweetId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open the Twitter search in the Twitter app.
  ///
  /// Parameters:
  /// - [query]: The search query to use.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Twitter app is not installed.
  ///
  /// Returns a [TwitterSearchAction] instance that can be used to open
  /// the search results in the Twitter app.
  static TwitterSearchAction search({
    required final String query,
    final bool fallbackToStore = false,
  }) =>
      TwitterSearchAction(query: query, fallbackToStore: fallbackToStore);
}

/// An action to open a specific profile in the Twitter app.
///
/// This class extends [Twitter] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class TwitterOpenProfileAction extends Twitter implements AppLinkAppAction, Fallbackable {
  /// Creates a new [TwitterOpenProfileAction] instance.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Twitter app is not installed.
  TwitterOpenProfileAction({
    required this.username,
    required super.fallbackToStore,
  });

  /// The username of the profile to open.
  final String username;

  /// The app link URL for opening the specified profile in the Twitter app.
  @override
  Uri get appLink => Uri(
        scheme: 'twitter',
        host: 'user',
        queryParameters: {'screen_name': username},
      );

  /// The fallback link to use when the Twitter app cannot be opened.
  ///
  /// This URL opens the specified profile on the Twitter website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'twitter.com',
        path: username,
      );
}

/// An action to open a specific tweet in the Twitter app.
///
/// This class extends [Twitter] and implements multiple interfaces to provide
/// comprehensive functionality for opening tweets with fallback support.
class TwitterOpenTweetAction extends Twitter implements AppLinkAppAction, Fallbackable {
  /// Creates a new [TwitterOpenTweetAction] instance.
  ///
  /// Parameters:
  /// - [tweetId]: The ID of the tweet to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Twitter app is not installed.
  TwitterOpenTweetAction({
    required this.tweetId,
    required super.fallbackToStore,
  });

  /// The ID of the tweet to open.
  final String tweetId;

  /// The app link URL for opening the specified tweet in the Twitter app.
  @override
  Uri get appLink => Uri(
        scheme: 'twitter',
        host: 'status',
        queryParameters: {'id': tweetId},
      );

  /// The fallback link to use when the Twitter app cannot be opened.
  ///
  /// This URL opens the specified tweet on the Twitter website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'twitter.com',
        pathSegments: ['i', 'status', tweetId],
      );
}

/// An action to open the Twitter search in the Twitter app.
///
/// This class extends [Twitter] and implements multiple interfaces to provide
/// comprehensive functionality for searching with fallback support.
class TwitterSearchAction extends Twitter implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [TwitterSearchAction] instance.
  ///
  /// Parameters:
  /// - [query]: The search query to use.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Twitter app is not installed.
  TwitterSearchAction({
    required this.query,
    required super.fallbackToStore,
  });

  /// The search query to use.
  final String query;

  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'twitter.com',
        path: 'search',
        queryParameters: {'q': query},
      );

  /// The fallback link to use when the Twitter app cannot be opened.
  ///
  /// This URL opens the search results on the Twitter website.
  @override
  Uri get fallbackLink => universalLink;
}

import 'package:deeplink_x/src/src.dart';

/// TikTok application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the TikTok app on various platforms.
class TikTok extends App implements DownloadableApp {
  /// Creates a new [TikTok] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the TikTok app is not installed. Default is false.
  TikTok({this.fallbackToStore = false});

  /// Creates an action to open the TikTok app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the TikTok app is not installed. Default is false.
  ///
  /// Returns a [TikTok] instance that can be used to open the TikTok app.
  factory TikTok.open({final bool fallbackToStore = false}) => TikTok(fallbackToStore: fallbackToStore);

  /// A list of actions to open the TikTok app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.zhiliaoapp.musically'),
        IOSAppStore.openAppPage(appId: '835599320', appName: 'tiktok'),
      ];

  /// The Android package name for the TikTok app.
  @override
  String get androidPackageName => 'com.zhiliaoapp.musically';

  /// The custom URL scheme for the TikTok app.
  @override
  String get customScheme => 'tiktok';

  /// The MacOS bundle identifier for the TikTok app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the TikTok app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to automatically redirect to app stores when the TikTok app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for TikTok.
  @override
  Uri get website => Uri.parse('https://www.tiktok.com');

  /// Creates an action to open a specific profile in the TikTok app.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the TikTok app is not installed.
  ///
  /// Returns a [TikTokOpenProfileAction] instance that can be used to open
  /// the specified profile in the TikTok app.
  static TikTokOpenProfileAction openProfile({
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      TikTokOpenProfileAction(
        username: username,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific video in the TikTok app.
  ///
  /// Parameters:
  /// - [videoId]: The ID of the video to open.
  /// - [username]: The username of the video to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the TikTok app is not installed.
  ///
  /// Returns a [TikTokOpenVideoAction] instance that can be used to open
  /// the specified video in the TikTok app.
  static TikTokOpenVideoAction openVideo({
    required final String videoId,
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      TikTokOpenVideoAction(
        videoId: videoId,
        userName: username,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific tag in the TikTok app.
  ///
  /// Parameters:
  /// - [tagName]: The name of the tag to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the TikTok app is not installed.
  ///
  /// Returns a [TikTokOpenTagAction] instance that can be used to open
  /// the specified tag in the TikTok app.
  static TikTokOpenTagAction openTag({
    required final String tagName,
    final bool fallbackToStore = false,
  }) =>
      TikTokOpenTagAction(tagName: tagName, fallbackToStore: fallbackToStore);
}

/// An action to open a specific profile in the TikTok app.
///
/// This class extends [TikTok] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class TikTokOpenProfileAction extends TikTok implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [TikTokOpenProfileAction] instance.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the TikTok app is not installed.
  TikTokOpenProfileAction({
    required this.username,
    required super.fallbackToStore,
  });

  /// The username of the profile to open.
  final String username;

  /// The universal link URL for opening the specified profile in the TikTok app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.tiktok.com',
        path: '@$username',
      );

  /// The fallback link to use when the TikTok app cannot be opened.
  ///
  /// This URL opens the specified profile on the TikTok website.
  @override
  Uri get fallbackLink => universalLink;
}

/// An action to open a specific video in the TikTok app.
///
/// This class extends [TikTok] and implements multiple interfaces to provide
/// comprehensive functionality for opening videos with fallback support.
class TikTokOpenVideoAction extends TikTok implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [TikTokOpenVideoAction] instance.
  ///
  /// Parameters:
  /// - [videoId]: The ID of the video to open.
  /// - [userName]: The username of the video to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the TikTok app is not installed.
  TikTokOpenVideoAction({
    required this.videoId,
    required this.userName,
    required super.fallbackToStore,
  });

  /// The ID of the video to open.
  final String videoId;

  /// The username of the video to open.
  final String userName;

  /// The universal link URL for opening the specified video in the TikTok app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.tiktok.com',
        pathSegments: ['@$userName', 'video', videoId],
      );

  /// The fallback link to use when the TikTok app cannot be opened.
  ///
  /// This URL opens the specified video on the TikTok website.
  @override
  Uri get fallbackLink => universalLink;
}

/// An action to open a specific tag in the TikTok app.
///
/// This class extends [TikTok] and implements multiple interfaces to provide
/// comprehensive functionality for opening tags with fallback support.
class TikTokOpenTagAction extends TikTok implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [TikTokOpenTagAction] instance.
  ///
  /// Parameters:
  /// - [tagName]: The name of the tag to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the TikTok app is not installed.
  TikTokOpenTagAction({
    required this.tagName,
    required super.fallbackToStore,
  });

  /// The name of the tag to open.
  final String tagName;

  /// The universal link URL for opening the specified tag in the TikTok app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.tiktok.com',
        pathSegments: ['tag', tagName],
      );

  /// The fallback link to use when the TikTok app cannot be opened.
  ///
  /// This URL opens the specified tag on the TikTok website.
  @override
  Uri get fallbackLink => universalLink;
}

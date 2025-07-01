import 'package:deeplink_x/src/src.dart';

/// YouTube application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the YouTube app on various platforms.
class YouTube extends App implements DownloadableApp {
  /// Creates a new [YouTube] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed. Default is false.
  YouTube({this.fallbackToStore = false});

  /// Creates an action to open the YouTube app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed. Default is false.
  ///
  /// Returns a [YouTube] instance that can be used to open the YouTube app.
  factory YouTube.open({final bool fallbackToStore = false}) => YouTube(fallbackToStore: fallbackToStore);

  /// A list of actions to open the YouTube app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.google.android.youtube'),
        IOSAppStore.openAppPage(appId: '544007664', appName: 'youtube'),
        MicrosoftStore.openAppPage(productId: '9wzdncrfj2wl'),
      ];

  /// The Android package name for the YouTube app.
  @override
  String get androidPackageName => 'com.google.android.youtube';

  /// The custom URL scheme for the YouTube app.
  @override
  String get customScheme => 'youtube';

  /// The MacOS bundle identifier for the YouTube app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the YouTube app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android, PlatformType.windows];

  /// Whether to automatically redirect to app stores when the YouTube app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for YouTube.
  @override
  Uri get website => Uri.parse('https://www.youtube.com');

  /// Creates an action to open a specific video in the YouTube app.
  ///
  /// Parameters:
  /// - [videoId]: The ID of the video to open (e.g. 'dQw4w9WgXcQ').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed. Default is false.
  ///
  /// Returns a [YouTubeOpenVideoAction] instance that can be used to open
  /// the specified video in the YouTube app.
  static YouTubeOpenVideoAction openVideo({
    required final String videoId,
    final bool fallbackToStore = false,
  }) =>
      YouTubeOpenVideoAction(
        videoId: videoId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific channel in the YouTube app.
  ///
  /// Parameters:
  /// - [channelId]: The ID of the channel to open (e.g. 'UCq-Fj5jknLsUf-MWSy4_brA').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed. Default is false.
  ///
  /// Returns a [YouTubeOpenChannelAction] instance that can be used to open
  /// the specified channel in the YouTube app.
  static YouTubeOpenChannelAction openChannel({
    required final String channelId,
    final bool fallbackToStore = false,
  }) =>
      YouTubeOpenChannelAction(
        channelId: channelId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific playlist in the YouTube app.
  ///
  /// Parameters:
  /// - [playlistId]: The ID of the playlist to open (e.g. 'PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed. Default is false.
  ///
  /// Returns a [YouTubeOpenPlaylistAction] instance that can be used to open
  /// the specified playlist in the YouTube app.
  static YouTubeOpenPlaylistAction openPlaylist({
    required final String playlistId,
    final bool fallbackToStore = false,
  }) =>
      YouTubeOpenPlaylistAction(
        playlistId: playlistId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to search for content in the YouTube app.
  ///
  /// Parameters:
  /// - [query]: The search query (e.g. 'flutter tutorial').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed. Default is false.
  ///
  /// Returns a [YouTubeSearchAction] instance that can be used to search
  /// for content in the YouTube app.
  static YouTubeSearchAction search({
    required final String query,
    final bool fallbackToStore = false,
  }) =>
      YouTubeSearchAction(
        query: query,
        fallbackToStore: fallbackToStore,
      );
}

/// An action to open a specific video in the YouTube app.
///
/// This class extends [YouTube] and implements multiple interfaces to provide
/// comprehensive functionality for opening videos with fallback support.
class YouTubeOpenVideoAction extends YouTube implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [YouTubeOpenVideoAction] instance.
  ///
  /// Parameters:
  /// - [videoId]: The ID of the video to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed.
  YouTubeOpenVideoAction({
    required this.videoId,
    required super.fallbackToStore,
  });

  /// The ID of the video to open.
  final String videoId;

  /// The universal link URL for opening the specified video in the YouTube app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.youtube.com',
        path: 'watch',
        queryParameters: {'v': videoId},
      );

  /// The fallback URL for opening the specified video in a web browser.
  @override
  Uri get fallbackLink => universalLink;
}

/// An action to open a specific channel in the YouTube app.
///
/// This class extends [YouTube] and implements multiple interfaces to provide
/// comprehensive functionality for opening channels with fallback support.
class YouTubeOpenChannelAction extends YouTube implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [YouTubeOpenChannelAction] instance.
  ///
  /// Parameters:
  /// - [channelId]: The ID of the channel to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed.
  YouTubeOpenChannelAction({
    required this.channelId,
    required super.fallbackToStore,
  });

  /// The ID of the channel to open.
  final String channelId;

  /// The universal link URL for opening the specified channel in the YouTube app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.youtube.com',
        pathSegments: ['channel', channelId],
      );

  /// The fallback URL for opening the specified channel in a web browser.
  @override
  Uri get fallbackLink => universalLink;
}

/// An action to open a specific playlist in the YouTube app.
///
/// This class extends [YouTube] and implements multiple interfaces to provide
/// comprehensive functionality for opening playlists with fallback support.
class YouTubeOpenPlaylistAction extends YouTube implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [YouTubeOpenPlaylistAction] instance.
  ///
  /// Parameters:
  /// - [playlistId]: The ID of the playlist to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed.
  YouTubeOpenPlaylistAction({
    required this.playlistId,
    required super.fallbackToStore,
  });

  /// The ID of the playlist to open.
  final String playlistId;

  /// The universal link URL for opening the specified playlist in the YouTube app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.youtube.com',
        path: 'playlist',
        queryParameters: {'list': playlistId},
      );

  /// The fallback URL for opening the specified playlist in a web browser.
  @override
  Uri get fallbackLink => universalLink;
}

/// An action to search for content in the YouTube app.
///
/// This class extends [YouTube] and implements multiple interfaces to provide
/// comprehensive functionality for searching with fallback support.
class YouTubeSearchAction extends YouTube implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [YouTubeSearchAction] instance.
  ///
  /// Parameters:
  /// - [query]: The search query.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the YouTube app is not installed.
  YouTubeSearchAction({
    required this.query,
    required super.fallbackToStore,
  });

  /// The search query.
  final String query;

  /// The universal link URL for searching in the YouTube app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.youtube.com',
        path: 'results',
        queryParameters: {'search_query': query},
      );

  /// The fallback URL for searching in a web browser.
  @override
  Uri get fallbackLink => universalLink;
}

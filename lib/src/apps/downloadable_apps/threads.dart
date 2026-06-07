import 'package:deeplink_x/src/src.dart';

/// Threads application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the Threads app on supported platforms.
class Threads extends App implements DownloadableApp {
  /// Creates a new [Threads] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Threads app is not installed. Default is false.
  Threads({this.fallbackToStore = false});

  /// Creates an action to open the Threads app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Threads app is not installed. Default is false.
  ///
  /// Returns a [Threads] instance that can be used to open the Threads app.
  factory Threads.open({final bool fallbackToStore = false}) => Threads(fallbackToStore: fallbackToStore);

  /// A list of actions to open the Threads app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.instagram.barcelona'),
        IOSAppStore.openAppPage(
          appId: '6446901002',
          appName: 'threads-an-instagram-app',
        ),
      ];

  /// The Android package name for the Threads app.
  @override
  String get androidPackageName => 'com.instagram.barcelona';

  /// The custom URL scheme for the Threads app.
  @override
  String get customScheme => 'barcelona';

  /// The MacOS bundle identifier for the Threads app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the Threads app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to automatically redirect to app stores when the Threads app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for Threads.
  @override
  Uri get website => Uri.parse('https://www.threads.com');

  /// Creates an action to open a specific profile in the Threads app.
  static ThreadsOpenProfileAction openProfile({
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      ThreadsOpenProfileAction(
        username: username,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific post in the Threads app.
  static ThreadsOpenPostAction openPost({
    required final String username,
    required final String postId,
    final bool fallbackToStore = false,
  }) =>
      ThreadsOpenPostAction(
        username: username,
        postId: postId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open the replies view for a specific post.
  ///
  /// Threads surfaces replies on the post permalink, so this uses the same URL
  /// target as [openPost].
  static ThreadsOpenCommentsAction openComments({
    required final String username,
    required final String postId,
    final bool fallbackToStore = false,
  }) =>
      ThreadsOpenCommentsAction(
        username: username,
        postId: postId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open Threads' compose flow with prefilled text.
  static ThreadsCreatePostAction createPost({
    required final String text,
    final bool fallbackToStore = false,
  }) =>
      ThreadsCreatePostAction(
        text: text,
        fallbackToStore: fallbackToStore,
      );
}

/// An action to open a specific profile in the Threads app.
class ThreadsOpenProfileAction extends Threads implements IntentAppLinkAction, AppLinkAppAction, Fallbackable {
  /// Creates a new [ThreadsOpenProfileAction] instance.
  ThreadsOpenProfileAction({
    required this.username,
    required super.fallbackToStore,
  });

  /// The username of the profile to open.
  final String username;

  /// The app link URL for opening the specified profile in the Threads app on iOS.
  @override
  Uri get appLink => Uri(
        scheme: 'barcelona',
        host: 'user',
        queryParameters: {'username': username},
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: fallbackLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  /// The fallback link to use when the Threads app cannot be opened.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.threads.com',
        path: '@$username',
      );
}

/// An action to open a specific post in the Threads app.
class ThreadsOpenPostAction extends Threads implements IntentAppLinkAction, UniversalLinkAppAction, Fallbackable {
  /// Creates a new [ThreadsOpenPostAction] instance.
  ThreadsOpenPostAction({
    required this.username,
    required this.postId,
    required super.fallbackToStore,
  });

  /// The username that owns the post.
  final String username;

  /// The post identifier.
  final String postId;

  @override
  Uri? get appLink => null;

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: universalLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  /// The universal link URL for the specified Threads post.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.threads.com',
        pathSegments: ['@$username', 'post', postId],
      );

  /// The fallback link to use when the Threads app cannot be opened.
  @override
  Uri get fallbackLink => universalLink;
}

/// An action to open the replies/comments view for a specific Threads post.
class ThreadsOpenCommentsAction extends ThreadsOpenPostAction {
  /// Creates a new [ThreadsOpenCommentsAction] instance.
  ThreadsOpenCommentsAction({
    required super.username,
    required super.postId,
    required super.fallbackToStore,
  });
}

/// An action to open the Threads compose flow with prefilled text.
class ThreadsCreatePostAction extends Threads implements IntentAppLinkAction, AppLinkAppAction, Fallbackable {
  /// Creates a new [ThreadsCreatePostAction] instance.
  ThreadsCreatePostAction({
    required this.text,
    required super.fallbackToStore,
  });

  /// The text to prefill in the compose flow.
  final String text;

  /// The app link URL for opening the compose flow in the Threads app on iOS.
  @override
  Uri get appLink => Uri(
        scheme: 'barcelona',
        host: 'create',
        queryParameters: {'text': text},
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_send',
        arguments: {'android.intent.extra.TEXT': text},
        package: androidPackageName,
        type: 'text/plain',
        flags: const [0x10000000],
      );

  /// The fallback link to use when the Threads app cannot be opened.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.threads.com',
        pathSegments: ['intent', 'post'],
        queryParameters: {'text': text},
      );
}

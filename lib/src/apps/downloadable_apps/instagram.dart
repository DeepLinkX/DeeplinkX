import 'package:deeplink_x/src/src.dart';

/// Instagram application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the Instagram app on various platforms.
class Instagram extends App implements DownloadableApp {
  /// Creates a new [Instagram] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Instagram app is not installed. Default is false.
  Instagram({this.fallbackToStore = false});

  /// Creates an action to open the Instagram app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Instagram app is not installed. Default is false.
  ///
  /// Returns an [Instagram] instance that can be used to open the Instagram app.
  factory Instagram.open({final bool fallbackToStore = false}) => Instagram(fallbackToStore: fallbackToStore);

  /// A list of actions to open the Instagram app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.instagram.android'),
        IOSAppStore.openAppPage(appId: '389801252', appName: 'instagram'),
      ];

  /// The Android package name for the Instagram app.
  @override
  String get androidPackageName => 'com.instagram.android';

  /// The custom URL scheme for the Instagram app.
  @override
  String get customScheme => 'instagram';

  /// The MacOS bundle identifier for the Instagram app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the Instagram app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to automatically redirect to app stores when the Instagram app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for Instagram.
  @override
  Uri get website => Uri.parse('https://www.instagram.com');

  /// Creates an action to open a specific profile in the Instagram app.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open (e.g. 'instagram').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Instagram app is not installed. Default is false.
  ///
  /// Returns an [InstagramOpenProfileAction] instance that can be used to open
  /// the specified profile in the Instagram app.
  static InstagramOpenProfileAction openProfile({
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      InstagramOpenProfileAction(
        username: username,
        fallbackToStore: fallbackToStore,
      );
}

/// An action to open a specific profile in the Instagram app.
///
/// This class extends [Instagram] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class InstagramOpenProfileAction extends Instagram implements AppLinkAppAction, Fallbackable {
  /// Creates a new [InstagramOpenProfileAction] instance.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Instagram app is not installed.
  InstagramOpenProfileAction({
    required this.username,
    required super.fallbackToStore,
  });

  /// The username of the profile to open.
  final String username;

  /// The app link URL for opening the specified profile in the Instagram app.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{'username': username};
    return Uri(
      scheme: 'instagram',
      host: 'user',
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the Instagram app cannot be opened.
  ///
  /// This URL opens the specified profile on the Instagram website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.instagram.com',
        path: username,
      );
}

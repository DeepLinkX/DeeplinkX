import 'package:deeplink_x/src/src.dart';

/// Snapchat application.
///
/// Provides deep links for opening Snapchat profiles.
class Snapchat extends App implements DownloadableApp {
  /// Creates a new [Snapchat] instance.
  Snapchat({this.fallbackToStore = false});

  /// Creates an action to open the Snapchat app.
  factory Snapchat.open({final bool fallbackToStore = false}) => Snapchat(fallbackToStore: fallbackToStore);

  /// Store actions for Snapchat.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.snapchat.android'),
        IOSAppStore.openAppPage(appId: '447188370', appName: 'snapchat'),
        MicrosoftStore.openAppPage(productId: '9pf9rtkmmq69'),
      ];

  /// Android package name for Snapchat.
  @override
  String get androidPackageName => 'com.snapchat.android';

  /// Custom scheme for Snapchat.
  @override
  String get customScheme => 'snapchat';

  /// macOS bundle identifier is not provided by this integration.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms for Snapchat.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android, PlatformType.windows];

  /// Whether to redirect to stores when Snapchat is unavailable.
  @override
  bool fallbackToStore;

  /// Snapchat web fallback.
  @override
  Uri get website => Uri.parse('https://www.snapchat.com');

  /// Creates an action to open a Snapchat profile by username.
  static SnapchatOpenProfileAction openProfile({
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      SnapchatOpenProfileAction(
        username: username,
        fallbackToStore: fallbackToStore,
      );
}

/// Opens a Snapchat profile by username.
class SnapchatOpenProfileAction extends Snapchat implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [SnapchatOpenProfileAction].
  SnapchatOpenProfileAction({
    required this.username,
    required super.fallbackToStore,
  });

  /// The Snapchat username.
  final String username;

  /// The Snapchat profile universal link.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.snapchat.com',
        pathSegments: ['add', username],
      );

  /// Web fallback for the profile.
  @override
  Uri get fallbackLink => universalLink;
}

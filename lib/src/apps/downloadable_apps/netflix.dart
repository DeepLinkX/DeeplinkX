import 'package:deeplink_x/src/src.dart';

/// Netflix application.
///
/// Provides deep links for opening Netflix titles and playback links.
class Netflix extends App implements DownloadableApp {
  /// Creates a new [Netflix] instance.
  Netflix({this.fallbackToStore = false});

  /// Creates an action to open the Netflix app.
  factory Netflix.open({final bool fallbackToStore = false}) => Netflix(fallbackToStore: fallbackToStore);

  /// Store actions for Netflix.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.netflix.mediaclient'),
        IOSAppStore.openAppPage(appId: '363590051', appName: 'netflix'),
        MicrosoftStore.openAppPage(productId: '9wzdncrfj3tj'),
      ];

  /// Android package name for Netflix.
  @override
  String get androidPackageName => 'com.netflix.mediaclient';

  /// Custom scheme for Netflix.
  @override
  String get customScheme => 'nflx';

  /// macOS bundle identifier is not provided by this integration.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms for Netflix.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android, PlatformType.windows];

  /// Whether to redirect to stores when Netflix is unavailable.
  @override
  bool fallbackToStore;

  /// Netflix web fallback.
  @override
  Uri get website => Uri.parse('https://www.netflix.com');

  /// Creates an action to open a Netflix title page.
  static NetflixOpenTitleAction openTitle({
    required final String titleId,
    final bool fallbackToStore = false,
  }) =>
      NetflixOpenTitleAction(
        titleId: titleId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open Netflix playback for a title.
  static NetflixWatchTitleAction watchTitle({
    required final String titleId,
    final bool fallbackToStore = false,
  }) =>
      NetflixWatchTitleAction(
        titleId: titleId,
        fallbackToStore: fallbackToStore,
      );
}

/// Opens a Netflix title page.
class NetflixOpenTitleAction extends Netflix implements AppLinkAppAction, Fallbackable {
  /// Creates a new [NetflixOpenTitleAction].
  NetflixOpenTitleAction({
    required this.titleId,
    required super.fallbackToStore,
  });

  /// The Netflix title identifier.
  final String titleId;

  /// Native Netflix title link.
  @override
  Uri get appLink => Uri.parse('nflx://www.netflix.com/title/$titleId');

  /// Web fallback for the title.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.netflix.com',
        pathSegments: ['title', titleId],
      );
}

/// Opens Netflix playback for a title.
class NetflixWatchTitleAction extends Netflix implements AppLinkAppAction, Fallbackable {
  /// Creates a new [NetflixWatchTitleAction].
  NetflixWatchTitleAction({
    required this.titleId,
    required super.fallbackToStore,
  });

  /// The Netflix title identifier.
  final String titleId;

  /// Native Netflix watch link.
  @override
  Uri get appLink => Uri.parse('nflx://www.netflix.com/watch/$titleId');

  /// Web fallback for playback.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.netflix.com',
        pathSegments: ['watch', titleId],
      );
}

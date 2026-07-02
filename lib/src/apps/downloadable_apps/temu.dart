import 'package:deeplink_x/src/src.dart';

/// Temu application.
///
/// Provides deep links for opening Temu links and searches.
class Temu extends App implements DownloadableApp {
  /// Creates a new [Temu] instance.
  Temu({this.fallbackToStore = false});

  /// Creates an action to open the Temu app.
  factory Temu.open({final bool fallbackToStore = false}) => Temu(fallbackToStore: fallbackToStore);

  /// Store actions for Temu.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.einnovation.temu'),
        IOSAppStore.openAppPage(appId: '1641486558', appName: 'temu-shop-like-a-billionaire'),
      ];

  /// Android package name for Temu.
  @override
  String get androidPackageName => 'com.einnovation.temu';

  /// Custom scheme for Temu.
  @override
  String get customScheme => 'temu';

  /// macOS bundle identifier is not provided by this integration.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms for Temu.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to stores when Temu is unavailable.
  @override
  bool fallbackToStore;

  /// Temu web fallback.
  @override
  Uri get website => Uri.parse('https://www.temu.com');

  /// Creates an action to open a Temu web, product, affiliate, or share link.
  static TemuOpenLinkAction openLink({
    required final Uri link,
    final bool fallbackToStore = false,
  }) =>
      TemuOpenLinkAction(
        link: link,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to search Temu.
  static TemuSearchAction search({
    required final String query,
    final bool fallbackToStore = false,
  }) =>
      TemuSearchAction(
        query: query,
        fallbackToStore: fallbackToStore,
      );
}

/// Opens a Temu link.
class TemuOpenLinkAction extends Temu implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [TemuOpenLinkAction].
  TemuOpenLinkAction({
    required this.link,
    required super.fallbackToStore,
  });

  /// The Temu link to open.
  final Uri link;

  /// The Temu universal link.
  @override
  Uri get universalLink => link;

  /// Web fallback for the Temu link.
  @override
  Uri get fallbackLink => universalLink;
}

/// Searches Temu.
class TemuSearchAction extends Temu implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [TemuSearchAction].
  TemuSearchAction({
    required this.query,
    required super.fallbackToStore,
  });

  /// The search query.
  final String query;

  /// The Temu search link.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.temu.com',
        path: 'search_result.html',
        queryParameters: {'search_key': query},
      );

  /// Web fallback for the search.
  @override
  Uri get fallbackLink => universalLink;
}

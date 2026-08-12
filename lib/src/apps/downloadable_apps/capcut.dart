import 'package:deeplink_x/src/src.dart';

/// CapCut application.
///
/// Provides deep links for opening CapCut and CapCut template links.
class CapCut extends App implements DownloadableApp {
  /// Creates a new [CapCut] instance.
  CapCut({this.fallbackToStore = false});

  /// Creates an action to open the CapCut app.
  factory CapCut.open({final bool fallbackToStore = false}) => CapCut(fallbackToStore: fallbackToStore);

  /// Store actions for CapCut.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.lemon.lvoverseas'),
        IOSAppStore.openAppPage(appId: '1500855883', appName: 'capcut-photo-video-editor'),
        MicrosoftStore.openAppPage(productId: 'xp9kn75rrb9nhs'),
      ];

  /// Android package name for CapCut.
  @override
  String get androidPackageName => 'com.lemon.lvoverseas';

  /// Custom scheme for CapCut.
  @override
  String get customScheme => 'capcut';

  /// macOS bundle identifier is not provided by this integration.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms for CapCut.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android, PlatformType.windows];

  /// Whether to redirect to stores when CapCut is unavailable.
  @override
  bool fallbackToStore;

  /// CapCut web fallback.
  @override
  Uri get website => Uri.parse('https://www.capcut.com');

  /// Creates an action to open a CapCut template link.
  static CapCutOpenTemplateAction openTemplate({
    required final Uri templateLink,
    final bool fallbackToStore = false,
  }) =>
      CapCutOpenTemplateAction(
        templateLink: templateLink,
        fallbackToStore: fallbackToStore,
      );
}

/// Opens a CapCut template link.
class CapCutOpenTemplateAction extends CapCut implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [CapCutOpenTemplateAction].
  CapCutOpenTemplateAction({
    required this.templateLink,
    required super.fallbackToStore,
  });

  /// The CapCut template link.
  final Uri templateLink;

  /// The CapCut template universal link.
  @override
  Uri get universalLink => templateLink;

  /// Web fallback for the template link.
  @override
  Uri get fallbackLink => universalLink;
}

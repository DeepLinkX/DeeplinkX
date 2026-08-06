import 'package:deeplink_x/src/src.dart';

/// ChatGPT application.
///
/// Provides deep links for opening ChatGPT and supported ChatGPT web links.
class ChatGPT extends App implements DownloadableApp {
  /// Creates a new [ChatGPT] instance.
  ChatGPT({this.fallbackToStore = false});

  /// Creates an action to open the ChatGPT app.
  factory ChatGPT.open({final bool fallbackToStore = false}) => ChatGPT(fallbackToStore: fallbackToStore);

  /// Store actions for ChatGPT.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.openai.chatgpt'),
        IOSAppStore.openAppPage(appId: '6448311069', appName: 'chatgpt'),
        MicrosoftStore.openAppPage(productId: '9nt1r1c2hh7j'),
      ];

  /// Android package name for ChatGPT.
  @override
  String get androidPackageName => 'com.openai.chatgpt';

  /// Custom scheme for ChatGPT.
  @override
  String get customScheme => 'chatgpt';

  /// macOS bundle identifier is not provided by this integration.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms for ChatGPT.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android, PlatformType.windows];

  /// Whether to redirect to stores when ChatGPT is unavailable.
  @override
  bool fallbackToStore;

  /// ChatGPT web fallback.
  @override
  Uri get website => Uri.parse('https://chatgpt.com');

  /// Creates an action to open a shared ChatGPT conversation.
  static ChatGPTOpenSharedConversationAction openSharedConversation({
    required final String shareId,
    final bool fallbackToStore = false,
  }) =>
      ChatGPTOpenSharedConversationAction(
        shareId: shareId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a GPT by ID.
  static ChatGPTOpenGptAction openGpt({
    required final String gptId,
    final bool fallbackToStore = false,
  }) =>
      ChatGPTOpenGptAction(
        gptId: gptId,
        fallbackToStore: fallbackToStore,
      );
}

/// Opens a shared ChatGPT conversation.
class ChatGPTOpenSharedConversationAction extends ChatGPT implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [ChatGPTOpenSharedConversationAction].
  ChatGPTOpenSharedConversationAction({
    required this.shareId,
    required super.fallbackToStore,
  });

  /// The shared conversation identifier.
  final String shareId;

  /// The ChatGPT shared conversation link.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'chatgpt.com',
        pathSegments: ['share', shareId],
      );

  /// Web fallback for the shared conversation.
  @override
  Uri get fallbackLink => universalLink;
}

/// Opens a GPT by ID.
class ChatGPTOpenGptAction extends ChatGPT implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [ChatGPTOpenGptAction].
  ChatGPTOpenGptAction({
    required this.gptId,
    required super.fallbackToStore,
  });

  /// The GPT identifier.
  final String gptId;

  /// The GPT link.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'chatgpt.com',
        pathSegments: ['g', gptId],
      );

  /// Web fallback for the GPT.
  @override
  Uri get fallbackLink => universalLink;
}

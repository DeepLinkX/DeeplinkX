import 'package:deeplink_x/src/src.dart';

/// WhatsApp application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the WhatsApp app on various platforms.
class WhatsApp extends App implements DownloadableApp {
  /// Creates a new [WhatsApp] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the WhatsApp app is not installed. Default is false.
  WhatsApp({this.fallbackToStore = false});

  /// Creates an action to open the WhatsApp app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the WhatsApp app is not installed. Default is false.
  ///
  /// Returns a [WhatsApp] instance that can be used to open the WhatsApp app.
  factory WhatsApp.open({final bool fallbackToStore = false}) => WhatsApp(fallbackToStore: fallbackToStore);

  /// A list of actions to open the WhatsApp app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.whatsapp'),
        IOSAppStore.openAppPage(
          appId: '310633997',
          appName: 'whatsapp-messenger',
        ),
        MicrosoftStore.openAppPage(productId: '9nksqgp7f2nh'),
        MacAppStore.openAppPage(
          appId: '310633997',
          appName: 'whatsapp-messenger',
        ),
      ];

  /// The Android package name for the WhatsApp app.
  @override
  String get androidPackageName => 'com.whatsapp';

  /// The custom URL scheme for the WhatsApp app.
  @override
  String get customScheme => 'whatsapp';

  /// The MacOS bundle identifier for the WhatsApp app.
  @override
  String? get macosBundleIdentifier => 'net.whatsapp.WhatsApp';

  /// The platforms that the WhatsApp app supports.
  @override
  List<PlatformType> get supportedPlatforms => [
        PlatformType.ios,
        PlatformType.android,
        PlatformType.windows,
        PlatformType.macos,
      ];

  /// Whether to automatically redirect to app stores when the WhatsApp app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for WhatsApp.
  @override
  Uri get website => Uri.parse('https://www.whatsapp.com');

  /// Creates an action to start a chat with a specific phone number in the WhatsApp app.
  ///
  /// Parameters:
  /// - [phoneNumber]: The phone number to chat with (including country code without '+') (e.g. '1234567890').
  /// - [message]: Optional pre-filled message to send (e.g. 'Hello, how are you?').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the WhatsApp app is not installed. Default is false.
  ///
  /// Returns a [WhatsAppChatAction] instance that can be used to start a chat
  /// with the specified phone number in the WhatsApp app.
  static WhatsAppChatAction chat({
    required final String phoneNumber,
    final String? message,
    final bool fallbackToStore = false,
  }) =>
      WhatsAppChatAction(
        phoneNumber: phoneNumber,
        message: message,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to share text via the WhatsApp app.
  ///
  /// Parameters:
  /// - [text]: The text to share (e.g. 'Check out this link: https://example.com').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the WhatsApp app is not installed. Default is false.
  ///
  /// Returns a [WhatsAppShareTextAction] instance that can be used to
  /// share text via the WhatsApp app.
  static WhatsAppShareTextAction shareText({
    required final String text,
    final bool fallbackToStore = false,
  }) =>
      WhatsAppShareTextAction(
        text: text,
        fallbackToStore: fallbackToStore,
      );
}

/// An action to start a chat with a specific phone number in the WhatsApp app.
///
/// This class extends [WhatsApp] and implements multiple interfaces to provide
/// comprehensive functionality for starting chats with fallback support.
class WhatsAppChatAction extends WhatsApp implements AppLinkAppAction, Fallbackable {
  /// Creates a new [WhatsAppChatAction] instance.
  ///
  /// Parameters:
  /// - [phoneNumber]: The phone number to chat with (including country code without '+').
  /// - [message]: Optional pre-filled message to send.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the WhatsApp app is not installed.
  WhatsAppChatAction({
    required this.phoneNumber,
    required this.message,
    required super.fallbackToStore,
  });

  /// The phone number to chat with (including country code without '+').
  final String phoneNumber;

  /// Optional pre-filled message to send.
  final String? message;

  /// The app link URL for starting a chat with the specified phone number in the WhatsApp app.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'phone': phoneNumber,
      if (message != null) 'text': message!,
    };
    return Uri(
      scheme: 'whatsapp',
      host: 'send',
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the WhatsApp app cannot be opened.
  ///
  /// This URL opens the WhatsApp click-to-chat web interface.
  @override
  Uri get fallbackLink {
    final queryParameters = <String, String>{
      if (message != null) 'text': message!,
    };
    return Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
  }
}

/// An action to share text via the WhatsApp app.
///
/// This class extends [WhatsApp] and implements multiple interfaces to provide
/// comprehensive functionality for sharing text with fallback support.
class WhatsAppShareTextAction extends WhatsApp implements AppLinkAppAction, Fallbackable {
  /// Creates a new [WhatsAppShareTextAction] instance.
  ///
  /// Parameters:
  /// - [text]: The text to share.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the WhatsApp app is not installed.
  WhatsAppShareTextAction({
    required this.text,
    required super.fallbackToStore,
  });

  /// The text to share.
  final String text;

  /// The app link URL for sharing text via the WhatsApp app.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'text': text,
    };
    return Uri(
      scheme: 'whatsapp',
      host: 'send',
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the WhatsApp app cannot be opened.
  ///
  /// This URL opens the WhatsApp click-to-chat web interface.
  @override
  Uri get fallbackLink {
    final queryParameters = <String, String>{
      'text': text,
    };
    return Uri(
      scheme: 'https',
      host: 'wa.me',
      queryParameters: queryParameters,
    );
  }
}

import 'package:deeplink_x/src/apps/app_stores/app_stores.dart';
import 'package:deeplink_x/src/core/app_actions/downloadable_app_action.dart';
import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';

/// WhatsApp-specific action types that define available deeplink actions
enum WhatsAppActionType implements ActionTypeEnum {
  /// Opens the WhatsApp app
  open,

  /// Opens a chat with a specific phone number
  chat,

  /// Shares content via WhatsApp
  share,
}

/// WhatsApp action implementation for handling WhatsApp-specific deeplinks
class WhatsAppAction extends DownloadableAppAction {
  /// Creates a new WhatsApp action
  ///
  /// [type] specifies the type of action to perform (e.g., open app, chat)
  /// [fallBackToStore] determines if the action should redirect to app store when app isn't installed
  /// [parameters] contains any additional data needed for the action (e.g., phone number for chat)
  /// [actionType] is internally set to [type] for action handling
  /// [supportedStoresActions] is set to predefined [storesActions] for store handling
  WhatsAppAction(
    this.type, {
    required super.fallBackToStore,
    super.parameters,
  }) : super(
          actionType: type,
          supportedStoresActions: storesActions,
        );

  /// Base URI for WhatsApp app deeplinks
  static const baseUrl = 'whatsapp://';

  /// Base URI for WhatsApp web fallback
  static const fallBackUri = 'https://wa.me';

  /// The type of WhatsApp action to perform
  final WhatsAppActionType type;

  /// List of store actions for downloading/opening WhatsApp across different platforms
  ///
  /// Contains actions for:
  /// - Play Store
  /// - iOS App Store
  /// - Microsoft Store
  /// - Mac App Store
  static final List<StoreAppAction> storesActions = [
    PlayStore.openAppPage(packageName: 'com.whatsapp'),
    IOSAppStore.openAppPage(appId: '310633997', appName: 'whatsapp-messenger'),
    MicrosoftStore.openAppPage(productId: '9nksqgp7f2nh'),
    MacAppStore.openAppPage(appId: '310633997', appName: 'whatsapp-messenger'),
  ];

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case WhatsAppActionType.open:
        return Uri.parse(baseUrl);
      case WhatsAppActionType.chat:
        final phoneNumber = parameters!['phoneNumber'];
        final text = parameters!['text'];

        // Build query parameters
        final queryParams = <String, String>{'phone': phoneNumber!};

        if (text != null) {
          queryParams['text'] = text;
        }

        return Uri.parse(baseUrl).replace(
          host: 'send',
          queryParameters: queryParams,
        );
      case WhatsAppActionType.share:
        final text = parameters!['text'];

        // Build query parameters
        final queryParams = <String, String>{'text': text!};

        return Uri.parse(baseUrl).replace(
          host: 'send',
          queryParameters: queryParams,
        );
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case WhatsAppActionType.open:
        return Uri.parse(fallBackUri);
      case WhatsAppActionType.chat:
        final phoneNumber = parameters!['phoneNumber'];
        final text = parameters!['text'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (text != null) {
          queryParams['text'] = text;
        }

        return Uri.parse(fallBackUri).replace(
          path: phoneNumber,
          queryParameters: queryParams.isNotEmpty ? queryParams : null,
        );
      case WhatsAppActionType.share:
        final text = parameters!['text'];

        // Build query parameters
        final queryParams = <String, String>{'text': text!};

        return Uri.parse(fallBackUri).replace(
          queryParameters: queryParams,
        );
    }
  }
}

/// Factory class for creating WhatsApp deeplink actions
///
/// This class provides convenient factory methods for creating common WhatsApp
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for WhatsApp-specific action creation.
class WhatsApp {
  WhatsApp._();

  /// Opens the WhatsApp app
  static WhatsAppAction open({
    final bool fallBackToStore = false,
  }) =>
      WhatsAppAction(
        WhatsAppActionType.open,
        fallBackToStore: fallBackToStore,
      );

  /// Opens a chat with a specific phone number
  ///
  /// [phoneNumber] is the phone number to chat with. Must include country code without '+' or spaces
  /// (e.g., '1234567890' for US number +1 234 567 890, '447911123456' for UK number +44 7911 123456).
  ///
  /// [text] optional pre-filled message text to send in the chat
  ///
  /// [fallBackToStore] determines if the action should redirect to app store when WhatsApp isn't installed
  static WhatsAppAction chat(
    final String phoneNumber, {
    final String? text,
    final bool fallBackToStore = false,
  }) {
    final parameters = <String, String>{
      'phoneNumber': phoneNumber,
    };

    if (text != null) {
      parameters['text'] = text;
    }

    return WhatsAppAction(
      WhatsAppActionType.chat,
      parameters: parameters,
      fallBackToStore: fallBackToStore,
    );
  }

  /// Shares content via WhatsApp
  ///
  /// [text] is the text content to share
  static WhatsAppAction share(
    final String text, {
    final bool fallBackToStore = false,
  }) =>
      WhatsAppAction(
        WhatsAppActionType.share,
        parameters: {'text': text},
        fallBackToStore: fallBackToStore,
      );
}

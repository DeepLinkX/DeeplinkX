import 'package:deeplink_x/src/apps/app_stores/app_stores.dart';
import 'package:deeplink_x/src/core/app_actions/downloadable_app_action.dart';
import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';

/// Telegram-specific action types that define available deeplink actions
enum TelegramActionType implements ActionTypeEnum {
  /// Opens the Telegram app
  open,

  /// Opens a specific Telegram profile by username
  openProfile,

  /// Opens a specific Telegram profile by phone number
  openProfilePhoneNumber,

  /// Sends a message to a specific user by username
  sendMessage,

  /// Sends a message to a specific user by phone number
  sendMessagePhoneNumber,
}

/// Telegram action implementation for handling Telegram-specific deeplinks
class TelegramAction extends DownloadableAppAction {
  /// Creates a new Telegram action
  ///
  /// [type] specifies the type of action to perform
  /// [fallBackToStore] determines if the action should redirect to app store when app isn't installed
  /// [parameters] contains any additional data needed for the action (e.g., username for profile)
  /// [actionType] is internally set to [type] for action handling
  /// [supportedStoresActions] is set to predefined [storesActions] for store handling
  TelegramAction(
    this.type, {
    required super.fallBackToStore,
    super.parameters,
  }) : super(
          actionType: type,
          supportedStoresActions: storesActions,
        );

  /// Base URI for Telegram app deeplinks
  static const baseUrl = 'tg://';

  /// Base URI for Telegram web fallback
  static const fallBackUri = 'https://t.me';

  /// List of store actions for downloading/opening Telegram across different platforms
  ///
  /// Contains actions for:
  /// - Play Store
  /// - iOS App Store
  /// - Microsoft Store
  /// - Mac App Store
  static final List<StoreAppAction> storesActions = [
    PlayStore.openAppPage(packageName: 'org.telegram.messenger'),
    HuaweiAppGalleryStore.openAppPage(packageName: 'org.telegram.messenger', appId: 'C101184875'),
    IOSAppStore.openAppPage(appId: '686449807', appName: 'telegram-messenger'),
    MicrosoftStore.openAppPage(productId: '9nztwsqntd0s'),
    MacAppStore.openAppPage(appId: '747648890', appName: 'telegram'),
  ];

  /// The type of Telegram action to perform
  final TelegramActionType type;

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case TelegramActionType.open:
        return Uri.parse(baseUrl);
      case TelegramActionType.openProfile:
        final username = parameters!['username'];
        return Uri.parse('${baseUrl}resolve?domain=$username&profile');
      case TelegramActionType.openProfilePhoneNumber:
        final phoneNumber = parameters!['phoneNumber'];
        return Uri.parse('${baseUrl}resolve?phone=$phoneNumber&profile');
      case TelegramActionType.sendMessage:
        final username = parameters!['username'];
        final message = parameters!['message']!;
        final encodedMessage = _getEncodedMessage(message);
        return Uri.parse('${baseUrl}resolve?domain=$username&text=$encodedMessage');
      case TelegramActionType.sendMessagePhoneNumber:
        final phoneNumber = parameters!['phoneNumber'];
        final message = parameters!['message']!;
        final encodedMessage = _getEncodedMessage(message);
        return Uri.parse('${baseUrl}resolve?phone=$phoneNumber&text=$encodedMessage');
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case TelegramActionType.open:
        return Uri.parse(fallBackUri);
      case TelegramActionType.openProfile:
        final username = parameters!['username'];
        return Uri.parse('$fallBackUri/$username?profile');
      case TelegramActionType.openProfilePhoneNumber:
        final phoneNumber = parameters!['phoneNumber'];
        return Uri.parse('$fallBackUri/+$phoneNumber?profile');
      case TelegramActionType.sendMessage:
        final username = parameters!['username'];
        final message = parameters!['message']!;
        final encodedMessage = _getEncodedMessage(message);
        return Uri.parse('$fallBackUri/$username?text=$encodedMessage');
      case TelegramActionType.sendMessagePhoneNumber:
        final phoneNumber = parameters!['phoneNumber'];
        final message = parameters!['message']!;
        final encodedMessage = _getEncodedMessage(message);
        return Uri.parse('$fallBackUri/+$phoneNumber?text=$encodedMessage');
    }
  }

  String _getEncodedMessage(final String message) {
    String encodedMessage = message;
    if (encodedMessage.startsWith('@')) {
      encodedMessage = ' $encodedMessage'; // Prepend whitespace to avoid triggering inline query
    }

    return Uri.encodeComponent(encodedMessage);
  }
}

/// Factory class for creating Telegram deeplink actions
///
/// This class provides convenient factory methods for creating common Telegram
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for Telegram-specific action creation.
class Telegram {
  Telegram._();

  /// Opens the Telegram app
  static TelegramAction open({
    final bool fallBackToStore = false,
  }) =>
      TelegramAction(
        TelegramActionType.open,
        fallBackToStore: fallBackToStore,
      );

  /// Opens a specific Telegram profile by username
  ///
  /// [username] is the Telegram username to open
  static TelegramAction openProfile(
    final String username, {
    final bool fallBackToStore = false,
  }) =>
      TelegramAction(
        TelegramActionType.openProfile,
        parameters: {'username': username},
        fallBackToStore: fallBackToStore,
      );

  /// Opens a specific Telegram profile by phone number
  ///
  /// [phoneNumber] is the Telegram phone number to open. Must include country code
  /// (e.g., '1234567890' for US number, '447911123456' for UK number).
  /// Do not include '+' or spaces in the phone number.
  static TelegramAction openProfilePhoneNumber(
    final String phoneNumber, {
    final bool fallBackToStore = false,
  }) =>
      TelegramAction(
        TelegramActionType.openProfilePhoneNumber,
        parameters: {'phoneNumber': phoneNumber},
        fallBackToStore: fallBackToStore,
      );

  /// Sends a message to a specific user by username
  ///
  /// [username] is the Telegram username to send message to
  /// [message] is the text to pre-fill in the message input
  static TelegramAction sendMessage(
    final String username,
    final String message, {
    final bool fallBackToStore = false,
  }) =>
      TelegramAction(
        TelegramActionType.sendMessage,
        parameters: {
          'username': username,
          'message': message,
        },
        fallBackToStore: fallBackToStore,
      );

  /// Sends a message to a specific user by phone number
  ///
  /// [phoneNumber] is the Telegram phone number to send message to. Must include country code
  /// (e.g., '1234567890' for US number, '447911123456' for UK number).
  /// Do not include '+' or spaces in the phone number.
  /// [message] is the text to pre-fill in the message input
  static TelegramAction sendMessagePhoneNumber(
    final String phoneNumber,
    final String message, {
    final bool fallBackToStore = false,
  }) =>
      TelegramAction(
        TelegramActionType.sendMessagePhoneNumber,
        parameters: {
          'phoneNumber': phoneNumber,
          'message': message,
        },
        fallBackToStore: fallBackToStore,
      );
}

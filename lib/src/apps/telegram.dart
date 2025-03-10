import 'package:deeplink_x/src/core/app_action.dart';
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
class TelegramAction extends AppAction {
  /// Creates a new Telegram action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const TelegramAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type);

  /// Base URI for Telegram app deeplinks
  static const baseUrl = 'tg://';

  /// Base URI for Telegram web fallback
  static const fallBackUri = 'https://t.me';

  /// The type of Telegram action to perform
  final TelegramActionType type;

  @override
  Future<List<Uri>> getUris() async {
    final List<Uri> uris = [];

    switch (type) {
      case TelegramActionType.open:
        uris.add(Uri.parse(baseUrl));
        uris.add(Uri.parse(fallBackUri));
      case TelegramActionType.openProfile:
        final username = parameters!['username'];
        uris.add(Uri.parse('${baseUrl}resolve?domain=$username&profile'));
        uris.add(Uri.parse('$fallBackUri/$username?profile'));
      case TelegramActionType.openProfilePhoneNumber:
        final phoneNumber = parameters!['phoneNumber'];
        uris.add(Uri.parse('${baseUrl}resolve?phone=$phoneNumber&profile'));
        uris.add(Uri.parse('$fallBackUri/+$phoneNumber?profile'));
      case TelegramActionType.sendMessage:
        final username = parameters!['username'];
        final message = parameters!['message']!;
        final encodedMessage = getEncodedMessage(message);
        uris.add(Uri.parse('${baseUrl}resolve?domain=$username&text=$encodedMessage'));
        uris.add(Uri.parse('$fallBackUri/$username?text=$encodedMessage'));
      case TelegramActionType.sendMessagePhoneNumber:
        final phoneNumber = parameters!['phoneNumber'];
        final message = parameters!['message']!;
        final encodedMessage = getEncodedMessage(message);
        uris.add(Uri.parse('${baseUrl}resolve?phone=$phoneNumber&text=$encodedMessage'));
        uris.add(Uri.parse('$fallBackUri/+$phoneNumber?text=$encodedMessage'));
    }

    return uris;
  }

  /// Encodes a message according to Telegram requirements
  ///
  /// This method prepends a whitespace to the message if it starts with '@'
  /// to avoid triggering inline query.
  ///
  /// [message] is the message to encode
  String getEncodedMessage(final String message) {
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
  static const TelegramAction open = TelegramAction(TelegramActionType.open);

  /// Opens a specific Telegram profile by username
  ///
  /// [username] is the Telegram username to open
  static TelegramAction openProfile(final String username) => TelegramAction(
        TelegramActionType.openProfile,
        parameters: {'username': username},
      );

  /// Opens a specific Telegram profile by phone number
  ///
  /// [phoneNumber] is the Telegram phone number to open. Must include country code
  /// (e.g., '1234567890' for US number, '447911123456' for UK number).
  /// Do not include '+' or spaces in the phone number.
  static TelegramAction openProfilePhoneNumber(final String phoneNumber) => TelegramAction(
        TelegramActionType.openProfilePhoneNumber,
        parameters: {'phoneNumber': phoneNumber},
      );

  /// Sends a message to a specific user by username
  ///
  /// [username] is the Telegram username to send message to
  /// [message] is the text to pre-fill in the message input
  static TelegramAction sendMessage(
    final String username,
    final String message,
  ) =>
      TelegramAction(
        TelegramActionType.sendMessage,
        parameters: {
          'username': username,
          'message': message,
        },
      );

  /// Sends a message to a specific user by phone number
  ///
  /// [phoneNumber] is the Telegram phone number to send message to. Must include country code
  /// (e.g., '1234567890' for US number, '447911123456' for UK number).
  /// Do not include '+' or spaces in the phone number.
  /// [message] is the text to pre-fill in the message input
  static TelegramAction sendMessagePhoneNumber(
    final String phoneNumber,
    final String message,
  ) =>
      TelegramAction(
        TelegramActionType.sendMessagePhoneNumber,
        parameters: {
          'phoneNumber': phoneNumber,
          'message': message,
        },
      );
}

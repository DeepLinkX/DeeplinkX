import 'package:deeplink_x/src/src.dart';

/// Telegram application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the Telegram app on various platforms.
class Telegram extends App implements DownloadableApp {
  /// Creates a new [Telegram] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed. Default is false.
  Telegram({this.fallbackToStore = false});

  /// Creates an action to open the Telegram app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed. Default is false.
  ///
  /// Returns a [Telegram] instance that can be used to open the Telegram app.
  factory Telegram.open({final bool fallbackToStore = false}) => Telegram(fallbackToStore: fallbackToStore);

  /// A list of actions to open the Telegram app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'org.telegram.messenger'),
        HuaweiAppGalleryStore.openAppPage(packageName: 'org.telegram.messenger', appId: 'C101184875'),
        IOSAppStore.openAppPage(appId: '686449807', appName: 'telegram-messenger'),
        MicrosoftStore.openAppPage(productId: '9nztwsqntd0s'),
        MacAppStore.openAppPage(appId: '747648890', appName: 'telegram'),
      ];

  /// The Android package name for the Telegram app.
  @override
  String get androidPackageName => 'org.telegram.messenger';

  /// The custom URL scheme for the Telegram app.
  @override
  String get customScheme => 'tg';

  /// Whether to automatically redirect to app stores when the Telegram app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for Telegram.
  @override
  Uri get website => Uri.parse('https://telegram.org');

  /// Creates an action to open a specific profile in the Telegram app.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open (e.g. 'telegram').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed. Default is false.
  ///
  /// Returns a [TelegramOpenProfileAction] instance that can be used to open
  /// the specified profile in the Telegram app.
  static TelegramOpenProfileAction openProfile({
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      TelegramOpenProfileAction(
        username: username,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific profile by phone number in the Telegram app.
  ///
  /// Parameters:
  /// - [phoneNumber]: The phone number of the profile to open (e.g. '1234567890').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed. Default is false.
  ///
  /// Returns a [TelegramOpenProfileByPhoneNumberAction] instance that can be used to open
  /// the specified profile in the Telegram app.
  static TelegramOpenProfileByPhoneNumberAction openProfileByPhoneNumber({
    required final String phoneNumber,
    final bool fallbackToStore = false,
  }) =>
      TelegramOpenProfileByPhoneNumberAction(
        phoneNumber: phoneNumber,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to send a message to a specific user in the Telegram app.
  ///
  /// Parameters:
  /// - [username]: The username of the recipient (e.g. 'telegram').
  /// - [message]: The message to send (e.g. 'Hello, how are you?').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed. Default is false.
  ///
  /// Returns a [TelegramSendMessageAction] instance that can be used to send
  /// a message to the specified user in the Telegram app.
  static TelegramSendMessageAction sendMessage({
    required final String username,
    required final String message,
    final bool fallbackToStore = false,
  }) =>
      TelegramSendMessageAction(
        username: username,
        message: message,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to send a message to a specific user by phone number in the Telegram app.
  ///
  /// Parameters:
  /// - [phoneNumber]: The phone number of the recipient (e.g. '1234567890').
  /// - [message]: The message to send (e.g. 'Hello, how are you?').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed. Default is false.
  ///
  /// Returns a [TelegramSendMessageByPhoneNumberAction] instance that can be used to send
  /// a message to the specified user in the Telegram app.
  static TelegramSendMessageByPhoneNumberAction sendMessageByPhoneNumber({
    required final String phoneNumber,
    required final String message,
    final bool fallbackToStore = false,
  }) =>
      TelegramSendMessageByPhoneNumberAction(
        phoneNumber: phoneNumber,
        message: message,
        fallbackToStore: fallbackToStore,
      );

  /// Encodes a message for use in Telegram deep links.
  ///
  /// This method ensures messages are properly formatted, especially if they
  /// begin with '@' which could trigger inline queries.
  ///
  /// Parameters:
  /// - [message]: The message to encode.
  ///
  /// Returns an encoded string suitable for use in Telegram deep links.
  String _getEncodedMessage(final String message) {
    String encodedMessage = message;

    if (encodedMessage.startsWith('@')) {
      encodedMessage = ' $encodedMessage'; // Prepend whitespace to avoid triggering inline query
    }

    return Uri.encodeComponent(encodedMessage);
  }
}

/// An action to open a specific profile in the Telegram app.
///
/// This class extends [Telegram] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class TelegramOpenProfileAction extends Telegram implements AppLinkAppAction, Fallbackable {
  /// Creates a new [TelegramOpenProfileAction] instance.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed.
  TelegramOpenProfileAction({
    required this.username,
    required super.fallbackToStore,
  });

  /// The username of the profile to open.
  final String username;

  /// The app link URL for opening the specified profile in the Telegram app.
  @override
  Uri get appLink => Uri.parse('tg://resolve?domain=$username&profile');

  /// The fallback link to use when the Telegram app cannot be opened.
  ///
  /// This URL opens the specified profile on the Telegram web interface.
  @override
  Uri get fallbackLink => Uri.parse('https://t.me/$username?profile');
}

/// An action to open a specific profile by phone number in the Telegram app.
///
/// This class extends [Telegram] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class TelegramOpenProfileByPhoneNumberAction extends Telegram implements AppLinkAppAction, Fallbackable {
  /// Creates a new [TelegramOpenProfileByPhoneNumberAction] instance.
  ///
  /// Parameters:
  /// - [phoneNumber]: The phone number of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed.
  TelegramOpenProfileByPhoneNumberAction({
    required this.phoneNumber,
    required super.fallbackToStore,
  });

  /// The phone number of the profile to open.
  final String phoneNumber;

  /// The app link URL for opening the specified profile by phone number in the Telegram app.
  @override
  Uri get appLink => Uri.parse('tg://resolve?phone=$phoneNumber&profile');

  /// The fallback link to use when the Telegram app cannot be opened.
  ///
  /// This URL opens the specified profile on the Telegram web interface.
  @override
  Uri get fallbackLink => Uri.parse('https://t.me/+$phoneNumber?profile');
}

/// An action to send a message to a specific user in the Telegram app.
///
/// This class extends [Telegram] and implements multiple interfaces to provide
/// comprehensive functionality for sending messages with fallback support.
class TelegramSendMessageAction extends Telegram implements AppLinkAppAction, Fallbackable {
  /// Creates a new [TelegramSendMessageAction] instance.
  ///
  /// Parameters:
  /// - [username]: The username of the recipient.
  /// - [message]: The message to send.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed.
  TelegramSendMessageAction({
    required this.username,
    required this.message,
    required super.fallbackToStore,
  });

  /// The username of the recipient.
  final String username;

  /// The message to send.
  final String message;

  /// The app link URL for sending a message to the specified user in the Telegram app.
  @override
  Uri get appLink {
    final encodedMessage = _getEncodedMessage(message);
    return Uri.parse('tg://resolve?domain=$username&text=$encodedMessage');
  }

  /// The fallback link to use when the Telegram app cannot be opened.
  ///
  /// This URL opens the chat with the specified user on the Telegram web interface.
  @override
  Uri get fallbackLink {
    final encodedMessage = _getEncodedMessage(message);
    return Uri.parse('https://t.me/$username?text=$encodedMessage');
  }
}

/// An action to send a message to a specific user by phone number in the Telegram app.
///
/// This class extends [Telegram] and implements multiple interfaces to provide
/// comprehensive functionality for sending messages with fallback support.
class TelegramSendMessageByPhoneNumberAction extends Telegram implements AppLinkAppAction, Fallbackable {
  /// Creates a new [TelegramSendMessageByPhoneNumberAction] instance.
  ///
  /// Parameters:
  /// - [phoneNumber]: The phone number of the recipient.
  /// - [message]: The message to send.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Telegram app is not installed.
  TelegramSendMessageByPhoneNumberAction({
    required this.phoneNumber,
    required this.message,
    required super.fallbackToStore,
  });

  /// The phone number of the recipient.
  final String phoneNumber;

  /// The message to send.
  final String message;

  /// The app link URL for sending a message to the specified user by phone number in the Telegram app.
  @override
  Uri get appLink {
    final encodedMessage = _getEncodedMessage(message);
    return Uri.parse('tg://resolve?phone=$phoneNumber&text=$encodedMessage');
  }

  /// The fallback link to use when the Telegram app cannot be opened.
  ///
  /// This URL opens the chat with the specified user on the Telegram web interface.
  @override
  Uri get fallbackLink {
    final encodedMessage = _getEncodedMessage(message);
    return Uri.parse('https://t.me/+$phoneNumber?text=$encodedMessage');
  }
}

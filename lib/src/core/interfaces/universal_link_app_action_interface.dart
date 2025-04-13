import 'package:deeplink_x/src/core/interfaces/interfaces.dart';

/// Represents an app action that uses a universal link.
///
/// This interface extends [AppAction] to define actions that can be performed
/// using universal links (iOS) or app links (Android). Universal links allow
/// apps to handle web URLs directly, providing a seamless experience between
/// web and native app.
abstract class UniversalLinkAppAction extends AppAction {
  /// The universal link URL used to launch the app with a specific action.
  ///
  /// This is typically a web URL that is associated with the app through
  /// platform-specific configurations. For example: 'https://instagram.com/username'
  Uri get universalLink;
}

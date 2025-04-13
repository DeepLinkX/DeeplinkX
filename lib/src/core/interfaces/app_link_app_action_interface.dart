import 'package:deeplink_x/src/core/interfaces/interfaces.dart';

/// Represents an app action that uses a standard app link.
///
/// This interface extends [AppAction] to define actions that can be performed
/// using a direct app link URL format. App links are a common way to launch
/// apps with specific actions on various platforms.
abstract class AppLinkAppAction extends AppAction {
  /// The URL used to launch the app with a specific action.
  ///
  /// This URL typically follows the app's custom scheme format, for example:
  /// `instagram://user?username=instagram`
  Uri get appLink;
}

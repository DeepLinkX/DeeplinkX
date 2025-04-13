import 'package:deeplink_x/src/core/interfaces/interfaces.dart';
import 'package:deeplink_x/src/core/models/models.dart';

/// Represents an app action that uses Android Intent options.
///
/// This interface extends [AppAction] to define actions that can be performed
/// using Android-specific Intent features. It provides the ability to use
/// the more powerful Intent system on Android while falling back to regular
/// app links on other platforms.
abstract class IntentAppLinkAction extends AppAction {
  /// The Android Intent options for launching this action on Android devices.
  ///
  /// This contains the specific Intent configuration needed for Android platforms.
  AndroidIntentOption get androidIntentOptions;

  /// An optional app link that can be used on non-Android platforms.
  ///
  /// This allows the action to work on platforms that don't support Android Intents.
  Uri? get appLink;
}

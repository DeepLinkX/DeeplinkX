import 'package:deeplink_x/src/core/interfaces/interfaces.dart';

/// Represents an app that can be downloaded from app stores.
///
/// This interface extends [App] to define properties specific to apps that
/// can be downloaded from app stores. It provides information about the
/// store actions that can be used to download the app and whether to
/// automatically fall back to store links when the app is not installed.
abstract class DownloadableApp extends App {
  /// A list of actions to open this app's page in various app stores.
  ///
  /// This list typically contains actions for different platforms, such as
  /// Google Play Store for Android and App Store for iOS.
  List<StoreOpenAppPageAction> get storeActions;

  /// Whether to automatically fall back to store links when the app is not installed.
  ///
  /// If true, the DeeplinkX will attempt to open the app's page in the appropriate
  /// store when the app is not installed on the device.
  bool get fallbackToStore;
}

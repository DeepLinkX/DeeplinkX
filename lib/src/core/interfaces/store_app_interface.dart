import 'package:deeplink_x/src/core/enums/enums.dart';
import 'package:deeplink_x/src/core/interfaces/interfaces.dart';

/// Represents an app store application.
///
/// This interface extends [App] to define the properties specific to
/// app store applications, such as Google Play Store, Apple App Store, etc.
/// It includes additional platform information to identify which platform
/// the store app belongs to.
abstract class StoreApp implements App {
  /// The platform type this store app is associated with.
  ///
  /// This indicates the platform (e.g., iOS, Android) that this store
  /// application serves.
  PlatformType get platform;
}

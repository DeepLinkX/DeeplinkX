import 'package:deeplink_x/src/core/enums/platform_type.dart';

/// Represents a generic application that can be launched.
///
/// This interface defines the basic properties needed to identify and launch
/// an application across different platforms.
abstract class App {
  /// The Android package name for the application.
  ///
  /// This is used on Android devices to identify the application.
  /// For example: 'com.instagram.android'
  String? get androidPackageName;

  /// The custom URL scheme for the application.
  ///
  /// This is used for deep linking on platforms that support custom URL schemes.
  /// For example: 'instagram'
  String? get customScheme;

  /// The MacOS bundle identifier for the application.
  ///
  /// This is used on MacOS devices to identify the application.
  /// For example: 'com.apple.AppStore'
  String? get macosBundleIdentifier;

  /// The platforms that the application supports.
  List<PlatformType> get supportedPlatforms;

  /// The web URL for the application.
  ///
  /// This is typically used as a fallback when the native app cannot be launched.
  Uri get website;
}

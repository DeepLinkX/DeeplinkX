import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/foundation.dart';

/// A utility class for platform-related operations.
///
/// This class provides methods to determine and work with the current platform
/// of the application.
class PlatformUtil {
  /// Creates a constant instance of [PlatformUtil].
  ///
  /// Since this class only contains static methods and has no instance state,
  /// it can be instantiated as a const object.
  PlatformUtil({final String? platfromName}) : _platformName = platfromName ?? defaultTargetPlatform.name;

  final String _platformName;

  /// Returns the current platform based on the default target platform of the app.
  ///
  /// This method converts the system's default target platform name to lowercase
  /// and maps it to the corresponding [PlatformType] value.
  ///
  /// Returns:
  ///   A [PlatformType] representing the current platform.
  PlatformType getCurrentPlatform() => PlatformType.fromOperatingSystem(_platformName.toLowerCase());
}

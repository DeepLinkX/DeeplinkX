import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/foundation.dart';

/// A utility class for platform-related operations.
///
/// This class provides methods to determine and work with the current platform
/// of the application.
class PlatformUtil {
  /// Creates a new instance of [PlatformUtil].
  ///
  /// [platformName] is an optional parameter that allows specifying a custom
  /// platform name. If not provided, the default target platform name is used.
  ///
  /// The [PlatformUtil] class is used to determine and work with the current
  /// platform of the application.
  PlatformUtil({final String? platformName}) : _platformName = platformName ?? defaultTargetPlatform.name;

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

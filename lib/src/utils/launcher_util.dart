import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x_platform_interface/deeplink_x_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A utility class for launching URLs and applications.
///
/// This class provides methods to launch URLs, intents, and check for app installations
/// on Android devices. It acts as a wrapper around the platform-specific implementations
/// provided by the `deeplink_x_platform_interface` package.
class LauncherUtil {
  /// Creates a new instance of [LauncherUtil].
  ///
  /// Takes a [PlatformType] parameter that specifies the current platform
  /// on which the application is running. This platform information is used
  /// to determine the appropriate launching behavior for URLs and applications.
  LauncherUtil(this.currentPlatform);

  /// The current platform type of the device.
  ///
  /// This field stores the platform type (e.g., Android, iOS) on which
  /// the application is running. It's used to determine platform-specific
  /// behaviors for URL and app launching operations.
  final PlatformType currentPlatform;

  /// Launches a URL using the platform-specific implementation.
  ///
  /// Returns a [Future<bool>] indicating whether the URL was successfully launched.
  Future<bool> launchUrl(final Uri uri) async => LauncherUtilPlatform.instance.launchUrl(uri);

  /// Launches an Android intent with the specified options.
  ///
  /// Takes an [AndroidIntentOption] object that contains the intent configuration.
  Future<bool> launchIntent(final AndroidIntentOption options) async {
    if (currentPlatform != PlatformType.android) {
      return false;
    }
    await LauncherUtilPlatform.instance.launchIntent(options);
    return true;
  }

  /// Launches an application using the provided [App] configuration.
  ///
  /// Takes an [App] object containing the application details such as
  /// Android package name and custom URL scheme.
  ///
  /// Returns a [Future<bool>] indicating whether the application was
  /// successfully launched. Returns `true` if the launch was successful,
  /// `false` otherwise.
  Future<bool> launchApp(final App app) async {
    try {
      if (currentPlatform == PlatformType.android && app.androidPackageName != null) {
        await launchAndroidApp(app.androidPackageName!);
      } else if (app.customScheme != null) {
        await launchExternalApp(app.customScheme!);
      }
      return true;
    } on PlatformException catch (_) {
      // TODO: Log
      return false;
    } on Exception catch (_) {
      // TODO: Log
      return false;
    }
  }

  /// Checks if an application is installed on the device.
  ///
  /// Takes an [App] object containing the application details such as
  /// Android package name and custom URL scheme.
  ///
  /// Returns a [Future<bool>] indicating whether the application is installed.
  /// Returns `true` if the application is installed, `false` otherwise.
  Future<bool> isAppInstalled(final App app) async {
    try {
      if (currentPlatform == PlatformType.android) {
        if (app.androidPackageName != null) {
          return await isAndroidAppInstalled(app.androidPackageName!);
        }
      } else {
        if (app.customScheme != null) {
          return await isExternalAppInstalled(app.customScheme!);
        }
      }
      return false;
    } on PlatformException catch (_) {
      // TODO: Log
      return false;
    } on Exception catch (_) {
      // TODO: Log
      return false;
    }
  }

  /// Launches an Android application specified by its package name.
  ///
  /// Takes a [String] representing the package name of the application to launch.
  @visibleForTesting
  Future<void> launchAndroidApp(final String packageName) async =>
      LauncherUtilPlatform.instance.launchAndroidApp(packageName);

  /// Launches an application using a custom URL scheme.
  ///
  /// Takes a [String] representing the custom scheme to launch.
  @visibleForTesting
  Future<void> launchExternalApp(final String scheme) async => LauncherUtilPlatform.instance.launchApp(scheme);

  /// Checks if an Android application is installed on the device.
  ///
  /// Takes a [String] representing the package name of the application.
  /// Returns a [Future<bool>] indicating whether the application is installed.
  @visibleForTesting
  Future<bool> isAndroidAppInstalled(final String packageName) async =>
      LauncherUtilPlatform.instance.isAndroidAppInstalled(packageName);

  /// Checks if an application is installed using a custom URL scheme.
  ///
  /// Takes a [String] representing the custom scheme.
  /// Returns a [Future<bool>] indicating whether the application is installed.
  @visibleForTesting
  Future<bool> isExternalAppInstalled(final String scheme) async =>
      LauncherUtilPlatform.instance.isAppInstalled(scheme);
}

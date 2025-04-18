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
        return await launchAppByPackageName(app.androidPackageName!);
      } else if (app.customScheme != null) {
        return await launchAppByScheme(app.customScheme!);
      }
      return false;
    } on PlatformException catch (_) {
      return false;
    } on Exception catch (_) {
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
    // if (!app.supportedPlatforms.contains(currentPlatform)) {
    //   return false;
    // }

    try {
      if (currentPlatform == PlatformType.android) {
        assert(app.androidPackageName != null, 'androidPackageName is required for android');
        return await isAppInstalledByPackageName(app.androidPackageName!);
      } else {
        if (currentPlatform == PlatformType.macos) {
          assert(app.macosBundleIdentifier != null, 'macosBundleIdentifier is required for macos');
          return await isAppInstalledByPackageName(app.macosBundleIdentifier!);
        } else if (app.customScheme != null) {
          return await isAppInstalledByScheme(app.customScheme!);
        }
      }
      return false;
    } on PlatformException catch (_) {
      return false;
    } on Exception catch (_) {
      return false;
    }
  }

  /// Launches an Android application specified by its package name.
  ///
  /// Takes a [String] representing the package name of the application to launch.
  ///
  /// Returns a [Future<bool>] indicating whether the application was successfully launched.
  @visibleForTesting
  Future<bool> launchAppByPackageName(final String packageName) async =>
      LauncherUtilPlatform.instance.launchAppByPackageName(packageName);

  /// Launches an application using a custom URL scheme.
  ///
  /// Takes a [String] representing the custom scheme to launch.
  ///
  /// Returns a [Future<bool>] indicating whether the application was successfully launched.
  @visibleForTesting
  Future<bool> launchAppByScheme(final String scheme) async => LauncherUtilPlatform.instance.launchAppByScheme(scheme);

  /// Checks if an application is installed on the device by its package name.
  ///
  /// Takes a [String] representing the package name of the application to check.
  ///
  /// Returns a [Future<bool>] indicating whether the application is installed.
  @visibleForTesting
  Future<bool> isAppInstalledByPackageName(final String packageName) async =>
      LauncherUtilPlatform.instance.isAppInstalledByPackageName(packageName);

  /// Checks if an application is installed on the device by its custom URL scheme.
  ///
  /// Takes a [String] representing the custom scheme to check.
  ///
  /// Returns a [Future<bool>] indicating whether the application is installed.
  @visibleForTesting
  Future<bool> isAppInstalledByScheme(final String scheme) async =>
      LauncherUtilPlatform.instance.isAppInstalledByScheme(scheme);
}

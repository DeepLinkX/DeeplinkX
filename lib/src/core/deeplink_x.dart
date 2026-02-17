import 'package:deeplink_x/src/core/core.dart';
import 'package:deeplink_x/src/utils/launcher_util.dart';
import 'package:deeplink_x/src/utils/platform_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A class to handle deeplink actions across different platforms
class DeeplinkX {
  /// Creates a new [DeeplinkX] instance.
  ///
  /// Parameters:
  /// - [launcherUtil]: Optional custom launcher utility for URL handling. If not provided, uses default [LauncherUtil].
  DeeplinkX({
    @visibleForTesting final LauncherUtil? launcherUtil,
    @visibleForTesting final PlatformType? platformType,
  }) {
    currentPlatform = platformType ?? PlatformUtil().getCurrentPlatform();
    _launcherUtil = launcherUtil ?? LauncherUtil(currentPlatform);
  }

  late LauncherUtil _launcherUtil;

  /// The current platform type where the code is running.
  /// This is initialized in the constructor and used throughout
  /// the class to determine platform-specific behavior.
  late PlatformType currentPlatform;

  /// Launches a deeplink action.
  ///
  /// Takes an [action] parameter of type [AppAction] and attempts to launch
  /// one of its associated URIs on the current platform.
  ///
  /// Returns a [Future<bool>] that completes with:
  /// * `true` if the action was successfully launched
  /// * `false` if the action could not be launched or no URIs were available
  Future<bool> launchAction(
    final AppAction action, {
    final bool disableFallback = false,
  }) async {
    try {
      final bool isAppInstalled = await this.isAppInstalled(action);
      if (isAppInstalled) {
        if (action is IntentAppLinkAction) {
          final isLaunched = await _launcherUtil.launchIntent(action.androidIntentOptions);
          if (isLaunched) {
            return true;
          }

          if (action.appLink != null) {
            final isLaunched = await _launcherUtil.launchUrl(action.appLink!);
            if (isLaunched) {
              return true;
            }
          }
        }

        if (action is AppLinkAppAction) {
          final isLaunched = await _launcherUtil.launchUrl(action.appLink);
          if (isLaunched) {
            return true;
          }
        }

        if (action is UniversalLinkAppAction) {
          final isLaunched = await _launcherUtil.launchUrl(action.universalLink);
          if (isLaunched) {
            return true;
          }
        }
      }
    } on PlatformException catch (_) {
    } on Exception catch (_) {
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {}

    // Primary link failed, so we try fallback
    if (disableFallback) {
      return false;
    }

    if (action is DownloadableApp) {
      final downloadableApp = action as DownloadableApp;
      if (downloadableApp.fallbackToStore) {
        final isRedirected = await redirectToStore(storeActions: downloadableApp.storeActions);

        if (isRedirected) {
          return true;
        }
      }
    }

    if (action is Fallbackable) {
      final fallbackableAction = action as Fallbackable;
      return _launcherUtil.launchUrl(fallbackableAction.fallbackLink);
    }

    return false;
  }

  /// Checks if a specific app is installed on the device.
  ///
  /// Parameters:
  /// - [app]: The app to check for installation.
  ///
  /// Returns a [Future<bool>] that completes with:
  /// * `true` if the app is installed
  /// * `false` if the app is not installed
  Future<bool> isAppInstalled(final App app) async => _launcherUtil.isAppInstalled(app);

  /// Launches an app on the device.
  ///
  /// This method attempts to launch the specified app and, if unsuccessful and fallback
  /// is not disabled, will try to open the app's store page or website.
  ///
  /// Parameters:
  /// - [app]: The app to launch.
  /// - [disableFallback]: Optional flag to disable fallback to store or website. Default is false.
  ///
  /// Returns a [Future<bool>] that completes with:
  /// * `true` if the app was successfully launched or a fallback was used
  /// * `false` if the app could not be launched and no fallback was available or successful
  Future<bool> launchApp(
    final App app, {
    final bool disableFallback = false,
  }) async {
    final isAppInstalled = await this.isAppInstalled(app);
    if (isAppInstalled) {
      final isLaunched = await _launcherUtil.launchApp(app);
      if (isLaunched) {
        return true;
      }
    }

    if (disableFallback) {
      return false;
    }

    if (app is DownloadableApp) {
      if (app.fallbackToStore) {
        final isRedirected = await redirectToStore(storeActions: app.storeActions);

        if (isRedirected) {
          return true;
        }
      }
    }

    return _launcherUtil.launchUrl(app.website);
  }

  /// Redirects the user to the appropriate app store based on the current platform.
  ///
  /// This method is particularly useful when your app has a new update and you want
  /// to navigate users to the relevant app store to update the application.
  ///
  /// The method attempts to launch each store action that matches the current platform
  /// in the order they are provided. It stops and returns `true` as soon as one
  /// store is successfully launched.
  ///
  /// Parameters:
  /// - [storeActions]: A list of store actions to try launching.
  ///
  /// Returns a [Future<bool>] that completes with:
  /// * `true` if any store was successfully launched
  /// * `false` if no store could be launched or no store actions were provided for the current platform
  ///
  /// Example:
  /// ```dart
  /// final deeplinkX = DeeplinkX();
  ///
  /// // Redirect to Instagram's store page on the appropriate platform
  /// await deeplinkX.redirectToStore(
  ///   storeActions: [
  ///     IOSAppStore.openAppPage(appId: '389801252', appName: 'instagram'),  // iOS App Store
  ///     PlayStore.openAppPage(packageName: 'com.instagram.android'),  // Google Play Store
  ///     HuaweiAppGalleryStore.openAppPage(appId: 'C101162369'),  // Huawei AppGallery
  ///   ],
  /// );
  /// ```
  Future<bool> redirectToStore({
    required final List<StoreOpenAppPageAction> storeActions,
  }) async {
    final stores = storeActions.where((final store) => store.platform == currentPlatform).toList();
    for (final store in stores) {
      final isLaunched = await launchAction(store, disableFallback: true);
      if (isLaunched) {
        return true;
      }
    }

    return false;
  }
}

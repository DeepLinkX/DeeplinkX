import 'dart:io';

import 'package:deeplink_x/src/core/app_actions/app_action.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';
import 'package:deeplink_x/src/utils/launcher_util.dart';

/// A class to handle deeplink actions across different platforms
class DeeplinkX {
  /// Creates a new [DeeplinkX] instance.
  ///
  /// Parameters:
  /// - [launcherUtil]: Optional custom launcher utility for URL handling. If not provided, uses default [LauncherUtil].
  /// - [platformType]: Optional platform type override. If not provided, automatically detects from current operating system.
  DeeplinkX({
    final LauncherUtil? launcherUtil,
    final PlatformEnum? platformType,
  })  : _launcherUtil = launcherUtil ?? const LauncherUtil(),
        _playformType = platformType ?? PlatformEnum.fromOperatingSystem(Platform.operatingSystem);

  final LauncherUtil _launcherUtil;

  final PlatformEnum _playformType;

  /// Launches a deeplink action.
  ///
  /// Takes an [action] parameter of type [AppAction] and attempts to launch
  /// one of its associated URIs on the current platform.
  ///
  /// Returns a [Future<bool>] that completes with:
  /// * `true` if the action was successfully launched
  /// * `false` if the action could not be launched or no URIs were available
  Future<bool> launchAction(final AppAction action) async {
    final uris = await action.getUris(_playformType);
    if (uris.isEmpty) {
      return false;
    }

    // Try each URI in sequence
    for (final uri in uris) {
      if (await _launcherUtil.canLaunchUrl(uri)) {
        return _launcherUtil.launchUrl(uri);
      }
    }
    return false;
  }

  /// Checks if a deeplink action can be launched on the current platform.
  ///
  /// Takes an [action] parameter of type [AppAction] and checks if any of its
  /// associated URIs can be launched on the current platform.
  ///
  /// Returns a [Future<bool>] that completes with:
  /// * `true` if at least one of the URIs can be launched
  /// * `false` if none of the URIs can be launched or if no URIs are available
  ///
  /// Example:
  /// ```dart
  /// final deeplinkX = DeeplinkX();
  ///
  /// // Check if Instagram app can be opened
  /// final canOpenInstagram = await deeplinkX.canLaunch(Instagram.open);
  ///
  /// // Check if specific profile can be opened
  /// final canOpenProfile = await deeplinkX.canLaunch(
  ///   Instagram.openProfile('username')
  /// );
  /// ```
  Future<bool> canLaunch(final AppAction action) async {
    final uris = await action.getUris(_playformType);
    if (uris.isEmpty) {
      return false;
    }

    // Try each URI in sequence
    for (final uri in uris) {
      if (await _launcherUtil.canLaunchUrl(uri)) {
        return true;
      }
    }
    return false;
  }
}

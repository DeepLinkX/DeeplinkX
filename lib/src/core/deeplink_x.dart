import '../utils/launcher_util.dart';
import 'app_action.dart';

/// A class to handle deeplink actions across different platforms
class DeeplinkX {
  final LauncherUtil _launcherUtil;

  const DeeplinkX({LauncherUtil launcherUtil = const LauncherUtil()})
      : _launcherUtil = launcherUtil;

  /// Launches a deeplink action
  Future<bool> launchAction(AppAction action) async {
    final uris = await action.getUris();
    if (uris.isEmpty) return false;

    // Try each URI in sequence
    for (final uri in uris) {
      if (await _launcherUtil.canLaunchUrl(uri)) {
        return await _launcherUtil.launchUrl(uri);
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
  Future<bool> canLaunch(AppAction action) async {
    final uris = await action.getUris();
    if (uris.isEmpty) return false;

    // Try each URI in sequence
    for (final uri in uris) {
      if (await _launcherUtil.canLaunchUrl(uri)) {
        return true;
      }
    }
    return false;
  }
}

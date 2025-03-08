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

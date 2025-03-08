import 'package:url_launcher/url_launcher.dart' as url_launcher;

class LauncherUtil {
  const LauncherUtil();

  Future<bool> launchUrl(Uri uri) async {
    return await url_launcher.launchUrl(uri);
  }

  Future<bool> canLaunchUrl(Uri uri) async {
    return await url_launcher.canLaunchUrl(uri);
  }
}

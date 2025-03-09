import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// A utility class for launching URLs and checking if they can be launched.
///
/// This class wraps the [url_launcher] package to provide a simplified interface
/// for launching URLs and checking their availability. It's used internally by
/// the DeeplinkX plugin to handle URL launching across different platforms.
///
/// The class provides two main methods:
/// - [launchUrl]: Attempts to launch a given URI
/// - [canLaunchUrl]: Checks if a given URI can be launched
class LauncherUtil {
  /// Creates a new [LauncherUtil] instance.
  const LauncherUtil();

  /// Attempts to launch the given [uri].
  ///
  /// Returns `true` if the URL was launched successfully, `false` otherwise.
  ///
  /// This method uses the platform's default handler for the URI scheme.
  /// For example:
  /// - `http://` and `https://` URLs will open in the default browser
  /// - Custom schemes like `instagram://` will open in the corresponding app
  Future<bool> launchUrl(Uri uri) async {
    return await url_launcher.launchUrl(uri);
  }

  /// Checks if the given [uri] can be launched on the current platform.
  ///
  /// Returns `true` if the URI can be handled by the platform, `false` otherwise.
  ///
  /// This is useful for checking if a specific app or URL scheme is supported
  /// before attempting to launch it.
  Future<bool> canLaunchUrl(Uri uri) async {
    return await url_launcher.canLaunchUrl(uri);
  }
}

import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';

/// Base class for all app actions.
///
/// This abstract class defines the common interface for all app-specific actions.
/// Each app (e.g., Instagram, LinkedIn) will have its own implementation
/// that defines how to generate the appropriate URIs for each action.
abstract class AppAction {
  /// Creates a new app action with the specified type and optional parameters.
  const AppAction({
    required this.actionType,
    this.parameters,
  });

  /// The type of action to perform.
  ///
  /// This is typically an enum value that implements [ActionTypeEnum]
  /// and defines the specific action to be taken (e.g., open app, view profile).
  final ActionTypeEnum actionType;

  /// Optional parameters required for the action.
  ///
  /// For example, when opening a specific profile, this might contain
  /// the username or profile ID.
  final Map<String, String>? parameters;

  /// Get the native URI for the action.
  ///
  /// Returns the native app URI (e.g., instagram://) that can be used to open the app
  /// or perform a specific action within the app.
  Future<Uri> getNativeUri();

  /// Get the fallback URI for the action.
  ///
  /// Returns the web fallback URL (e.g., https://instagram.com) that can be used when
  /// the native app is not installed or cannot be launched.
  Future<Uri> getFallbackUri();

  /// Get all possible URIs for the action.
  ///
  /// Returns a list of URIs in order of preference for the specified platform. The first URI that can be
  /// launched will be used. This typically includes both native app URIs
  /// (e.g., instagram://) and web fallback URLs (e.g., https://instagram.com).
  ///
  /// The [platform] parameter determines the target platform (iOS, Android, etc.) which may affect
  /// the URI scheme and format.
  ///
  /// By default, this method returns a list containing the native URI followed by
  /// the fallback URI. Override this method if you need custom URI ordering or
  /// platform-specific URI handling.
  Future<List<Uri>> getUris(final PlatformType platform) async {
    final List<Uri> uris = [await getNativeUri(), await getFallbackUri()];
    return uris;
  }
}

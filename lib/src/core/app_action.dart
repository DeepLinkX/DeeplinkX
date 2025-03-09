import 'package:deeplink_x/src/core/enums/action_type_enum.dart';

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

  /// Get all possible URIs for the action.
  ///
  /// Returns a list of URIs in order of preference. The first URI that can be
  /// launched will be used. This typically includes both native app URIs
  /// (e.g., instagram://) and web fallback URLs (e.g., https://instagram.com).
  Future<List<Uri>> getUris();
}

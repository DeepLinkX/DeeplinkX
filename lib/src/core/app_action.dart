import 'enums/action_type_enum.dart';

/// Base class for all app actions
abstract class AppAction {
  final ActionTypeEnum actionType;

  final Map<String, String>? parameters;

  const AppAction({
    required this.actionType,
    this.parameters,
  });

  /// Get all possible URIs for the action
  Future<List<Uri>> getUris();
}

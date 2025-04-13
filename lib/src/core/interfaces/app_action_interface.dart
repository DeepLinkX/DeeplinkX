import 'package:deeplink_x/src/core/interfaces/interfaces.dart';

/// Represents an action that can be performed on an application.
///
/// This interface extends [App] to provide the foundation for specific actions
/// that can be performed on applications, such as opening a profile, sharing content,
/// or performing other app-specific operations.
abstract class AppAction extends App {}

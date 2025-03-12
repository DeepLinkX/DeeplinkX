/// Base enum interface for all app-specific action types.
///
/// This interface is implemented by app-specific enums to define
/// the possible actions that can be performed for each app.
/// For example, the Instagram action type implements this interface
/// to define actions like opening the app or viewing a profile.
///
/// Each app should create its own enum that implements this interface
/// to define its supported actions. This allows for type-safe action
/// handling while maintaining flexibility for different apps.
///
/// Example:
/// ```dart
/// enum InstagramActionType implements ActionTypeEnum {
///   open,
///   openProfile,
/// }
/// ```
abstract class ActionTypeEnum {}

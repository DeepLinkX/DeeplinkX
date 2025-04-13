/// Represents an entity that provides a fallback URL.
///
/// This interface is used by actions that can provide a web fallback
/// when a native app action cannot be performed.
abstract class Fallbackable {
  /// The fallback web URL to use when the primary action cannot be performed.
  ///
  /// This is typically a web URL that provides similar functionality to the
  /// native app action.
  Uri get fallbackLink;
}

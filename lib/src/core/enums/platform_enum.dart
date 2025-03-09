/// Represents the different platforms supported by the DeeplinkX plugin.
///
/// This enum is used to identify the current platform and handle platform-specific
/// behavior for deeplinks. Each value corresponds to a supported platform with its
/// string representation.
///
/// The enum provides a [fromOperatingSystem] factory method to create a [PlatformEnum]
/// instance from a platform string. If the platform is not recognized, it defaults to web.
enum PlatformEnum {
  /// Web platform - used for browser-based applications
  web('web'),

  /// iOS platform - used for iPhone and iPad applications
  ios('ios'),

  /// Android platform - used for Android applications
  android('android'),
  // fuchsia('fuchsia'), // not supported yet, use web instead

  /// Windows platform - used for Windows desktop applications
  windows('windows'),

  /// macOS platform - used for macOS desktop applications
  macos('macos'),

  /// Linux platform - used for Linux desktop applications
  linux('linux');

  /// The string representation of the platform
  final String value;

  /// Creates a new [PlatformEnum] instance with the specified [value]
  const PlatformEnum(this.value);

  /// Creates a [PlatformEnum] from an operating system string.
  ///
  /// If the operating system is not recognized, returns [PlatformEnum.web].
  ///
  /// Example:
  /// ```dart
  /// final platform = PlatformEnum.fromOperatingSystem('ios'); // Returns PlatformEnum.ios
  /// final unknown = PlatformEnum.fromOperatingSystem('unknown'); // Returns PlatformEnum.web
  /// ```
  static PlatformEnum fromOperatingSystem(String os) {
    return PlatformEnum.values.firstWhere(
      (e) => e.value == os,
      orElse: () => PlatformEnum.web,
    );
  }
}

enum PlatformEnum {
  web('web'),
  ios('ios'),
  android('android'),
  // fuchsia('fuchsia'), // not supported yet, use web instead
  windows('windows'),
  macos('macos'),
  linux('linux');

  final String value;
  const PlatformEnum(this.value);

  static PlatformEnum fromOperatingSystem(String os) {
    return PlatformEnum.values.firstWhere(
      (e) => e.value == os,
      orElse: () => PlatformEnum.web,
    );
  }
}

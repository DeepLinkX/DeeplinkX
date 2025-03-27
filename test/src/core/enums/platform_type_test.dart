import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromOperatingSystem returns correct platform', () {
    expect(PlatformType.fromOperatingSystem('ios'), PlatformType.ios);
    expect(PlatformType.fromOperatingSystem('android'), PlatformType.android);
    expect(PlatformType.fromOperatingSystem('fuchsia'), PlatformType.web);
    expect(PlatformType.fromOperatingSystem('windows'), PlatformType.windows);
    expect(PlatformType.fromOperatingSystem('macos'), PlatformType.macos);
    expect(PlatformType.fromOperatingSystem('linux'), PlatformType.linux);
    expect(PlatformType.fromOperatingSystem('unknown'), PlatformType.web);
  });
}

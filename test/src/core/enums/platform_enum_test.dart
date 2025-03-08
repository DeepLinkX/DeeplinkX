import 'package:deeplink_x/src/core/enums/platform_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromOperatingSystem returns correct platform', () {
    expect(PlatformEnum.fromOperatingSystem('ios'), PlatformEnum.ios);
    expect(PlatformEnum.fromOperatingSystem('android'), PlatformEnum.android);
    expect(PlatformEnum.fromOperatingSystem('fuchsia'), PlatformEnum.web);
    expect(PlatformEnum.fromOperatingSystem('windows'), PlatformEnum.windows);
    expect(PlatformEnum.fromOperatingSystem('macos'), PlatformEnum.macos);
    expect(PlatformEnum.fromOperatingSystem('linux'), PlatformEnum.linux);
    expect(PlatformEnum.fromOperatingSystem('unknown'), PlatformEnum.web);
  });
}

import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/utils/platform_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlatformUtil', () {
    test('getCurrentPlatform returns PlatformType.android for android platform', () {
      final platformUtil = PlatformUtil(platfromName: 'android');
      expect(platformUtil.getCurrentPlatform(), equals(PlatformType.android));
    });

    test('getCurrentPlatform returns PlatformType.ios for iOS platform', () {
      final platformUtil = PlatformUtil(platfromName: 'iOS');
      expect(platformUtil.getCurrentPlatform(), equals(PlatformType.ios));
    });

    test('getCurrentPlatform returns PlatformType.linux for linux platform', () {
      final platformUtil = PlatformUtil(platfromName: 'linux');
      expect(platformUtil.getCurrentPlatform(), equals(PlatformType.linux));
    });

    test('getCurrentPlatform returns PlatformType.macos for macOS platform', () {
      final platformUtil = PlatformUtil(platfromName: 'macOS');
      expect(platformUtil.getCurrentPlatform(), equals(PlatformType.macos));
    });

    test('getCurrentPlatform returns PlatformType.windows for windows platform', () {
      final platformUtil = PlatformUtil(platfromName: 'windows');
      expect(platformUtil.getCurrentPlatform(), equals(PlatformType.windows));
    });

    test('getCurrentPlatform returns PlatformType.web for fuchsia platform', () {
      final platformUtil = PlatformUtil(platfromName: 'fuchsia');
      expect(platformUtil.getCurrentPlatform(), equals(PlatformType.web));
    });

    test('getCurrentPlatform returns PlatformType.web for unknown platform', () {
      final platformUtil = PlatformUtil(platfromName: 'unknown_platform');
      expect(platformUtil.getCurrentPlatform(), equals(PlatformType.web));
    });

    test('PlatformUtil defaults to defaultTargetPlatform when no platform name provided', () {
      final platformUtil = PlatformUtil();

      // Since we're running in a test environment, the platform type will depend on the test runner.
      // We just verify that no exception is thrown and a PlatformType is returned.
      expect(platformUtil.getCurrentPlatform(), isA<PlatformType>());
    });
  });
}

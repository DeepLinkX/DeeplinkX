import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/utils/launcher_util.dart';
import 'package:deeplink_x_platform_interface/deeplink_x_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLauncherUtilPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements LauncherUtilPlatform {}

class MockApp extends Mock implements App {}

void main() {
  late MockLauncherUtilPlatform platform;

  setUp(() {
    platform = MockLauncherUtilPlatform();
    LauncherUtilPlatform.instance = platform;
  });

  setUpAll(() {
    registerFallbackValue(const AndroidIntentOption(action: 'test'));
  });

  group('launchUrl', () {
    test('returns true when platform returns true', () async {
      final uri = Uri.parse('https://example.com');
      when(() => platform.launchUrl(uri)).thenAnswer((final _) async => true);

      final util = LauncherUtil(PlatformType.android);
      final result = await util.launchUrl(uri);

      expect(result, true);
      verify(() => platform.launchUrl(uri)).called(1);
    });

    test('returns false when platform returns false', () async {
      final uri = Uri.parse('https://example.com');
      when(() => platform.launchUrl(uri)).thenAnswer((final _) async => false);

      final util = LauncherUtil(PlatformType.android);
      final result = await util.launchUrl(uri);

      expect(result, false);
      verify(() => platform.launchUrl(uri)).called(1);
    });

    test('throws when platform throws', () {
      final uri = Uri.parse('https://example.com');
      when(() => platform.launchUrl(uri))
          .thenThrow(PlatformException(code: 'error'));

      final util = LauncherUtil(PlatformType.android);

      expect(() => util.launchUrl(uri), throwsA(isA<PlatformException>()));
    });
  });

  group('launchIntent', () {
    const options = AndroidIntentOption(action: 'action');

    test('calls platform on Android and returns true', () async {
      when(() => platform.launchIntent(options)).thenAnswer((final _) async {});

      final util = LauncherUtil(PlatformType.android);
      final result = await util.launchIntent(options);

      expect(result, true);
      verify(() => platform.launchIntent(options)).called(1);
    });

    test('returns false on non-Android platform', () async {
      for (final platformType in [
        PlatformType.ios,
        PlatformType.macos,
        PlatformType.web,
        PlatformType.windows,
        PlatformType.linux,
      ]) {
        final util = LauncherUtil(platformType);
        final result = await util.launchIntent(options);

        expect(result, false);
        verifyNever(() => platform.launchIntent(any()));
      }
    });

    test('throws when platform throws on Android', () {
      when(() => platform.launchIntent(options))
          .thenThrow(PlatformException(code: 'error'));

      final util = LauncherUtil(PlatformType.android);

      expect(
        () => util.launchIntent(options),
        throwsA(isA<PlatformException>()),
      );
    });
  });

  group('isAppInstalled', () {
    test('uses package name check on Android', () async {
      final app = MockApp();
      when(() => app.supportedPlatforms).thenReturn([PlatformType.android]);
      when(() => app.androidPackageName).thenReturn('com.example');
      when(() => app.customScheme).thenReturn(null);
      when(() => app.macosBundleIdentifier).thenReturn(null);
      when(() => app.website).thenReturn(Uri.parse('https://example.com'));
      when(() => platform.isAppInstalledByPackageName('com.example'))
          .thenAnswer((final _) async => true);

      final util = LauncherUtil(PlatformType.android);
      final result = await util.isAppInstalled(app);

      expect(result, true);
      verify(() => platform.isAppInstalledByPackageName('com.example'))
          .called(1);
    });

    test('uses scheme check on other platforms', () async {
      final app = MockApp();
      when(() => app.supportedPlatforms).thenReturn([
        PlatformType.ios,
        PlatformType.web,
        PlatformType.windows,
        PlatformType.linux,
      ]);
      when(() => app.customScheme).thenReturn('scheme');
      when(() => app.androidPackageName).thenReturn(null);
      when(() => app.macosBundleIdentifier).thenReturn(null);
      when(() => app.website).thenReturn(Uri.parse('https://example.com'));
      when(() => platform.isAppInstalledByScheme('scheme'))
          .thenAnswer((final _) async => false);

      for (final platformType in [
        PlatformType.ios,
        PlatformType.web,
        PlatformType.windows,
        PlatformType.linux,
      ]) {
        final util = LauncherUtil(platformType);
        final result = await util.isAppInstalled(app);

        expect(result, false);
        verify(() => platform.isAppInstalledByScheme('scheme')).called(1);
      }
    });

    test('uses bundle identifier check on macOS', () async {
      final app = MockApp();
      when(() => app.supportedPlatforms).thenReturn([PlatformType.macos]);
      when(() => app.macosBundleIdentifier).thenReturn('com.macos');
      when(() => app.androidPackageName).thenReturn(null);
      when(() => app.customScheme).thenReturn(null);
      when(() => app.website).thenReturn(Uri.parse('https://example.com'));
      when(() => platform.isAppInstalledByPackageName('com.macos'))
          .thenAnswer((final _) async => true);

      final util = LauncherUtil(PlatformType.macos);
      final result = await util.isAppInstalled(app);

      expect(result, true);
      verify(() => platform.isAppInstalledByPackageName('com.macos')).called(1);
    });

    test('returns false when platform not supported', () async {
      final app = MockApp();
      when(() => app.supportedPlatforms).thenReturn([PlatformType.android]);
      when(() => app.androidPackageName).thenReturn('com.example');
      when(() => app.customScheme).thenReturn(null);
      when(() => app.macosBundleIdentifier).thenReturn(null);
      when(() => app.website).thenReturn(Uri.parse('https://example.com'));

      final util = LauncherUtil(PlatformType.ios);
      final result = await util.isAppInstalled(app);

      expect(result, false);
      verifyNever(() => platform.isAppInstalledByPackageName(any()));
    });

    test('returns false when platform call throws', () async {
      final app = MockApp();
      when(() => app.supportedPlatforms).thenReturn([PlatformType.android]);
      when(() => app.androidPackageName).thenReturn('com.example');
      when(() => app.customScheme).thenReturn(null);
      when(() => app.macosBundleIdentifier).thenReturn(null);
      when(() => app.website).thenReturn(Uri.parse('https://example.com'));
      when(() => platform.isAppInstalledByPackageName('com.example'))
          .thenThrow(PlatformException(code: 'error'));

      final util = LauncherUtil(PlatformType.android);
      final result = await util.isAppInstalled(app);

      expect(result, false);
    });

    test('asserts when required package name is missing on Android', () {
      final app = MockApp();
      when(() => app.supportedPlatforms).thenReturn([PlatformType.android]);
      when(() => app.androidPackageName).thenReturn(null);
      when(() => app.customScheme).thenReturn(null);
      when(() => app.macosBundleIdentifier).thenReturn(null);
      when(() => app.website).thenReturn(Uri.parse('https://example.com'));

      final util = LauncherUtil(PlatformType.android);

      expect(() => util.isAppInstalled(app), throwsA(isA<AssertionError>()));
    });

    test('asserts when bundle identifier is missing on macOS', () {
      final app = MockApp();
      when(() => app.supportedPlatforms).thenReturn([PlatformType.macos]);
      when(() => app.macosBundleIdentifier).thenReturn(null);
      when(() => app.androidPackageName).thenReturn(null);
      when(() => app.customScheme).thenReturn(null);
      when(() => app.website).thenReturn(Uri.parse('https://example.com'));

      final util = LauncherUtil(PlatformType.macos);

      expect(() => util.isAppInstalled(app), throwsA(isA<AssertionError>()));
    });
  });

  group('launchApp', () {
    test('launches via package name on Android', () async {
      final app = MockApp();
      when(() => app.androidPackageName).thenReturn('com.example');
      when(() => app.customScheme).thenReturn(null);

      final util = LauncherUtil(PlatformType.android);
      when(() => platform.launchAppByPackageName('com.example'))
          .thenAnswer((final _) async => true);

      final result = await util.launchApp(app);

      expect(result, true);
      verify(() => platform.launchAppByPackageName('com.example')).called(1);
    });

    test('launches via scheme on other platforms', () async {
      final app = MockApp();
      when(() => app.customScheme).thenReturn('scheme');
      when(() => app.androidPackageName).thenReturn(null);

      for (final platformType in [
        PlatformType.ios,
        PlatformType.macos,
        PlatformType.web,
        PlatformType.windows,
        PlatformType.linux,
      ]) {
        final util = LauncherUtil(platformType);
        when(() => platform.launchAppByScheme('scheme'))
            .thenAnswer((final _) async => true);

        final result = await util.launchApp(app);

        expect(result, true);
        verify(() => platform.launchAppByScheme('scheme')).called(1);
      }
    });

    test('returns false when platform call throws platform exception',
        () async {
      final app = MockApp();
      when(() => app.androidPackageName).thenReturn('com.example');
      when(() => app.customScheme).thenReturn(null);
      when(() => platform.launchAppByPackageName('com.example'))
          .thenThrow(PlatformException(code: 'error'));

      final util = LauncherUtil(PlatformType.android);
      final result = await util.launchApp(app);

      expect(result, false);

      verify(() => platform.launchAppByPackageName('com.example')).called(1);
      verifyNever(() => platform.launchAppByScheme(any()));
    });

    test('returns false when platform call throws exception', () async {
      final app = MockApp();
      when(() => app.androidPackageName).thenReturn('com.example');
      when(() => app.customScheme).thenReturn(null);
      when(() => platform.launchAppByPackageName('com.example'))
          .thenThrow(UnimplementedError('error'));

      final util = LauncherUtil(PlatformType.android);
      final result = await util.launchApp(app);

      expect(result, false);
    });
  });

  group('launchAppByPackageName', () {
    test('delegates to platform', () async {
      when(() => platform.launchAppByPackageName('pkg'))
          .thenAnswer((final _) async => true);

      final util = LauncherUtil(PlatformType.android);
      final result = await util.launchAppByPackageName('pkg');

      expect(result, true);
      verify(() => platform.launchAppByPackageName('pkg')).called(1);
    });
  });

  group('launchAppByScheme', () {
    test('delegates to platform', () async {
      when(() => platform.launchAppByScheme('scheme'))
          .thenAnswer((final _) async => true);

      final util = LauncherUtil(PlatformType.android);
      final result = await util.launchAppByScheme('scheme');

      expect(result, true);
      verify(() => platform.launchAppByScheme('scheme')).called(1);
    });
  });
}

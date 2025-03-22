import 'package:deeplink_x/src/core/app_actions/app_action.dart';
import 'package:deeplink_x/src/core/deeplink_x.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';
import 'package:deeplink_x/src/utils/launcher_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLauncherUtil extends Mock implements LauncherUtil {}

class MockAppAction extends Mock implements AppAction {}

void main() {
  late DeeplinkX deeplinkX;
  late MockAppAction mockAppAction;
  late MockLauncherUtil mockLauncherUtil;
  final List<Uri> dummyUris = [
    Uri.parse('test://test'),
    Uri.parse('https://test.com'),
    Uri.parse('https://test.com/test'),
    Uri.parse('https://www.test.com'),
  ];

  setUp(() {
    mockAppAction = MockAppAction();
    mockLauncherUtil = MockLauncherUtil();
    deeplinkX = DeeplinkX(launcherUtil: mockLauncherUtil, platformType: PlatformEnum.android);

    when(() => mockLauncherUtil.canLaunchUrl(any())).thenAnswer((final _) async => true);
    when(() => mockLauncherUtil.launchUrl(any())).thenAnswer((final _) async => true);
    when(() => mockAppAction.getUris(any())).thenAnswer((final _) async => dummyUris);
  });

  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(PlatformEnum.android);
  });

  test('launchAction returns false when no URIs are available', () async {
    // Arrange
    when(() => mockAppAction.getUris(any())).thenAnswer((final _) async => []);

    // Act
    final result = await deeplinkX.launchAction(mockAppAction);

    // Assert
    expect(result, false);
    verifyNever(() => mockLauncherUtil.launchUrl(any()));
    verifyNever(() => mockLauncherUtil.canLaunchUrl(any()));
  });

  test('canLaunch returns false when no URIs are available', () async {
    // Arrange
    when(() => mockAppAction.getUris(any())).thenAnswer((final _) async => []);

    // Act
    final result = await deeplinkX.canLaunch(mockAppAction);

    // Assert
    expect(result, false);
    verifyNever(() => mockLauncherUtil.launchUrl(any()));
    verifyNever(() => mockLauncherUtil.canLaunchUrl(any()));
  });

  test('launchAction tries each URI until one succeeds', () async {
    // uri[0] => false
    // uri[1] => false
    // uri[2] => true
    // uri[3] => true

    // Arrange
    when(() => mockLauncherUtil.canLaunchUrl(dummyUris[0])).thenAnswer((final _) async => false);
    when(() => mockLauncherUtil.canLaunchUrl(dummyUris[1])).thenAnswer((final _) async => false);

    // Act
    final result = await deeplinkX.launchAction(mockAppAction);

    // Assert
    expect(result, true);
    verify(() => mockLauncherUtil.canLaunchUrl(dummyUris[0])).called(1);
    verify(() => mockLauncherUtil.canLaunchUrl(dummyUris[1])).called(1);
    verify(() => mockLauncherUtil.canLaunchUrl(dummyUris[2])).called(1);
    verifyNever(() => mockLauncherUtil.canLaunchUrl(dummyUris[3]));

    verifyNever(() => mockLauncherUtil.launchUrl(dummyUris[0]));
    verifyNever(() => mockLauncherUtil.launchUrl(dummyUris[1]));

    verify(() => mockLauncherUtil.launchUrl(dummyUris[2])).called(1);

    verifyNever(() => mockLauncherUtil.launchUrl(dummyUris[3]));
  });

  test('canLaunch tries each URI until one succeeds', () async {
    // uri[0] => false
    // uri[1] => false
    // uri[2] => true
    // uri[3] => true

    // Arrange
    when(() => mockLauncherUtil.canLaunchUrl(dummyUris[0])).thenAnswer((final _) async => false);
    when(() => mockLauncherUtil.canLaunchUrl(dummyUris[1])).thenAnswer((final _) async => false);

    // Act
    final result = await deeplinkX.canLaunch(mockAppAction);

    // Assert
    expect(result, true);
    verify(() => mockLauncherUtil.canLaunchUrl(dummyUris[0])).called(1);
    verify(() => mockLauncherUtil.canLaunchUrl(dummyUris[1])).called(1);
    verify(() => mockLauncherUtil.canLaunchUrl(dummyUris[2])).called(1);
    verifyNever(() => mockLauncherUtil.canLaunchUrl(dummyUris[3]));
  });

  test('launchAction returns false when no URI can be launched', () async {
    // Arrange
    when(() => mockLauncherUtil.canLaunchUrl(any())).thenAnswer((final _) async => false);

    // Act
    final result = await deeplinkX.launchAction(mockAppAction);

    // Assert
    expect(result, false);
    verifyNever(() => mockLauncherUtil.launchUrl(any()));
    verify(() => mockLauncherUtil.canLaunchUrl(any())).called(dummyUris.length);
  });

  test('canLaunch returns false when no URI can be launched', () async {
    // Arrange
    when(() => mockLauncherUtil.canLaunchUrl(any())).thenAnswer((final _) async => false);

    // Act
    final result = await deeplinkX.canLaunch(mockAppAction);

    // Assert
    expect(result, false);
    verify(() => mockLauncherUtil.canLaunchUrl(any())).called(dummyUris.length);
  });

  // TODO: Add PlatformType tests
}

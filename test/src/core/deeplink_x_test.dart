import 'package:deeplink_x/src/core/app_action.dart';
import 'package:deeplink_x/src/core/deeplink_x.dart';
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
    deeplinkX = DeeplinkX(launcherUtil: mockLauncherUtil);

    when(() => mockLauncherUtil.canLaunchUrl(any()))
        .thenAnswer((_) async => true);
    when(() => mockLauncherUtil.launchUrl(any())).thenAnswer((_) async => true);
    when(() => mockAppAction.getUris()).thenAnswer((_) async => dummyUris);
  });

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  test('launchAction returns false when no URIs are available', () async {
    // Arrange
    when(() => mockAppAction.getUris()).thenAnswer((_) async => []);

    // Act
    final result = await deeplinkX.launchAction(mockAppAction);

    // Assert
    expect(result, false);
    verifyNever(() => mockLauncherUtil.launchUrl(any()));
    verifyNever(() => mockLauncherUtil.canLaunchUrl(any()));
  });

  test('canLaunch returns false when no URIs are available', () async {
    // Arrange
    when(() => mockAppAction.getUris()).thenAnswer((_) async => []);

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
    when(() => mockLauncherUtil.canLaunchUrl(dummyUris[0]))
        .thenAnswer((_) async => false);
    when(() => mockLauncherUtil.canLaunchUrl(dummyUris[1]))
        .thenAnswer((_) async => false);

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
    when(() => mockLauncherUtil.canLaunchUrl(dummyUris[0]))
        .thenAnswer((_) async => false);
    when(() => mockLauncherUtil.canLaunchUrl(dummyUris[1]))
        .thenAnswer((_) async => false);

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
    when(() => mockLauncherUtil.canLaunchUrl(any()))
        .thenAnswer((_) async => false);

    // Act
    final result = await deeplinkX.launchAction(mockAppAction);

    // Assert
    expect(result, false);
    verifyNever(() => mockLauncherUtil.launchUrl(any()));
    verify(() => mockLauncherUtil.canLaunchUrl(any())).called(dummyUris.length);
  });

  test('canLaunch returns false when no URI can be launched', () async {
    // Arrange
    when(() => mockLauncherUtil.canLaunchUrl(any()))
        .thenAnswer((_) async => false);

    // Act
    final result = await deeplinkX.canLaunch(mockAppAction);

    // Assert
    expect(result, false);
    verify(() => mockLauncherUtil.canLaunchUrl(any())).called(dummyUris.length);
  });
}

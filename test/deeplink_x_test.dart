import 'package:deeplink_x/deeplink_x.dart'; // Make sure to import the deeplink_x package
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

enum DummyActionType implements ActionTypeEnum {
  open;
}

class DummyAppAction extends AppAction {
  DummyAppAction() : super(actionType: DummyActionType.open);

  @override
  Future<List<Uri>> getUris() async {
    return [];
  }
}

class MockDeeplinkX extends Mock implements DeeplinkX {}

// Tests apis exposed correctly
void main() {
  late MockDeeplinkX deeplinkX;

  setUp(() {
    deeplinkX = MockDeeplinkX();

    when(() => deeplinkX.launchAction(any())).thenAnswer((_) async => true);
    when(() => deeplinkX.canLaunch(any())).thenAnswer((_) async => true);
  });

  setUpAll(() {
    registerFallbackValue(DummyAppAction());
  });

  group('Exposed Api Access Check:', () {
    group('Apps:', () {
      test('Instagram', () {
        final action = Instagram.open;
        expect(action, isA<AppAction>());
      });
    });

    group('Enums:', () {
      test('PlatformEnum', () {
        const platform = PlatformEnum.android;
        expect(platform, isA<PlatformEnum>());
      });
    });

    group('Public methods:', () {
      test('launchAction', () async {
        final result = await deeplinkX.launchAction(DummyAppAction());
        expect(result, true);
      });

      test('canLaunch', () async {
        final result = await deeplinkX.canLaunch(DummyAppAction());
        expect(result, true);
      });
    });
  });
}

import 'package:deeplink_x/deeplink_x.dart'; // Make sure to import the deeplink_x package
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

enum DummyActionType implements ActionTypeEnum {
  open;
}

class DummyAppAction extends AppAction {
  DummyAppAction() : super(actionType: DummyActionType.open);

  @override
  Future<List<Uri>> getUris() => Future.value([]);
}

class MockDeeplinkX extends Mock implements DeeplinkX {}

// Tests apis exposed correctly
void main() {
  late MockDeeplinkX deeplinkX;

  setUp(() {
    deeplinkX = MockDeeplinkX();

    when(() => deeplinkX.launchAction(any())).thenAnswer((final _) async => true);
    when(() => deeplinkX.canLaunch(any())).thenAnswer((final _) async => true);
  });

  setUpAll(() {
    registerFallbackValue(DummyAppAction());
  });

  group('Exposed Api Access Check:', () {
    group('Apps:', () {
      test('Instagram', () {
        const action = Instagram.open;
        expect(action, isA<AppAction>());
      });

      test('Telegram', () {
        const action = Telegram.open;
        expect(action, isA<AppAction>());
      });

      test('IOSAppStore', () {
        const action = IOSAppStore.open;
        expect(action, isA<AppAction>());
      });

      test('PlayStore', () {
        const action = PlayStore.open;
        expect(action, isA<AppAction>());
      });

      test('MacAppStore', () {
        const action = MacAppStore.open;
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

import 'package:deeplink_x/src/core/app_actions/app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:flutter_test/flutter_test.dart';

enum DummyActionType implements ActionTypeEnum {
  open;
}

class DummyAppAction extends AppAction {
  DummyAppAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type);

  final DummyActionType type;

  @override
  Future<Uri> getNativeUri() async => Uri(scheme: 'test', host: 'test');

  @override
  Future<Uri> getFallbackUri() async => Uri(scheme: 'https', host: 'test');
}

void main() {
  late PlatformType platfromType;

  setUp(() {
    platfromType = PlatformType.android;
  });

  group('AppAction', () {
    test('parameters can be null', () {
      final action = DummyAppAction(DummyActionType.open);
      expect(action.parameters, isNull);
    });

    test('parameters can be set through constructor', () {
      final params = {'key': 'value'};
      final action = DummyAppAction(DummyActionType.open, parameters: params);
      expect(action.parameters, params);
    });

    test('getUris return native and fallback uris', () async {
      final uris = await DummyAppAction(DummyActionType.open).getUris(platfromType);
      expect(uris.length, 2);
      expect(uris[0].toString(), 'test://test');
      expect(uris[1].toString(), 'https://test');
    });
  });
}

import 'package:deeplink_x/src/core/app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:flutter_test/flutter_test.dart';

enum DummyActionType implements ActionTypeEnum {
  open;
}

class DummyAppAction extends AppAction {
  final DummyActionType type;

  DummyAppAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type);

  @override
  Future<List<Uri>> getUris() async {
    return [];
  }
}

void main() {
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
  });
}

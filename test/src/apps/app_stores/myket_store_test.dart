import 'package:deeplink_x/src/apps/app_stores/myket_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyketAction', () {
    test('open action returns correct URIs', () async {
      const action = MyketAction(MyketActionType.open);
      final nativeUri = await action.getNativeUri();
      final fallbackUri = await action.getFallbackUri();

      expect(nativeUri.toString(), 'myket://main');
      expect(fallbackUri.toString(), 'https://myket.ir');
    });

    test('openAppPage action returns correct URIs', () async {
      const packageName = 'com.example.app';
      const referrer = 'utm_source=test';
      const action = MyketAction(
        MyketActionType.openAppPage,
        parameters: {
          'packageName': packageName,
          'referrer': referrer,
        },
      );

      final nativeUri = await action.getNativeUri();
      final fallbackUri = await action.getFallbackUri();

      expect(nativeUri.toString(), 'myket://details?id=com.example.app&referrer=utm_source%3Dtest');
      expect(fallbackUri.toString(), 'https://myket.ir/app/com.example.app?referrer=utm_source%3Dtest');
    });
  });

  group('MyketStore', () {
    test('open returns correct action', () {
      const action = MyketStore.open;
      expect(action.type, MyketActionType.open);
      expect(action.parameters, null);
    });

    test('openAppPage returns correct action', () {
      const packageName = 'com.example.app';
      const referrer = 'utm_source=test';
      final action = MyketStore.openAppPage(
        packageName: packageName,
        referrer: referrer,
      );

      expect(action.type, MyketActionType.openAppPage);
      expect(action.parameters!['packageName'], packageName);
      expect(action.parameters!['referrer'], referrer);
    });
  });
}

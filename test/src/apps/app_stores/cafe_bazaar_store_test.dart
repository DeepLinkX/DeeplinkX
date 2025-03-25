import 'package:deeplink_x/src/apps/app_stores/cafe_bazaar_store.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PlatformEnum platformType;

  setUpAll(() {
    platformType = PlatformEnum.android;
  });

  group('Cafe Bazaar Store Actions', () {
    test('open action generates correct URIs', () async {
      const action = CafeBazaarStore.open;
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'bazaar://home');
      expect(uris[1].toString(), 'https://cafebazaar.ir');
    });

    test('openAppPage action generates correct URIs', () async {
      final action = CafeBazaarStore.openAppPage(
        packageName: 'com.example.app',
      );
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'bazaar://details/com.example.app',
      );
      expect(
        uris[1].toString(),
        'https://cafebazaar.ir/app/com.example.app',
      );
    });

    test('openAppPage action with referrer generates correct URIs', () async {
      final action = CafeBazaarStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'bazaar://details/com.example.app?referrer=utm_source%3Dtest_app',
      );
      expect(
        uris[1].toString(),
        'https://cafebazaar.ir/app/com.example.app?referrer=utm_source%3Dtest_app',
      );
    });

    test('parameters are correctly stored for openAppPage', () {
      final action = CafeBazaarStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );

      expect(action.parameters, {
        'packageName': 'com.example.app',
        'referrer': 'utm_source=test_app',
      });
    });
  });
}

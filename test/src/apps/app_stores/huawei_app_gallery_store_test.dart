import 'package:deeplink_x/src/apps/app_stores/huawei_app_gallery_store.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PlatformEnum platformType;

  setUpAll(() {
    platformType = PlatformEnum.android;
  });

  group('Huawei AppGallery Actions', () {
    test('openAppPage action generates correct URIs', () async {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
      );
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'appmarket://details?id=com.example.app',
      );
      expect(
        uris[1].toString(),
        'https://appgallery.huawei.com/app/C100000000',
      );
    });

    test('openAppPage action with referrer generates correct URIs', () async {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'appmarket://details?id=com.example.app&referrer=utm_source%3Dtest_app',
      );
      expect(
        uris[1].toString(),
        'https://appgallery.huawei.com/app/C100000000?referrer=utm_source%3Dtest_app',
      );
    });

    test('openAppPage action with locale generates correct URIs', () async {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
        locale: 'en_US',
      );
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'appmarket://details?id=com.example.app&locale=en_US',
      );
      expect(
        uris[1].toString(),
        'https://appgallery.huawei.com/app/C100000000?locale=en_US',
      );
    });

    test('parameters are correctly stored for openAppPage', () {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
        locale: 'en_US',
      );

      expect(action.parameters, {
        'appId': 'C100000000',
        'packageName': 'com.example.app',
        'referrer': 'utm_source=test_app',
        'locale': 'en_US',
      });
    });
  });
}

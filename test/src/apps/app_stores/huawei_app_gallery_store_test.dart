import 'package:deeplink_x/src/apps/app_stores/huawei_app_gallery_store.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_open_app_page_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Huawei AppGallery Actions', () {
    test('open action creates HuaweiAppGalleryStore instance with correct properties', () {
      final action = HuaweiAppGalleryStore.open();

      // As Store
      expect(action.platform, PlatformType.android);

      // As App
      expect(action.customScheme, 'appmarket');
      expect(action.androidPackageName, 'com.huawei.appmarket');
      expect(action.website.toString(), 'https://appgallery.huawei.com');
    });

    test('open action creates HuaweiAppGalleryStore instance with correct type', () {
      final action = HuaweiAppGalleryStore.open();

      expect(action, isInstanceOf<StoreApp>());
    });

    test('openAppPage action creates correct type', () {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
      );

      expect(action, isInstanceOf<StoreOpenAppPageAction>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openAppPage action creates correct URIs', () {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
      );

      expect(action.appLink.toString(), 'appmarket://details?id=com.example.app');
      expect(action.fallbackLink.toString(), 'https://appgallery.huawei.com/app/C100000000');
    });

    test('openAppPage action with referrer creates correct URIs', () {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );

      expect(
        action.appLink.toString(),
        'appmarket://details?id=com.example.app&referrer=utm_source%3Dtest_app',
      );
      expect(
        action.fallbackLink.toString(),
        'https://appgallery.huawei.com/app/C100000000?referrer=utm_source%3Dtest_app',
      );
    });

    test('openAppPage action with locale creates correct URIs', () {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
        locale: 'en_US',
      );

      expect(
        action.appLink.toString(),
        'appmarket://details?id=com.example.app&locale=en_US',
      );
      expect(
        action.fallbackLink.toString(),
        'https://appgallery.huawei.com/app/C100000000?locale=en_US',
      );
    });

    test('openAppPage action stores parameters correctly', () {
      final action = HuaweiAppGalleryStore.openAppPage(
        appId: 'C100000000',
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
        locale: 'en_US',
      );

      expect(action.appId, 'C100000000');
      expect(action.packageName, 'com.example.app');
      expect(action.referrer, 'utm_source=test_app');
      expect(action.locale, 'en_US');
    });
  });
}

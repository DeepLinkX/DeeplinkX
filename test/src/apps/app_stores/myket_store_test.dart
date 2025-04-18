import 'package:deeplink_x/src/apps/app_stores/myket_store.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_open_app_page_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Myket Store Actions', () {
    test('open action creates MyketStore instance with correct properties', () {
      final action = MyketStore.open();

      // As Store
      expect(action.platform, PlatformType.android);

      // As App
      expect(action.customScheme, 'myket');
      expect(action.androidPackageName, 'ir.mservices.market');
      expect(action.website.toString(), 'https://myket.ir');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms.length, 1);
      expect(action.macosBundleIdentifier, null);
    });

    test('open action creates MyketStore instance with correct type', () {
      final action = MyketStore.open();

      expect(action, isInstanceOf<StoreApp>());
    });

    test('openAppPage action creates correct type', () {
      final action = MyketStore.openAppPage(
        packageName: 'com.example.app',
      );

      expect(action, isInstanceOf<StoreOpenAppPageAction>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openAppPage action creates correct URIs', () {
      final action = MyketStore.openAppPage(
        packageName: 'com.example.app',
      );

      expect(action.appLink.toString(), 'myket://details?id=com.example.app');
      expect(action.fallbackLink.toString(), 'https://myket.ir/app/com.example.app');
    });

    test('openAppPage action with referrer creates correct URIs', () {
      final action = MyketStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test',
      );

      expect(
        action.appLink.toString(),
        'myket://details?id=com.example.app&referrer=utm_source%3Dtest',
      );
      expect(
        action.fallbackLink.toString(),
        'https://myket.ir/app/com.example.app?referrer=utm_source%3Dtest',
      );
    });

    test('rateApp action creates correct URIs', () {
      final action = MyketStore.rateApp(
        packageName: 'com.example.app',
      );

      expect(
        action.appLink.toString(),
        'myket://comment?id=com.example.app',
      );
    });

    test('openAppPage action stores parameters correctly', () {
      final action = MyketStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test',
      );

      expect(action.packageName, 'com.example.app');
      expect(action.referrer, 'utm_source=test');
    });

    test('rateApp action stores parameters correctly', () {
      final action = MyketStore.rateApp(
        packageName: 'com.example.app',
      );

      expect(action.packageName, 'com.example.app');
    });
  });
}

import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_open_app_page_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/universal_link_app_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Play Store Actions', () {
    test('open action creates PlayStore instance with correct properties', () {
      final action = PlayStore.open();

      // As Store
      expect(action.platform, PlatformType.android);

      // As App
      expect(action.customScheme, 'market');
      expect(action.androidPackageName, 'com.android.vending');
      expect(action.website.toString(), 'https://play.google.com/store/apps');
    });

    test('open action creates PlayStore instance with correct type', () {
      final action = PlayStore.open();

      expect(action, isInstanceOf<StoreApp>());
    });

    test('openAppPage action creates correct type', () {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
      );

      expect(action, isInstanceOf<StoreOpenAppPageAction>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openAppPage action creates correct URIs', () {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
      );

      expect(action.universalLink.toString(), 'https://play.google.com/store/apps/details?id=com.example.app');
      expect(action.fallbackLink.toString(), 'https://play.google.com/store/apps/details?id=com.example.app');
    });

    test('openAppPage action with referrer creates correct URIs', () {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );

      expect(
        action.universalLink.toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&referrer=utm_source%3Dtest_app',
      );
      expect(
        action.fallbackLink.toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&referrer=utm_source%3Dtest_app',
      );
    });

    test('openAppPage action with language parameter creates correct URIs', () {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
        language: 'en',
      );

      expect(
        action.universalLink.toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&hl=en',
      );
      expect(
        action.fallbackLink.toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&hl=en',
      );
    });

    test('openAppPage action stores parameters correctly', () {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
        language: 'en',
      );

      expect(action.packageName, 'com.example.app');
      expect(action.referrer, 'utm_source=test_app');
      expect(action.language, 'en');
    });
  });
}

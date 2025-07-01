import 'package:deeplink_x/src/apps/app_stores/cafe_bazaar_store.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_open_app_page_action_interface.dart';
import 'package:deeplink_x_platform_interface/deeplink_x_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cafe Bazaar Store Actions', () {
    test('open action creates CafeBazaarStore instance with correct properties',
        () {
      final action = CafeBazaarStore.open();

      // As Store
      expect(action.platform, PlatformType.android);

      // As App
      expect(action.customScheme, null);
      expect(action.androidPackageName, 'com.farsitel.bazaar');
      expect(action.website.toString(), 'https://cafebazaar.ir');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms.length, 1);
      expect(action.macosBundleIdentifier, null);
    });

    test('open action creates CafeBazaarStore instance with correct type', () {
      final action = CafeBazaarStore.open();

      expect(action, isInstanceOf<StoreApp>());
    });

    test('openAppPage action creates correct type', () {
      final action = CafeBazaarStore.openAppPage(
        packageName: 'com.example.app',
      );

      expect(action, isInstanceOf<StoreOpenAppPageAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openAppPage action creates correct URIs', () {
      final action = CafeBazaarStore.openAppPage(
        packageName: 'com.example.app',
      );

      expect(
        action.androidIntentOptions,
        const AndroidIntentOption(
          action: 'action_view',
          data: 'bazaar://details?id=com.example.app',
          package: 'com.farsitel.bazaar',
          flags: [0x10000000], // Intent.FLAG_ACTIVITY_NEW_TASK
        ),
      );
      expect(action.appLink, null);
      expect(
        action.fallbackLink.toString(),
        'https://cafebazaar.ir/app/com.example.app',
      );
    });

    test('openAppPage action with referrer creates correct URIs', () {
      final action = CafeBazaarStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );

      expect(
        action.androidIntentOptions,
        const AndroidIntentOption(
          action: 'action_view',
          data:
              'bazaar://details?id=com.example.app&referrer=utm_source%3Dtest_app',
          package: 'com.farsitel.bazaar',
          flags: [0x10000000], // Intent.FLAG_ACTIVITY_NEW_TASK
        ),
      );
      expect(action.appLink, null);
      expect(
        action.fallbackLink.toString(),
        'https://cafebazaar.ir/app/com.example.app?referrer=utm_source%3Dtest_app',
      );
    });
  });
}

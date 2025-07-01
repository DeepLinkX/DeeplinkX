import 'package:deeplink_x/src/apps/app_stores/microsoft_store.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_open_app_page_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Microsoft Store Actions', () {
    test('open action creates MicrosoftStore instance with correct properties',
        () {
      final action = MicrosoftStore.open();

      // As Store
      expect(action.platform, PlatformType.windows);

      // As App
      expect(action.customScheme, 'ms-windows-store');
      expect(action.androidPackageName, null);
      expect(action.website.toString(), 'https://apps.microsoft.com/home');
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 1);
      expect(action.macosBundleIdentifier, null);
    });

    test('open action creates MicrosoftStore instance with correct type', () {
      final action = MicrosoftStore.open();

      expect(action, isInstanceOf<StoreApp>());
    });

    test('openAppPage action creates correct type', () {
      final action = MicrosoftStore.openAppPage(
        productId: '9WZDNCRFHVJL',
      );

      expect(action, isInstanceOf<StoreOpenAppPageAction>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openAppPage action creates correct URIs', () {
      final action = MicrosoftStore.openAppPage(
        productId: '9WZDNCRFHVJL',
      );

      expect(
        action.appLink.toString(),
        'ms-windows-store://pdp/?ProductId=9WZDNCRFHVJL',
      );
      expect(
        action.fallbackLink.toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL',
      );
    });

    test('openAppPage action with language parameter creates correct URIs', () {
      final action = MicrosoftStore.openAppPage(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
      );

      expect(
        action.appLink.toString(),
        'ms-windows-store://pdp/?ProductId=9WZDNCRFHVJL&hl=en-us',
      );
      expect(
        action.fallbackLink.toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL?hl=en-us',
      );
    });

    test(
        'openAppPage action with language and country code parameters creates correct URIs',
        () {
      final action = MicrosoftStore.openAppPage(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
        countryCode: 'US',
      );

      expect(
        action.appLink.toString(),
        'ms-windows-store://pdp/?ProductId=9WZDNCRFHVJL&hl=en-us&gl=US',
      );
      expect(
        action.fallbackLink.toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL?hl=en-us&gl=US',
      );
    });

    test('rateApp action creates correct type', () {
      final action = MicrosoftStore.rateApp(
        productId: '9WZDNCRFHVJL',
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
    });

    test('rateApp action creates correct URIs', () {
      final action = MicrosoftStore.rateApp(
        productId: '9WZDNCRFHVJL',
      );

      expect(
        action.appLink.toString(),
        'ms-windows-store://review/?ProductId=9WZDNCRFHVJL',
      );
    });

    test('rateApp action with language parameter creates correct URIs', () {
      final action = MicrosoftStore.rateApp(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
      );

      expect(
        action.appLink.toString(),
        'ms-windows-store://review/?ProductId=9WZDNCRFHVJL&hl=en-us',
      );
    });

    test(
        'rateApp action with language and country code parameters creates correct URIs',
        () {
      final action = MicrosoftStore.rateApp(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
        countryCode: 'US',
      );

      expect(
        action.appLink.toString(),
        'ms-windows-store://review/?ProductId=9WZDNCRFHVJL&hl=en-us&gl=US',
      );
    });

    test('openAppPage action stores parameters correctly', () {
      final action = MicrosoftStore.openAppPage(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
        countryCode: 'US',
      );

      expect(action.productId, '9WZDNCRFHVJL');
      expect(action.language, 'en-us');
      expect(action.countryCode, 'US');
    });

    test('rateApp action stores parameters correctly', () {
      final action = MicrosoftStore.rateApp(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
        countryCode: 'US',
      );

      expect(action.productId, '9WZDNCRFHVJL');
      expect(action.language, 'en-us');
      expect(action.countryCode, 'US');
    });
  });
}

import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/store_open_app_page_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('iOS App Store Actions', () {
    test('open action creates IOSAppStore instance with correct properties', () {
      final action = IOSAppStore.open();

      // As Store
      expect(action.platform, PlatformType.ios);

      // As App
      expect(action.customScheme, 'itms-apps');
      expect(action.androidPackageName, null);
      expect(action.website.toString(), 'https://www.apple.com/app-store/');
    });

    test('open action creates IOSAppStore instance with correct type', () {
      final action = IOSAppStore.open();

      expect(action, isInstanceOf<StoreApp>());
    });

    test('openAppPage action creates correct type', () {
      final action = IOSAppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
      );

      expect(action, isInstanceOf<StoreOpenAppPageAction>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openAppPage action creates correct URIs', () {
      final action = IOSAppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
      );

      expect(
        action.appLink.toString(),
        'itms-apps://itunes.apple.com/app/testapp/id123456789?mt=8',
      );
      expect(
        action.fallbackLink.toString(),
        'https://apps.apple.com/app/testapp/id123456789?mt=8',
      );
    });

    test('openAppPage action with country and tracking parameters creates correct URIs', () {
      final action = IOSAppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
        uniqueOrigin: 'origin123',
      );

      expect(
        action.appLink.toString(),
        'itms-apps://itunes.apple.com/us/app/testapp/id123456789?mt=8&ct=campaign123&pt=provider456&at=affiliate789&uo=origin123',
      );
      expect(
        action.fallbackLink.toString(),
        'https://apps.apple.com/us/app/testapp/id123456789?mt=8&ct=campaign123&pt=provider456&at=affiliate789&uo=origin123',
      );
    });

    test('rateApp action creates correct type', () {
      final action = IOSAppStore.rateApp(
        appId: '123456789',
        appName: 'testapp',
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
    });

    test('rateApp action creates correct URIs', () {
      final action = IOSAppStore.rateApp(
        appId: '123456789',
        appName: 'testapp',
      );

      expect(
        action.appLink.toString(),
        'itms-apps://itunes.apple.com/app/testapp/id123456789?mt=8&action=write-review',
      );
    });

    test('openAppPage action stores parameters correctly', () {
      final action = IOSAppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
        uniqueOrigin: 'origin123',
      );

      expect(action.appId, '123456789');
      expect(action.appName, 'testapp');
      expect(action.mediaType, '8');
      expect(action.country, 'us');
      expect(action.campaignToken, 'campaign123');
      expect(action.providerToken, 'provider456');
      expect(action.affiliateToken, 'affiliate789');
      expect(action.uniqueOrigin, 'origin123');
    });

    test('rateApp action stores parameters correctly', () {
      final action = IOSAppStore.rateApp(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
      );

      expect(action.appId, '123456789');
      expect(action.appName, 'testapp');
      expect(action.mediaType, '8');
      expect(action.country, 'us');
      expect(action.campaignToken, 'campaign123');
      expect(action.providerToken, 'provider456');
      expect(action.affiliateToken, 'affiliate789');
    });
  });
}

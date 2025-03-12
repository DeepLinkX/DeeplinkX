import 'package:deeplink_x/src/apps/app_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App Store Actions', () {
    test('open action generates correct URIs', () async {
      const action = AppStore.open;
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'itms-apps://');
      expect(uris[1].toString(), 'https://apps.apple.com');
    });

    test('openApp action generates correct URIs', () async {
      final action = AppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'itms-apps://itunes.apple.com/app/testapp/id123456789?mt=8',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/app/testapp/id123456789?mt=8',
      );
    });

    test('openApp action with country and tracking parameters generates correct URIs', () async {
      final action = AppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
        uniqueOrigin: 'origin123',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'itms-apps://itunes.apple.com/us/app/testapp/id123456789?mt=8&ct=campaign123&pt=provider456&at=affiliate789&uo=origin123',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/us/app/testapp/id123456789?mt=8&ct=campaign123&pt=provider456&at=affiliate789&uo=origin123',
      );
    });

    test('openReview action generates correct URIs', () async {
      final action = AppStore.openReview(
        appId: '123456789',
        appName: 'testapp',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'itms-apps://itunes.apple.com/app/testapp/id123456789?action=write-review&mt=8',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/app/testapp/id123456789?action=write-review&mt=8',
      );
    });

    test('openReview action with country and tracking parameters generates correct URIs', () async {
      final action = AppStore.openReview(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'itms-apps://itunes.apple.com/us/app/testapp/id123456789?action=write-review&mt=8&ct=campaign123&pt=provider456&at=affiliate789',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/us/app/testapp/id123456789?action=write-review&mt=8&ct=campaign123&pt=provider456&at=affiliate789',
      );
    });

    test('openMessagesExtension action generates correct URIs', () async {
      final action = AppStore.openMessagesExtension(
        appId: '123456789',
        appName: 'testapp',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'itms-apps://itunes.apple.com/app/testapp/id123456789?app=messages&mt=8',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/app/testapp/id123456789?app=messages&mt=8',
      );
    });

    test('openMessagesExtension action with country and tracking parameters generates correct URIs', () async {
      final action = AppStore.openMessagesExtension(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'itms-apps://itunes.apple.com/us/app/testapp/id123456789?app=messages&mt=8&ct=campaign123&pt=provider456&at=affiliate789',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/us/app/testapp/id123456789?app=messages&mt=8&ct=campaign123&pt=provider456&at=affiliate789',
      );
    });

    test('parameters are correctly stored for openApp', () {
      final action = AppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
        uniqueOrigin: 'origin123',
      );

      expect(action.parameters, {
        'appId': '123456789',
        'appName': 'testapp',
        'country': 'us',
        'mt': '8',
        'ct': 'campaign123',
        'pt': 'provider456',
        'at': 'affiliate789',
        'uo': 'origin123',
      });
    });

    test('parameters are correctly stored for openReview', () {
      final action = AppStore.openReview(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
      );

      expect(action.parameters, {
        'appId': '123456789',
        'appName': 'testapp',
        'country': 'us',
        'mt': '8',
        'ct': 'campaign123',
        'pt': 'provider456',
        'at': 'affiliate789',
      });
    });

    test('parameters are correctly stored for openMessagesExtension', () {
      final action = AppStore.openMessagesExtension(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
      );

      expect(action.parameters, {
        'appId': '123456789',
        'appName': 'testapp',
        'country': 'us',
        'mt': '8',
        'ct': 'campaign123',
        'pt': 'provider456',
        'at': 'affiliate789',
      });
    });
  });
}

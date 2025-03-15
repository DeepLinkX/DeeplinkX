import 'package:deeplink_x/src/apps/mac_app_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Mac App Store Actions', () {
    test('open action generates correct URIs', () async {
      const action = MacAppStore.open;
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'macappstore://');
      expect(uris[1].toString(), 'https://apps.apple.com/app/mac');
    });

    test('openAppPage action generates correct URIs', () async {
      final action = MacAppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'macappstore://apps.apple.com/app/mac/testapp/id123456789?mt=12',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/app/mac/testapp/id123456789?mt=12',
      );
    });

    test('openAppPage action with country and tracking parameters generates correct URIs', () async {
      final action = MacAppStore.openAppPage(
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
        'macappstore://apps.apple.com/us/app/mac/testapp/id123456789?mt=12&ct=campaign123&pt=provider456&at=affiliate789',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/us/app/mac/testapp/id123456789?mt=12&ct=campaign123&pt=provider456&at=affiliate789',
      );
    });

    test('openReview action generates correct URIs', () async {
      final action = MacAppStore.openReview(
        appId: '123456789',
        appName: 'testapp',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'macappstore://apps.apple.com/app/mac/testapp/id123456789?action=write-review&mt=12',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/app/mac/testapp/id123456789?action=write-review&mt=12',
      );
    });

    test('openReview action with country and tracking parameters generates correct URIs', () async {
      final action = MacAppStore.openReview(
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
        'macappstore://apps.apple.com/us/app/mac/testapp/id123456789?action=write-review&mt=12&ct=campaign123&pt=provider456&at=affiliate789',
      );
      expect(
        uris[1].toString(),
        'https://apps.apple.com/us/app/mac/testapp/id123456789?action=write-review&mt=12&ct=campaign123&pt=provider456&at=affiliate789',
      );
    });

    test('parameters are correctly stored for openAppPage', () {
      final action = MacAppStore.openAppPage(
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
        'mt': '12',
        'ct': 'campaign123',
        'pt': 'provider456',
        'at': 'affiliate789',
      });
    });

    test('parameters are correctly stored for openReview', () {
      final action = MacAppStore.openReview(
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
        'mt': '12',
        'ct': 'campaign123',
        'pt': 'provider456',
        'at': 'affiliate789',
      });
    });
  });
}

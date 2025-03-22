import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PlatformEnum platfromType;

  setUpAll(() {
    platfromType = PlatformEnum.android;
  });

  group('iOS App Store Actions', () {
    test('open action generates correct URIs', () async {
      const action = IOSAppStore.open;
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'itms-apps://itunes.apple.com');
      expect(uris[1].toString(), 'https://apps.apple.com');
    });

    test('openApp action generates correct URIs', () async {
      final action = IOSAppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
      );
      final uris = await action.getUris(platfromType);

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
      final action = IOSAppStore.openAppPage(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
        uniqueOrigin: 'origin123',
      );
      final uris = await action.getUris(platfromType);

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
      final action = IOSAppStore.openReview(
        appId: '123456789',
        appName: 'testapp',
      );
      final uris = await action.getUris(platfromType);

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
      final action = IOSAppStore.openReview(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
      );
      final uris = await action.getUris(platfromType);

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
      final action = IOSAppStore.openMessagesExtension(
        appId: '123456789',
        appName: 'testapp',
      );
      final uris = await action.getUris(platfromType);

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
      final action = IOSAppStore.openMessagesExtension(
        appId: '123456789',
        appName: 'testapp',
        country: 'us',
        campaignToken: 'campaign123',
        providerToken: 'provider456',
        affiliateToken: 'affiliate789',
      );
      final uris = await action.getUris(platfromType);

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
  });
}

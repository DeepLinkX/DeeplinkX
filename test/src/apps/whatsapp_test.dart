import 'package:deeplink_x/src/apps/downloadable_apps/whatsapp.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WhatsApp Actions', () {
    late PlatformType platformType;

    setUpAll(() {
      platformType = PlatformType.android;
    });

    test('open action generates correct URIs', () async {
      final action = WhatsApp.open();
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'whatsapp://');
      expect(uris[1].toString(), 'https://wa.me');
    });

    test('chat action generates correct URIs', () async {
      final action = WhatsApp.chat('1234567890', text: 'Hello World');
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'whatsapp://send?phone=1234567890&text=Hello+World');
      expect(uris[1].toString(), 'https://wa.me/1234567890?text=Hello+World');
    });

    test('chat action without text generates correct URIs', () async {
      final action = WhatsApp.chat('1234567890');
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'whatsapp://send?phone=1234567890');
      expect(uris[1].toString(), 'https://wa.me/1234567890');
    });

    test('share action generates correct URIs', () async {
      final action = WhatsApp.share('Hello World');
      final uris = await action.getUris(platformType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'whatsapp://send?text=Hello+World');
      expect(uris[1].toString(), 'https://wa.me?text=Hello+World');
    });

    test('open action generates correct URIs when fallBackToStore is true on Android platform', () async {
      final action = WhatsApp.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.android);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'whatsapp://');
      expect(uris[1].toString(), 'market://details?id=com.whatsapp');
      expect(uris[2].toString(), 'https://wa.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on iOS platform', () async {
      final action = WhatsApp.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.ios);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'whatsapp://');
      expect(uris[1].toString(), 'itms-apps://itunes.apple.com/app/whatsapp-messenger/id310633997?mt=8');
      expect(uris[2].toString(), 'https://wa.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on macOS platform', () async {
      final action = WhatsApp.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.macos);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'whatsapp://');
      expect(uris[1].toString(), 'macappstore://itunes.apple.com/app/mac/whatsapp-messenger/id310633997?mt=12');
      expect(uris[2].toString(), 'https://wa.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on Windows platform', () async {
      final action = WhatsApp.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.windows);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'whatsapp://');
      expect(uris[1].toString(), 'ms-windows-store://pdp/?ProductId=9nksqgp7f2nh');
      expect(uris[2].toString(), 'https://wa.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on Linux platform', () async {
      final action = WhatsApp.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.linux);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'whatsapp://');
      expect(uris[1].toString(), 'https://wa.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on Web platform', () async {
      final action = WhatsApp.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.web);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'whatsapp://');
      expect(uris[1].toString(), 'https://wa.me');
    });

    test('parameters are correctly stored for chat action', () {
      final action = WhatsApp.chat('1234567890', text: 'Hello World');
      expect(action.parameters, {'phoneNumber': '1234567890', 'text': 'Hello World'});
    });

    test('parameters are correctly stored for share action', () {
      final action = WhatsApp.share('Hello World');
      expect(action.parameters, {'text': 'Hello World'});
    });
  });
}

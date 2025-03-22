import 'package:deeplink_x/src/apps/downloadable_apps/telegram.dart';
import 'package:deeplink_x/src/core/enums/platform_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Telegram Actions', () {
    late PlatformEnum platfromType;

    setUpAll(() {
      platfromType = PlatformEnum.android;
    });

    test('open action generates correct URIs', () async {
      final action = Telegram.open();
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://');
      expect(uris[1].toString(), 'https://t.me');
    });

    test('openProfile action generates correct URIs', () async {
      final action = Telegram.openProfile('testuser');
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?domain=testuser&profile');
      expect(uris[1].toString(), 'https://t.me/testuser?profile');
    });

    test('openProfilePhoneNumber action generates correct URIs', () async {
      final action = Telegram.openProfilePhoneNumber('1234567890');
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?phone=1234567890&profile');
      expect(uris[1].toString(), 'https://t.me/+1234567890?profile');
    });

    test('sendMessage action generates correct URIs', () async {
      final action = Telegram.sendMessage('testuser', 'Hello World');
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?domain=testuser&text=Hello%20World');
      expect(uris[1].toString(), 'https://t.me/testuser?text=Hello%20World');
    });

    test('open action generates correct URIs when fallBackToStore is true on Android platform', () async {
      final action = Telegram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.android);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'tg://');
      expect(uris[1].toString(), 'market://details?id=org.telegram.messenger');
      expect(uris[2].toString(), 'https://t.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on iOS platform', () async {
      final action = Telegram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.ios);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'tg://');
      expect(uris[1].toString(), 'itms-apps://itunes.apple.com/app/telegram-messenger/id686449807?mt=8');
      expect(uris[2].toString(), 'https://t.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on macOS platform', () async {
      final action = Telegram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.macos);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'tg://');
      expect(uris[1].toString(), 'macappstore://itunes.apple.com/app/mac/telegram/id747648890?mt=12');
      expect(uris[2].toString(), 'https://t.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on Windows platform', () async {
      final action = Telegram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.windows);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'tg://');
      expect(uris[1].toString(), 'ms-windows-store://pdp/?ProductId=9nztwsqntd0s');
      expect(uris[2].toString(), 'https://t.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on Linux platform', () async {
      final action = Telegram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.linux);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://');
      expect(uris[1].toString(), 'https://t.me');
    });

    test('open action generates correct URIs when fallBackToStore is true on Web platform', () async {
      final action = Telegram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformEnum.web);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://');
      expect(uris[1].toString(), 'https://t.me');
    });

    test('sendMessagePhoneNumber action generates correct URIs', () async {
      final action = Telegram.sendMessagePhoneNumber('1234567890', 'Hello World');
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?phone=1234567890&text=Hello%20World');
      expect(uris[1].toString(), 'https://t.me/+1234567890?text=Hello%20World');
    });

    test('message encoding handles @ symbol correctly', () async {
      final action = Telegram.sendMessage('testuser', '@mention');
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?domain=testuser&text=%20%40mention');
      expect(uris[1].toString(), 'https://t.me/testuser?text=%20%40mention');
    });

    test('parameters are correctly stored for openProfile', () {
      final action = Telegram.openProfile('testuser');
      expect(action.parameters, {'username': 'testuser'});
    });

    test('parameters are correctly stored for openProfilePhoneNumber', () {
      final action = Telegram.openProfilePhoneNumber('1234567890');
      expect(action.parameters, {'phoneNumber': '1234567890'});
    });

    test('parameters are correctly stored for sendMessage', () {
      final action = Telegram.sendMessage('testuser', 'Hello World');
      expect(action.parameters, {
        'username': 'testuser',
        'message': 'Hello World',
      });
    });

    test('parameters are correctly stored for sendMessagePhoneNumber', () {
      final action = Telegram.sendMessagePhoneNumber('1234567890', 'Hello World');
      expect(action.parameters, {
        'phoneNumber': '1234567890',
        'message': 'Hello World',
      });
    });
  });
}

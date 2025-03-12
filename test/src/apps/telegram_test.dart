import 'package:deeplink_x/src/apps/telegram.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Telegram Actions', () {
    test('open action generates correct URIs', () async {
      const action = Telegram.open;
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://');
      expect(uris[1].toString(), 'https://t.me');
    });

    test('openProfile action generates correct URIs', () async {
      final action = Telegram.openProfile('testuser');
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?domain=testuser&profile');
      expect(uris[1].toString(), 'https://t.me/testuser?profile');
    });

    test('openProfilePhoneNumber action generates correct URIs', () async {
      final action = Telegram.openProfilePhoneNumber('1234567890');
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?phone=1234567890&profile');
      expect(uris[1].toString(), 'https://t.me/+1234567890?profile');
    });

    test('sendMessage action generates correct URIs', () async {
      final action = Telegram.sendMessage('testuser', 'Hello World');
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?domain=testuser&text=Hello%20World');
      expect(uris[1].toString(), 'https://t.me/testuser?text=Hello%20World');
    });

    test('sendMessagePhoneNumber action generates correct URIs', () async {
      final action = Telegram.sendMessagePhoneNumber('1234567890', 'Hello World');
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'tg://resolve?phone=1234567890&text=Hello%20World');
      expect(uris[1].toString(), 'https://t.me/+1234567890?text=Hello%20World');
    });

    test('message encoding handles @ symbol correctly', () async {
      final action = Telegram.sendMessage('testuser', '@mention');
      final uris = await action.getUris();

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

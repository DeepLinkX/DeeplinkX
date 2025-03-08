import 'package:deeplink_x/src/apps/instagram.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Instagram Actions', () {
    test('open action generates correct URIs', () async {
      final action = Instagram.open;
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'instagram://');
      expect(uris[1].toString(), 'https://www.instagram.com');
    });

    test('openProfile action generates correct URIs', () async {
      final action = Instagram.openProfile('testuser');
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'instagram://user?username=testuser');
      expect(uris[1].toString(), 'https://www.instagram.com/testuser');
    });

    test('parameters are correctly stored', () {
      final action = Instagram.openProfile('testuser');
      expect(action.parameters, {'username': 'testuser'});
    });
  });
}

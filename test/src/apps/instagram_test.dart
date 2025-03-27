import 'package:deeplink_x/src/apps/downloadable_apps/instagram.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PlatformType platfromType;

  setUpAll(() {
    platfromType = PlatformType.android;
  });

  group('Instagram Actions', () {
    test('open action generates correct URIs', () async {
      final action = Instagram.open();
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'instagram://');
      expect(uris[1].toString(), 'https://www.instagram.com');
    });

    test('openProfile action generates correct URIs', () async {
      final action = Instagram.openProfile('testuser');
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'instagram://user?username=testuser');
      expect(uris[1].toString(), 'https://www.instagram.com/testuser');
    });

    test('open action generates correct URIs when fallBackToStore is true on Android platform', () async {
      final action = Instagram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.android);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'instagram://');
      expect(uris[1].toString(), 'market://details?id=com.instagram.android');
      expect(uris[2].toString(), 'https://www.instagram.com');
    });

    test('open action generates correct URIs when fallBackToStore is true on iOS platform', () async {
      final action = Instagram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.ios);

      expect(uris.length, 3);
      expect(uris[0].toString(), 'instagram://');
      expect(uris[1].toString(), 'itms-apps://itunes.apple.com/app/instagram/id389801252?mt=8');
      expect(uris[2].toString(), 'https://www.instagram.com');
    });

    test('open action generates correct URIs when fallBackToStore is true on macOS platform', () async {
      final action = Instagram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.macos);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'instagram://');
      expect(uris[1].toString(), 'https://www.instagram.com');
    });

    test('open action generates correct URIs when fallBackToStore is true on Windows platform', () async {
      final action = Instagram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.windows);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'instagram://');
      expect(uris[1].toString(), 'https://www.instagram.com');
    });

    test('open action generates correct URIs when fallBackToStore is true on Linux platform', () async {
      final action = Instagram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.linux);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'instagram://');
      expect(uris[1].toString(), 'https://www.instagram.com');
    });

    test('open action generates correct URIs when fallBackToStore is true on Web platform', () async {
      final action = Instagram.open(fallBackToStore: true);
      final uris = await action.getUris(PlatformType.web);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'instagram://');
      expect(uris[1].toString(), 'https://www.instagram.com');
    });

    test('parameters are correctly stored', () {
      final action = Instagram.openProfile('testuser');
      expect(action.parameters, {'username': 'testuser'});
    });
  });
}

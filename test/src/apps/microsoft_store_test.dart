import 'package:deeplink_x/src/apps/microsoft_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Microsoft Store Actions', () {
    test('open action generates correct URIs', () async {
      const action = MicrosoftStore.open;
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(uris[0].toString(), 'ms-windows-store://');
      expect(uris[1].toString(), 'https://apps.microsoft.com');
    });

    test('openAppPage action generates correct URIs', () async {
      final action = MicrosoftStore.openAppPage(
        productId: '9WZDNCRFHVJL',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'ms-windows-store:///pdp?ProductId=9WZDNCRFHVJL',
      );
      expect(
        uris[1].toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL',
      );
    });

    test('openAppPage action with language parameter generates correct URIs', () async {
      final action = MicrosoftStore.openAppPage(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'ms-windows-store:///pdp?hl=en-us&ProductId=9WZDNCRFHVJL',
      );
      expect(
        uris[1].toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL?hl=en-us',
      );
    });

    test('openAppPage action with language and country code parameters generates correct URIs', () async {
      final action = MicrosoftStore.openAppPage(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
        countryCode: 'US',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'ms-windows-store:///pdp?hl=en-us&gl=US&ProductId=9WZDNCRFHVJL',
      );
      expect(
        uris[1].toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL?hl=en-us&gl=US',
      );
    });

    test('openAppReviewPage action generates correct URIs', () async {
      final action = MicrosoftStore.openAppReviewPage(
        productId: '9WZDNCRFHVJL',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'ms-windows-store:///review?ProductId=9WZDNCRFHVJL',
      );
      expect(
        uris[1].toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL#reviews',
      );
    });

    test('openAppReviewPage action with language parameter generates correct URIs', () async {
      final action = MicrosoftStore.openAppReviewPage(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'ms-windows-store:///review?hl=en-us&ProductId=9WZDNCRFHVJL',
      );
      expect(
        uris[1].toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL?hl=en-us#reviews',
      );
    });

    test('openAppReviewPage action with language and country code parameters generates correct URIs', () async {
      final action = MicrosoftStore.openAppReviewPage(
        productId: '9WZDNCRFHVJL',
        language: 'en-us',
        countryCode: 'US',
      );
      final uris = await action.getUris();

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'ms-windows-store:///review?hl=en-us&gl=US&ProductId=9WZDNCRFHVJL',
      );
      expect(
        uris[1].toString(),
        'https://apps.microsoft.com/store/detail/app/9WZDNCRFHVJL?hl=en-us&gl=US#reviews',
      );
    });
  });
}

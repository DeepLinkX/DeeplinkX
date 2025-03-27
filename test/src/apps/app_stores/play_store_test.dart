import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PlatformType platfromType;

  setUpAll(() {
    platfromType = PlatformType.android;
  });

  group('Play Store Actions', () {
    test('open action generates correct URIs', () async {
      const action = PlayStore.open;
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(uris[0].toString(), 'market://');
      expect(uris[1].toString(), 'https://play.google.com');
    });

    test('openAppPage action generates correct URIs', () async {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
      );
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'market://details?id=com.example.app',
      );
      expect(
        uris[1].toString(),
        'https://play.google.com/store/apps/details?id=com.example.app',
      );
    });

    test('openAppPage action with referrer generates correct URIs', () async {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'market://details?id=com.example.app&referrer=utm_source%3Dtest_app',
      );
      expect(
        uris[1].toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&referrer=utm_source%3Dtest_app',
      );
    });

    test('openAppReviewPage action generates correct URIs', () async {
      final action = PlayStore.openAppReviewPage(
        packageName: 'com.example.app',
      );
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'market://details?id=com.example.app&showAllReviews=true',
      );
      expect(
        uris[1].toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&showAllReviews=true',
      );
    });

    test('openAppReviewPage action with referrer generates correct URIs', () async {
      final action = PlayStore.openAppReviewPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'market://details?id=com.example.app&showAllReviews=true&referrer=utm_source%3Dtest_app',
      );
      expect(
        uris[1].toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&showAllReviews=true&referrer=utm_source%3Dtest_app',
      );
    });

    test('parameters are correctly stored for openAppPage', () {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );

      expect(action.parameters, {
        'packageName': 'com.example.app',
        'referrer': 'utm_source=test_app',
      });
    });

    test('parameters are correctly stored for openAppReviewPage', () {
      final action = PlayStore.openAppReviewPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
      );

      expect(action.parameters, {
        'packageName': 'com.example.app',
        'referrer': 'utm_source=test_app',
      });
    });

    test('openAppPage action with hl parameter generates correct URIs', () async {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
        hl: 'fr',
      );
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'market://details?id=com.example.app&hl=fr',
      );
      expect(
        uris[1].toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&hl=fr',
      );
    });

    test('openAppPage action with referrer and hl parameters generates correct URIs', () async {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
        hl: 'de',
      );
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'market://details?id=com.example.app&referrer=utm_source%3Dtest_app&hl=de',
      );
      expect(
        uris[1].toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&referrer=utm_source%3Dtest_app&hl=de',
      );
    });

    test('openAppReviewPage action with hl parameter generates correct URIs', () async {
      final action = PlayStore.openAppReviewPage(
        packageName: 'com.example.app',
        hl: 'es',
      );
      final uris = await action.getUris(platfromType);

      expect(uris.length, 2);
      expect(
        uris[0].toString(),
        'market://details?id=com.example.app&showAllReviews=true&hl=es',
      );
      expect(
        uris[1].toString(),
        'https://play.google.com/store/apps/details?id=com.example.app&showAllReviews=true&hl=es',
      );
    });

    test('parameters are correctly stored with hl parameter', () {
      final action = PlayStore.openAppPage(
        packageName: 'com.example.app',
        referrer: 'utm_source=test_app',
        hl: 'ja',
      );

      expect(action.parameters, {
        'packageName': 'com.example.app',
        'referrer': 'utm_source=test_app',
        'hl': 'ja',
      });
    });
  });
}

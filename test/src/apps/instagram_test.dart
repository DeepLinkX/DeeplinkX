import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/instagram.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Instagram Actions', () {
    test('open action creates Instagram instance with correct properties', () {
      final action = Instagram.open();

      // As App
      expect(action.customScheme, 'instagram');
      expect(action.androidPackageName, 'com.instagram.android');
      expect(action.website.toString(), 'https://www.instagram.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates Instagram instance with correct type', () {
      final action = Instagram.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfile action creates correct type', () {
      final action = Instagram.openProfile(
        username: 'testuser',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfile action creates correct URIs', () {
      final action = Instagram.openProfile(
        username: 'testuser',
      );

      expect(
        action.appLink.toString(),
        'instagram://user?username=testuser',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.instagram.com/testuser',
      );
    });

    test(
        'open action with fallbackToStore creates Instagram instance with correct properties',
        () {
      final action = Instagram.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'instagram');
      expect(action.androidPackageName, 'com.instagram.android');
      expect(action.website.toString(), 'https://www.instagram.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 2);
    });

    test('store actions have correct properties', () {
      final instagram = Instagram();
      final storeActions = instagram.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.instagram.android');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '389801252');
      expect(iosStoreAction.appName, 'instagram');
    });

    test('openProfile action stores parameters correctly', () {
      final action = Instagram.openProfile(
        username: 'testuser',
        fallbackToStore: true,
      );

      expect(action.username, 'testuser');
      expect(action.fallbackToStore, true);
    });
  });
}

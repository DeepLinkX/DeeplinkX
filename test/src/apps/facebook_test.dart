import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/microsoft_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/facebook.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/universal_link_app_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Facebook Actions', () {
    test('open action creates Facebook instance with correct properties', () {
      final action = Facebook.open();

      // As App
      expect(action.customScheme, 'fb');
      expect(action.androidPackageName, 'com.facebook.katana');
      expect(action.website.toString(), 'https://www.facebook.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 3);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 3);
    });

    test('open action creates Facebook instance with correct type', () {
      final action = Facebook.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfileById action creates correct type', () {
      final action = Facebook.openProfileById(
        id: '123456789',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfileById action creates correct URIs', () {
      final action = Facebook.openProfileById(
        id: '123456789',
      );

      expect(
        action.appLink.toString(),
        'fb://profile/123456789',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.facebook.com/123456789',
      );
    });

    test('openProfileByUsername action creates correct type', () {
      final action = Facebook.openProfileByUsername(
        username: 'testuser',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfileByUsername action creates correct URIs', () {
      final action = Facebook.openProfileByUsername(
        username: 'testuser',
      );

      expect(
        action.universalLink.toString(),
        'https://www.facebook.com/testuser',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.facebook.com/testuser',
      );
    });

    test('openPage action creates correct type', () {
      final action = Facebook.openPage(
        pageId: 'testpage',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openPage action creates correct URIs', () {
      final action = Facebook.openPage(
        pageId: 'testpage',
      );

      expect(
        action.universalLink.toString(),
        'https://www.facebook.com/testpage',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.facebook.com/testpage',
      );
    });

    test('openGroup action creates correct type', () {
      final action = Facebook.openGroup(
        groupId: 'testgroup',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openGroup action creates correct URIs', () {
      final action = Facebook.openGroup(
        groupId: 'testgroup',
      );

      expect(
        action.universalLink.toString(),
        'https://www.facebook.com/groups/testgroup',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.facebook.com/groups/testgroup',
      );
    });

    test('openEvent action creates correct type', () {
      final action = Facebook.openEvent(
        eventId: 'testevent',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openEvent action creates correct URIs', () {
      final action = Facebook.openEvent(
        eventId: 'testevent',
      );

      expect(
        action.universalLink.toString(),
        'https://www.facebook.com/events/testevent',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.facebook.com/events/testevent',
      );
    });

    test(
        'open action with fallbackToStore creates Facebook instance with correct properties',
        () {
      final action = Facebook.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'fb');
      expect(action.androidPackageName, 'com.facebook.katana');
      expect(action.website.toString(), 'https://www.facebook.com');

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 3);
    });

    test('store actions have correct properties', () {
      final facebook = Facebook();
      final storeActions = facebook.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.facebook.katana');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '284882215');
      expect(iosStoreAction.appName, 'facebook');

      // Microsoft Store action
      final microsoftStoreAction =
          storeActions[2] as MicrosoftStoreOpenAppPageAction;
      expect(microsoftStoreAction.productId, '9wzdncrfj2wl');
    });

    test('actions store parameters correctly with fallbackToStore', () {
      final profileByIdAction = Facebook.openProfileById(
        id: '123456789',
        fallbackToStore: true,
      );
      expect(profileByIdAction.id, '123456789');
      expect(profileByIdAction.fallbackToStore, true);

      final profileByUsernameAction = Facebook.openProfileByUsername(
        username: 'testuser',
        fallbackToStore: true,
      );
      expect(profileByUsernameAction.username, 'testuser');
      expect(profileByUsernameAction.fallbackToStore, true);

      final pageAction = Facebook.openPage(
        pageId: 'testpage',
        fallbackToStore: true,
      );
      expect(pageAction.pageId, 'testpage');
      expect(pageAction.fallbackToStore, true);

      final groupAction = Facebook.openGroup(
        groupId: 'testgroup',
        fallbackToStore: true,
      );
      expect(groupAction.groupId, 'testgroup');
      expect(groupAction.fallbackToStore, true);

      final eventAction = Facebook.openEvent(
        eventId: 'testevent',
        fallbackToStore: true,
      );
      expect(eventAction.eventId, 'testevent');
      expect(eventAction.fallbackToStore, true);
    });
  });
}

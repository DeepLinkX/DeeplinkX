import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/pinterest.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pinterest Actions', () {
    test('open action creates Pinterest instance with correct properties', () {
      final action = Pinterest.open();

      // As App
      expect(action.customScheme, 'pinterest');
      expect(action.androidPackageName, 'com.pinterest');
      expect(action.website.toString(), 'https://www.pinterest.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates Pinterest instance with correct type', () {
      final action = Pinterest.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfile action creates correct type', () {
      final action = Pinterest.openProfile(
        username: 'pinterest',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfile action creates correct URIs', () {
      final action = Pinterest.openProfile(
        username: 'pinterest',
      );

      expect(
        action.appLink.toString(),
        'pinterest://user/pinterest',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.pinterest.com/pinterest',
      );
    });

    test('openPin action creates correct type', () {
      final action = Pinterest.openPin(
        pinId: '1234567890',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openPin action creates correct URIs', () {
      final action = Pinterest.openPin(
        pinId: '1234567890',
      );

      expect(
        action.appLink.toString(),
        'pinterest://pin/1234567890',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.pinterest.com/pin/1234567890',
      );
    });

    test('search action creates correct type', () {
      final action = Pinterest.search(
        query: 'flutter',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('search action creates correct URIs', () {
      final action = Pinterest.search(
        query: 'flutter tutorial',
      );

      expect(
        action.appLink.toString(),
        'pinterest://search/pins?q=flutter%20tutorial',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.pinterest.com/search/pins?q=flutter+tutorial',
      );
    });

    test('open action with fallbackToStore creates Pinterest instance with correct properties', () {
      final action = Pinterest.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'pinterest');
      expect(action.androidPackageName, 'com.pinterest');
      expect(action.website.toString(), 'https://www.pinterest.com');

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 2);
    });

    test('store actions have correct properties', () {
      final pinterest = Pinterest();
      final storeActions = pinterest.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.pinterest');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '429047995');
      expect(iosStoreAction.appName, 'pinterest');
    });

    test('actions store parameters correctly with fallbackToStore', () {
      final profileAction = Pinterest.openProfile(
        username: 'pinterest',
        fallbackToStore: true,
      );
      expect(profileAction.username, 'pinterest');
      expect(profileAction.fallbackToStore, true);

      final pinAction = Pinterest.openPin(
        pinId: '1234567890',
        fallbackToStore: true,
      );
      expect(pinAction.pinId, '1234567890');
      expect(pinAction.fallbackToStore, true);

      final searchAction = Pinterest.search(
        query: 'flutter',
        fallbackToStore: true,
      );
      expect(searchAction.query, 'flutter');
      expect(searchAction.fallbackToStore, true);
    });

    test('openBoard action creates correct type', () {
      final action = Pinterest.openBoard(
        username: 'pinterest',
        board: 'my-board',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openBoard action creates correct URIs', () {
      final action = Pinterest.openBoard(
        username: 'pinterest',
        board: 'my-board',
      );

      expect(
        action.appLink.toString(),
        'pinterest://board/pinterest/my-board',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.pinterest.com/pinterest/my-board',
      );
    });

    test('openBoard action stores parameters correctly with fallbackToStore', () {
      final action = Pinterest.openBoard(
        username: 'pinterest',
        board: 'my-board',
        fallbackToStore: true,
      );
      expect(action.username, 'pinterest');
      expect(action.board, 'my-board');
      expect(action.fallbackToStore, true);
    });
  });
}

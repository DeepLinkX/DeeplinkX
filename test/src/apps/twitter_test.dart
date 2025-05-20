import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/twitter.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/universal_link_app_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Twitter Actions', () {
    test('open action creates Twitter instance with correct properties', () {
      final action = Twitter.open();

      // As App
      expect(action.customScheme, 'twitter');
      expect(action.androidPackageName, 'com.twitter.android');
      expect(action.website.toString(), 'https://twitter.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates Twitter instance with correct type', () {
      final action = Twitter.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfile action creates correct type', () {
      final action = Twitter.openProfile(
        username: 'twitter',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfile action creates correct URIs', () {
      final action = Twitter.openProfile(
        username: 'twitter',
      );

      expect(
        action.appLink.toString(),
        'twitter://user?screen_name=twitter',
      );
      expect(
        action.fallbackLink.toString(),
        'https://twitter.com/twitter',
      );
    });

    test('openTweet action creates correct type', () {
      final action = Twitter.openTweet(
        tweetId: '1234567890',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openTweet action creates correct URIs', () {
      final action = Twitter.openTweet(
        tweetId: '1234567890',
      );

      expect(
        action.appLink.toString(),
        'twitter://status?id=1234567890',
      );
      expect(
        action.fallbackLink.toString(),
        'https://twitter.com/i/status/1234567890',
      );
    });

    test('search action creates correct type', () {
      final action = Twitter.search(
        query: 'flutter',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('search action creates correct URIs', () {
      final action = Twitter.search(
        query: 'flutter',
      );

      expect(
        action.universalLink.toString(),
        'https://twitter.com/search?q=flutter',
      );
      expect(
        action.fallbackLink.toString(),
        'https://twitter.com/search?q=flutter',
      );
    });

    test('open action with fallbackToStore creates Twitter instance with correct properties', () {
      final action = Twitter.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'twitter');
      expect(action.androidPackageName, 'com.twitter.android');
      expect(action.website.toString(), 'https://twitter.com');

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 2);
    });

    test('store actions have correct properties', () {
      final twitter = Twitter();
      final storeActions = twitter.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.twitter.android');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '333903271');
      expect(iosStoreAction.appName, 'twitter');
    });

    test('actions store parameters correctly with fallbackToStore', () {
      final profileAction = Twitter.openProfile(
        username: 'twitter',
        fallbackToStore: true,
      );
      expect(profileAction.username, 'twitter');
      expect(profileAction.fallbackToStore, true);

      final tweetAction = Twitter.openTweet(
        tweetId: '1234567890',
        fallbackToStore: true,
      );
      expect(tweetAction.tweetId, '1234567890');
      expect(tweetAction.fallbackToStore, true);

      final searchAction = Twitter.search(
        query: 'flutter',
        fallbackToStore: true,
      );
      expect(searchAction.query, 'flutter');
      expect(searchAction.fallbackToStore, true);
    });
  });
}

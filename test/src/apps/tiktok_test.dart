import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/tiktok.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/universal_link_app_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TikTok Actions', () {
    test('open action creates TikTok instance with correct properties', () {
      final action = TikTok.open();

      // As App
      expect(action.customScheme, 'tiktok');
      expect(action.androidPackageName, 'com.zhiliaoapp.musically');
      expect(action.website.toString(), 'https://www.tiktok.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates TikTok instance with correct type', () {
      final action = TikTok.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfile action creates correct type', () {
      final action = TikTok.openProfile(
        username: 'tiktok',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfile action creates correct URIs', () {
      final action = TikTok.openProfile(
        username: 'tiktok',
      );

      expect(
        action.universalLink.toString(),
        'https://www.tiktok.com/@tiktok',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.tiktok.com/@tiktok',
      );
    });

    test('openVideo action creates correct type', () {
      final action = TikTok.openVideo(
        videoId: '7189387326583078190',
        username: 'tiktok',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openVideo action creates correct URIs', () {
      final action = TikTok.openVideo(
        videoId: '7189387326583078190',
        username: 'tiktok',
      );

      expect(
        action.universalLink.toString(),
        'https://www.tiktok.com/@tiktok/video/7189387326583078190',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.tiktok.com/@tiktok/video/7189387326583078190',
      );
    });

    test('open action with fallbackToStore creates TikTok instance with correct properties', () {
      final action = TikTok.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'tiktok');
      expect(action.androidPackageName, 'com.zhiliaoapp.musically');
      expect(action.website.toString(), 'https://www.tiktok.com');

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 2);
    });

    test('store actions have correct properties', () {
      final tiktok = TikTok();
      final storeActions = tiktok.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.zhiliaoapp.musically');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '835599320');
      expect(iosStoreAction.appName, 'tiktok');
    });

    test('actions store parameters correctly with fallbackToStore', () {
      final profileAction = TikTok.openProfile(
        username: 'tiktok',
        fallbackToStore: true,
      );
      expect(profileAction.username, 'tiktok');
      expect(profileAction.fallbackToStore, true);

      final videoAction = TikTok.openVideo(
        videoId: '7189387326583078190',
        username: 'tiktok',
        fallbackToStore: true,
      );
      expect(videoAction.videoId, '7189387326583078190');
      expect(videoAction.userName, 'tiktok');
      expect(videoAction.fallbackToStore, true);
    });

    test('openTag action creates correct type', () {
      final action = TikTok.openTag(
        tagName: 'flutter',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openTag action creates correct URIs', () {
      final action = TikTok.openTag(
        tagName: 'flutter',
      );

      expect(
        action.universalLink.toString(),
        'https://www.tiktok.com/tag/flutter',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.tiktok.com/tag/flutter',
      );
    });

    test('tag action stores parameters correctly with fallbackToStore', () {
      final tagAction = TikTok.openTag(
        tagName: 'flutter',
        fallbackToStore: true,
      );
      expect(tagAction.tagName, 'flutter');
      expect(tagAction.fallbackToStore, true);
    });
  });
}

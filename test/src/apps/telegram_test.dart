import 'package:deeplink_x/src/apps/app_stores/huawei_app_gallery_store.dart';
import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/mac_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/microsoft_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/telegram.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Telegram Actions', () {
    test('open action creates Telegram instance with correct properties', () {
      final action = Telegram.open();

      // As App
      expect(action.customScheme, 'tg');
      expect(action.androidPackageName, 'org.telegram.messenger');
      expect(action.website.toString(), 'https://telegram.org');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.macos));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms, contains(PlatformType.linux));
      expect(action.supportedPlatforms.length, 5);
      expect(action.macosBundleIdentifier, 'ru.keepcoder.Telegram');

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 5);
    });

    test('open action creates Telegram instance with correct type', () {
      final action = Telegram.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfile action creates correct type', () {
      final action = Telegram.openProfile(
        username: 'testuser',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfile action creates correct URIs', () {
      final action = Telegram.openProfile(
        username: 'testuser',
      );

      expect(
        action.appLink.toString(),
        'tg://resolve?domain=testuser&profile',
      );
      expect(
        action.fallbackLink.toString(),
        'https://t.me/testuser?profile',
      );
    });

    test('openProfileByPhoneNumber action creates correct type', () {
      final action = Telegram.openProfileByPhoneNumber(
        phoneNumber: '1234567890',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfileByPhoneNumber action creates correct URIs', () {
      final action = Telegram.openProfileByPhoneNumber(
        phoneNumber: '1234567890',
      );

      expect(
        action.appLink.toString(),
        'tg://resolve?phone=1234567890&profile',
      );
      expect(
        action.fallbackLink.toString(),
        'https://t.me/+1234567890?profile',
      );
    });

    test('sendMessage action creates correct type', () {
      final action = Telegram.sendMessage(
        username: 'testuser',
        message: 'Hello World',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('sendMessage action creates correct URIs', () {
      final action = Telegram.sendMessage(
        username: 'testuser',
        message: 'Hello World',
      );

      expect(
        action.appLink.toString(),
        'tg://resolve?domain=testuser&text=Hello%20World',
      );
      expect(
        action.fallbackLink.toString(),
        'https://t.me/testuser?text=Hello%20World',
      );
    });

    test('sendMessageByPhoneNumber action creates correct type', () {
      final action = Telegram.sendMessageByPhoneNumber(
        phoneNumber: '1234567890',
        message: 'Hello World',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('sendMessageByPhoneNumber action creates correct URIs', () {
      final action = Telegram.sendMessageByPhoneNumber(
        phoneNumber: '1234567890',
        message: 'Hello World',
      );

      expect(
        action.appLink.toString(),
        'tg://resolve?phone=1234567890&text=Hello%20World',
      );
      expect(
        action.fallbackLink.toString(),
        'https://t.me/+1234567890?text=Hello%20World',
      );
    });

    test('open action with fallbackToStore creates Telegram instance with correct properties', () {
      final action = Telegram.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'tg');
      expect(action.androidPackageName, 'org.telegram.messenger');
      expect(action.website.toString(), 'https://telegram.org');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.macos));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms, contains(PlatformType.linux));
      expect(action.supportedPlatforms.length, 5);
      expect(action.macosBundleIdentifier, 'ru.keepcoder.Telegram');

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 5);
    });

    test('store actions have correct properties', () {
      final telegram = Telegram();
      final storeActions = telegram.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'org.telegram.messenger');

      // Huawei App Gallery action
      final huaweiStoreAction = storeActions[1] as HuaweiAppGalleryStoreOpenAppPageAction;
      expect(huaweiStoreAction.packageName, 'org.telegram.messenger');
      expect(huaweiStoreAction.appId, 'C101184875');

      // iOS App Store action
      final iosStoreAction = storeActions[2] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '686449807');
      expect(iosStoreAction.appName, 'telegram-messenger');

      // Microsoft Store action
      final microsoftStoreAction = storeActions[3] as MicrosoftStoreOpenAppPageAction;
      expect(microsoftStoreAction.productId, '9nztwsqntd0s');

      // Mac App Store action
      final macStoreAction = storeActions[4] as MacAppStoreOpenAppPageAction;
      expect(macStoreAction.appId, '747648890');
      expect(macStoreAction.appName, 'telegram');
    });

    test('openProfile action stores parameters correctly', () {
      final action = Telegram.openProfile(
        username: 'testuser',
        fallbackToStore: true,
      );

      expect(action.username, 'testuser');
      expect(action.fallbackToStore, true);
    });

    test('openProfileByPhoneNumber action stores parameters correctly', () {
      final action = Telegram.openProfileByPhoneNumber(
        phoneNumber: '1234567890',
        fallbackToStore: true,
      );

      expect(action.phoneNumber, '1234567890');
      expect(action.fallbackToStore, true);
    });

    test('sendMessage action stores parameters correctly', () {
      final action = Telegram.sendMessage(
        username: 'testuser',
        message: 'Hello World',
        fallbackToStore: true,
      );

      expect(action.username, 'testuser');
      expect(action.message, 'Hello World');
      expect(action.fallbackToStore, true);
    });

    test('sendMessageByPhoneNumber action stores parameters correctly', () {
      final action = Telegram.sendMessageByPhoneNumber(
        phoneNumber: '1234567890',
        message: 'Hello World',
        fallbackToStore: true,
      );

      expect(action.phoneNumber, '1234567890');
      expect(action.message, 'Hello World');
      expect(action.fallbackToStore, true);
    });

    test('message encoding handles @ symbol correctly', () {
      final action = Telegram.sendMessage(
        username: 'testuser',
        message: '@mention',
      );

      expect(
        action.appLink.toString(),
        'tg://resolve?domain=testuser&text=%20%40mention',
      );
      expect(
        action.fallbackLink.toString(),
        'https://t.me/testuser?text=%20%40mention',
      );
    });
  });
}

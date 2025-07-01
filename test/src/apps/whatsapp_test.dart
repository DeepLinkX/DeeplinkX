import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/mac_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/microsoft_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/whatsapp.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WhatsApp Actions', () {
    test('open action creates WhatsApp instance with correct properties', () {
      final action = WhatsApp.open();

      // As App
      expect(action.customScheme, 'whatsapp');
      expect(action.androidPackageName, 'com.whatsapp');
      expect(action.website.toString(), 'https://www.whatsapp.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.macos));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 4);
      expect(action.macosBundleIdentifier, 'net.whatsapp.WhatsApp');

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 4);
    });

    test('open action creates WhatsApp instance with correct type', () {
      final action = WhatsApp.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('chat action creates correct type', () {
      final action = WhatsApp.chat(
        phoneNumber: '1234567890',
        message: 'Hello World',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('chat action creates correct URIs', () {
      final action = WhatsApp.chat(
        phoneNumber: '1234567890',
        message: 'Hello World',
      );

      expect(
        action.appLink.toString(),
        'whatsapp://send?phone=1234567890&text=Hello+World',
      );
      expect(
        action.fallbackLink.toString(),
        'https://wa.me/1234567890?text=Hello+World',
      );
    });

    test('chat action without text creates correct URIs', () {
      final action = WhatsApp.chat(
        phoneNumber: '1234567890',
      );

      expect(
        action.appLink.toString(),
        'whatsapp://send?phone=1234567890',
      );
      expect(
        action.fallbackLink.toString(),
        'https://wa.me/1234567890',
      );
    });

    test('shareText action creates correct type', () {
      final action = WhatsApp.shareText(
        text: 'Hello World',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('shareText action creates correct URIs', () {
      final action = WhatsApp.shareText(
        text: 'Hello World',
      );

      expect(
        action.appLink.toString(),
        'whatsapp://send?text=Hello+World',
      );
      expect(
        action.fallbackLink.toString(),
        'https://wa.me?text=Hello+World',
      );
    });

    test(
        'open action with fallbackToStore creates WhatsApp instance with correct properties',
        () {
      final action = WhatsApp.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'whatsapp');
      expect(action.androidPackageName, 'com.whatsapp');
      expect(action.website.toString(), 'https://www.whatsapp.com');

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 4);
    });

    test('store actions have correct properties', () {
      final whatsapp = WhatsApp();
      final storeActions = whatsapp.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.whatsapp');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '310633997');
      expect(iosStoreAction.appName, 'whatsapp-messenger');

      // Microsoft Store action
      final microsoftStoreAction =
          storeActions[2] as MicrosoftStoreOpenAppPageAction;
      expect(microsoftStoreAction.productId, '9nksqgp7f2nh');

      // Mac App Store action
      final macStoreAction = storeActions[3] as MacAppStoreOpenAppPageAction;
      expect(macStoreAction.appId, '310633997');
      expect(macStoreAction.appName, 'whatsapp-messenger');
    });

    test('chat action stores parameters correctly', () {
      final action = WhatsApp.chat(
        phoneNumber: '1234567890',
        message: 'Hello World',
        fallbackToStore: true,
      );

      expect(action.phoneNumber, '1234567890');
      expect(action.message, 'Hello World');
      expect(action.fallbackToStore, true);
    });

    test('shareText action stores parameters correctly', () {
      final action = WhatsApp.shareText(
        text: 'Hello World',
        fallbackToStore: true,
      );

      expect(action.text, 'Hello World');
      expect(action.fallbackToStore, true);
    });
  });
}

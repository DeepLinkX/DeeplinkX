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

    group('chatByUsername', () {
      test('factory creates the expected type and inherits WhatsApp configuration', () {
        final action = WhatsApp.chatByUsername(username: 'example_user');

        expect(action, isA<WhatsAppChatByUsernameAction>());
        expect(action, isA<App>());
        expect(action, isA<DownloadableApp>());
        expect(action, isA<AppLinkAppAction>());
        expect(action, isA<Fallbackable>());
        expect(action.username, 'example_user');
        expect(action.message, isNull);
        expect(action.fallbackToStore, isFalse);
        expect(action.customScheme, 'whatsapp');
        expect(action.androidPackageName, 'com.whatsapp');
        expect(action.macosBundleIdentifier, 'net.whatsapp.WhatsApp');
        expect(action.website, WhatsApp().website);
        expect(
          action.supportedPlatforms,
          [PlatformType.ios, PlatformType.android, PlatformType.windows, PlatformType.macos],
        );
        expect(
          action.storeActions.map((final store) => store.platform),
          [PlatformType.android, PlatformType.ios, PlatformType.windows, PlatformType.macos],
        );
        expect((action.storeActions[0] as PlayStoreOpenAppPageAction).packageName, 'com.whatsapp');
        expect((action.storeActions[1] as IOSAppStoreOpenAppPageAction).appId, '310633997');
        expect((action.storeActions[2] as MicrosoftStoreOpenAppPageAction).productId, '9nksqgp7f2nh');
        expect((action.storeActions[3] as MacAppStoreOpenAppPageAction).appId, '310633997');
      });

      test('factory stores the supplied message and store fallback flag', () {
        final action = WhatsApp.chatByUsername(
          username: 'example_user',
          message: 'Hello World',
          fallbackToStore: true,
        );

        expect(action.username, 'example_user');
        expect(action.message, 'Hello World');
        expect(action.fallbackToStore, isTrue);
        expect(action.appLink.toString(), 'whatsapp://send?username=example_user&text=Hello+World');
        expect(action.fallbackLink.toString(), 'https://wa.me/example_user?text=Hello+World');
      });

      for (final fallbackToStore in [false, true]) {
        test('direct constructor stores parameters with fallbackToStore=$fallbackToStore', () {
          final action = WhatsAppChatByUsernameAction(
            username: 'example_user',
            message: 'Hello World',
            fallbackToStore: fallbackToStore,
          );

          expect(action.username, 'example_user');
          expect(action.message, 'Hello World');
          expect(action.fallbackToStore, fallbackToStore);
        });
      }

      test('omits text and the empty fallback query when message is null', () {
        final action = WhatsApp.chatByUsername(username: 'example_user');

        expect(action.appLink.toString(), 'whatsapp://send?username=example_user');
        expect(action.appLink.queryParameters, {'username': 'example_user'});
        expect(action.fallbackLink.toString(), 'https://wa.me/example_user');
        expect(action.fallbackLink.hasQuery, isFalse);
      });

      test('retains text for an explicitly empty message', () {
        final action = WhatsApp.chatByUsername(username: 'example_user', message: '');

        expect(action.appLink.toString(), 'whatsapp://send?username=example_user&text=');
        expect(action.fallbackLink.toString(), 'https://wa.me/example_user?text=');
        expect(action.appLink.queryParameters['text'], '');
        expect(action.fallbackLink.queryParameters['text'], '');
      });

      test('encodes spaces, Unicode, and reserved message characters once', () {
        const message = 'Hello 世界 + & ? #';
        const encodedMessage = 'Hello+%E4%B8%96%E7%95%8C+%2B+%26+%3F+%23';
        final action = WhatsApp.chatByUsername(username: 'example_user', message: message);

        expect(action.appLink.toString(), 'whatsapp://send?username=example_user&text=$encodedMessage');
        expect(action.fallbackLink.toString(), 'https://wa.me/example_user?text=$encodedMessage');
        expect(action.appLink.queryParameters['text'], message);
        expect(action.fallbackLink.queryParameters['text'], message);
        expect(action.appLink.fragment, isEmpty);
        expect(action.fallbackLink.fragment, isEmpty);
      });

      test('preserves the supplied username without normalization', () {
        final action = WhatsApp.chatByUsername(username: 'Example.User_123');

        expect(action.username, 'Example.User_123');
        expect(action.appLink.queryParameters['username'], 'Example.User_123');
        expect(action.fallbackLink.toString(), 'https://wa.me/Example.User_123');
      });
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

    test('open action with fallbackToStore creates WhatsApp instance with correct properties', () {
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
      final microsoftStoreAction = storeActions[2] as MicrosoftStoreOpenAppPageAction;
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

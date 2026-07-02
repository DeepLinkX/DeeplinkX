import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatGPT Actions', () {
    test('open action creates ChatGPT instance with correct properties', () {
      final action = ChatGPT.open();

      expect(action.customScheme, 'chatgpt');
      expect(action.androidPackageName, 'com.openai.chatgpt');
      expect(action.website.toString(), 'https://chatgpt.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 3);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 3);
    });

    test('open action creates correct type', () {
      final action = ChatGPT.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openSharedConversation action creates correct type', () {
      final action = ChatGPT.openSharedConversation(shareId: 'abc123');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openSharedConversation action creates correct URIs', () {
      final action = ChatGPT.openSharedConversation(shareId: 'abc123');

      expect(action.universalLink.toString(), 'https://chatgpt.com/share/abc123');
      expect(action.fallbackLink.toString(), 'https://chatgpt.com/share/abc123');
    });

    test('openGpt action creates correct type', () {
      final action = ChatGPT.openGpt(gptId: 'g-abc123');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openGpt action creates correct URIs', () {
      final action = ChatGPT.openGpt(gptId: 'g-abc123');

      expect(action.universalLink.toString(), 'https://chatgpt.com/g/g-abc123');
      expect(action.fallbackLink.toString(), 'https://chatgpt.com/g/g-abc123');
    });

    test('open action with fallbackToStore creates ChatGPT instance with correct properties', () {
      final action = ChatGPT.open(fallbackToStore: true);

      expect(action.customScheme, 'chatgpt');
      expect(action.androidPackageName, 'com.openai.chatgpt');
      expect(action.website.toString(), 'https://chatgpt.com');
      expect(action.fallbackToStore, true);
    });

    test('store actions have correct properties', () {
      final storeActions = ChatGPT().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.openai.chatgpt');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '6448311069');
      expect(iosStoreAction.appName, 'chatgpt');

      final microsoftStoreAction = storeActions[2] as MicrosoftStoreOpenAppPageAction;
      expect(microsoftStoreAction.productId, '9nt1r1c2hh7j');
    });

    test('actions store parameters correctly', () {
      final sharedConversation = ChatGPT.openSharedConversation(
        shareId: 'abc123',
        fallbackToStore: true,
      );
      final gpt = ChatGPT.openGpt(
        gptId: 'g-abc123',
        fallbackToStore: true,
      );

      expect(sharedConversation.shareId, 'abc123');
      expect(sharedConversation.fallbackToStore, true);
      expect(gpt.gptId, 'g-abc123');
      expect(gpt.fallbackToStore, true);
    });
  });
}

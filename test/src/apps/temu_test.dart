import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Temu Actions', () {
    test('open action creates Temu instance with correct properties', () {
      final action = Temu.open();

      expect(action.customScheme, 'temu');
      expect(action.androidPackageName, 'com.einnovation.temu');
      expect(action.website.toString(), 'https://www.temu.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates correct type', () {
      final action = Temu.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openLink action creates correct type', () {
      final action = Temu.openLink(link: Uri.parse('https://www.temu.com/search_result.html?search_key=shoes'));

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openLink action creates correct URIs', () {
      final action = Temu.openLink(link: Uri.parse('https://www.temu.com/search_result.html?search_key=shoes'));

      expect(action.universalLink.toString(), 'https://www.temu.com/search_result.html?search_key=shoes');
      expect(action.fallbackLink.toString(), 'https://www.temu.com/search_result.html?search_key=shoes');
    });

    test('search action creates correct type', () {
      final action = Temu.search(query: 'running shoes');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('search action creates correct URIs', () {
      final action = Temu.search(query: 'running shoes');

      expect(action.universalLink.toString(), 'https://www.temu.com/search_result.html?search_key=running+shoes');
      expect(action.fallbackLink.toString(), 'https://www.temu.com/search_result.html?search_key=running+shoes');
    });

    test('open action with fallbackToStore creates Temu instance with correct properties', () {
      final action = Temu.open(fallbackToStore: true);

      expect(action.customScheme, 'temu');
      expect(action.androidPackageName, 'com.einnovation.temu');
      expect(action.website.toString(), 'https://www.temu.com');
      expect(action.fallbackToStore, true);
    });

    test('store actions have correct properties', () {
      final storeActions = Temu().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.einnovation.temu');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '1641486558');
      expect(iosStoreAction.appName, 'temu-shop-like-a-billionaire');
    });

    test('actions store parameters correctly', () {
      final link = Uri.parse('https://www.temu.com/search_result.html?search_key=shoes');
      final openLink = Temu.openLink(link: link, fallbackToStore: true);
      final search = Temu.search(query: 'running shoes', fallbackToStore: true);

      expect(openLink.link, link);
      expect(openLink.fallbackToStore, true);
      expect(search.query, 'running shoes');
      expect(search.fallbackToStore, true);
    });
  });
}

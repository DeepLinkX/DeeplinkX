import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Netflix Actions', () {
    test('open action creates Netflix instance with correct properties', () {
      final action = Netflix.open();

      expect(action.customScheme, 'nflx');
      expect(action.androidPackageName, 'com.netflix.mediaclient');
      expect(action.website.toString(), 'https://www.netflix.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 3);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 3);
    });

    test('open action creates correct type', () {
      final action = Netflix.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openTitle action creates correct type', () {
      final action = Netflix.openTitle(titleId: '81215567');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openTitle action creates correct URIs', () {
      final action = Netflix.openTitle(titleId: '81215567');

      expect(action.appLink.toString(), 'nflx://www.netflix.com/title/81215567');
      expect(action.fallbackLink.toString(), 'https://www.netflix.com/title/81215567');
    });

    test('watchTitle action creates correct type', () {
      final action = Netflix.watchTitle(titleId: '81215567');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('watchTitle action creates correct URIs', () {
      final action = Netflix.watchTitle(titleId: '81215567');

      expect(action.appLink.toString(), 'nflx://www.netflix.com/watch/81215567');
      expect(action.fallbackLink.toString(), 'https://www.netflix.com/watch/81215567');
    });

    test('open action with fallbackToStore creates Netflix instance with correct properties', () {
      final action = Netflix.open(fallbackToStore: true);

      expect(action.customScheme, 'nflx');
      expect(action.androidPackageName, 'com.netflix.mediaclient');
      expect(action.website.toString(), 'https://www.netflix.com');
      expect(action.fallbackToStore, true);
    });

    test('store actions have correct properties', () {
      final storeActions = Netflix().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.netflix.mediaclient');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '363590051');
      expect(iosStoreAction.appName, 'netflix');

      final microsoftStoreAction = storeActions[2] as MicrosoftStoreOpenAppPageAction;
      expect(microsoftStoreAction.productId, '9wzdncrfj3tj');
    });

    test('actions store parameters correctly', () {
      final openTitle = Netflix.openTitle(titleId: '81215567', fallbackToStore: true);
      final watchTitle = Netflix.watchTitle(titleId: '81215567', fallbackToStore: true);

      expect(openTitle.titleId, '81215567');
      expect(openTitle.fallbackToStore, true);
      expect(watchTitle.titleId, '81215567');
      expect(watchTitle.fallbackToStore, true);
    });
  });
}

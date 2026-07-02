import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Snapchat Actions', () {
    test('open action creates Snapchat instance with correct properties', () {
      final action = Snapchat.open();

      expect(action.customScheme, 'snapchat');
      expect(action.androidPackageName, 'com.snapchat.android');
      expect(action.website.toString(), 'https://www.snapchat.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 3);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 3);
    });

    test('open action creates correct type', () {
      final action = Snapchat.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfile action creates correct type', () {
      final action = Snapchat.openProfile(username: 'snapchat');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfile action creates correct URIs', () {
      final action = Snapchat.openProfile(username: 'snapchat');

      expect(action.universalLink.toString(), 'https://www.snapchat.com/add/snapchat');
      expect(action.fallbackLink.toString(), 'https://www.snapchat.com/add/snapchat');
    });

    test('open action with fallbackToStore creates Snapchat instance with correct properties', () {
      final action = Snapchat.open(fallbackToStore: true);

      expect(action.customScheme, 'snapchat');
      expect(action.androidPackageName, 'com.snapchat.android');
      expect(action.website.toString(), 'https://www.snapchat.com');
      expect(action.fallbackToStore, true);
    });

    test('store actions have correct properties', () {
      final storeActions = Snapchat().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.snapchat.android');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '447188370');
      expect(iosStoreAction.appName, 'snapchat');

      final microsoftStoreAction = storeActions[2] as MicrosoftStoreOpenAppPageAction;
      expect(microsoftStoreAction.productId, '9pf9rtkmmq69');
    });

    test('openProfile action stores parameters correctly', () {
      final action = Snapchat.openProfile(username: 'snapchat', fallbackToStore: true);

      expect(action.username, 'snapchat');
      expect(action.fallbackToStore, true);
    });
  });
}

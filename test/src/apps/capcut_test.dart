import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CapCut Actions', () {
    test('open action creates CapCut instance with correct properties', () {
      final action = CapCut.open();

      expect(action.customScheme, 'capcut');
      expect(action.androidPackageName, 'com.lemon.lvoverseas');
      expect(action.website.toString(), 'https://www.capcut.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 3);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 3);
    });

    test('open action creates correct type', () {
      final action = CapCut.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openTemplate action creates correct type', () {
      final action = CapCut.openTemplate(templateLink: Uri.parse('https://www.capcut.com/template-detail/example/1'));

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openTemplate action creates correct URIs', () {
      final action = CapCut.openTemplate(templateLink: Uri.parse('https://www.capcut.com/template-detail/example/1'));

      expect(action.universalLink.toString(), 'https://www.capcut.com/template-detail/example/1');
      expect(action.fallbackLink.toString(), 'https://www.capcut.com/template-detail/example/1');
    });

    test('open action with fallbackToStore creates CapCut instance with correct properties', () {
      final action = CapCut.open(fallbackToStore: true);

      expect(action.customScheme, 'capcut');
      expect(action.androidPackageName, 'com.lemon.lvoverseas');
      expect(action.website.toString(), 'https://www.capcut.com');
      expect(action.fallbackToStore, true);
    });

    test('store actions have correct properties', () {
      final storeActions = CapCut().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.lemon.lvoverseas');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '1500855883');
      expect(iosStoreAction.appName, 'capcut-photo-video-editor');

      final microsoftStoreAction = storeActions[2] as MicrosoftStoreOpenAppPageAction;
      expect(microsoftStoreAction.productId, 'xp9kn75rrb9nhs');
    });

    test('openTemplate action stores parameters correctly', () {
      final link = Uri.parse('https://www.capcut.com/template-detail/example/1');
      final action = CapCut.openTemplate(templateLink: link, fallbackToStore: true);

      expect(action.templateLink, link);
      expect(action.fallbackToStore, true);
    });
  });
}

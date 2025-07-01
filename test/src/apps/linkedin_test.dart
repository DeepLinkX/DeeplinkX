import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/linkedin.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/universal_link_app_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinkedIn Actions', () {
    test('open action creates LinkedIn instance with correct properties', () {
      final action = LinkedIn.open();

      // As App
      expect(action.customScheme, 'linkedin');
      expect(action.androidPackageName, 'com.linkedin.android');
      expect(action.website.toString(), 'https://www.linkedin.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates LinkedIn instance with correct type', () {
      final action = LinkedIn.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfile action creates correct type', () {
      final action = LinkedIn.openProfile(
        profileId: 'john-doe',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfile action creates correct URIs', () {
      final action = LinkedIn.openProfile(
        profileId: 'john-doe',
      );

      expect(
        action.universalLink.toString(),
        'https://www.linkedin.com/in/john-doe',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.linkedin.com/in/john-doe',
      );
    });

    test('openCompany action creates correct type', () {
      final action = LinkedIn.openCompany(
        companyId: 'example-company',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openCompany action creates correct URIs', () {
      final action = LinkedIn.openCompany(
        companyId: 'example-company',
      );

      expect(
        action.universalLink.toString(),
        'https://www.linkedin.com/company/example-company',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.linkedin.com/company/example-company',
      );
    });

    test(
        'open action with fallbackToStore creates LinkedIn instance with correct properties',
        () {
      final action = LinkedIn.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'linkedin');
      expect(action.androidPackageName, 'com.linkedin.android');
      expect(action.website.toString(), 'https://www.linkedin.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 2);
    });

    test('store actions have correct properties', () {
      final linkedin = LinkedIn();
      final storeActions = linkedin.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.linkedin.android');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '288429040');
      expect(iosStoreAction.appName, 'linkedin-network-job-finder');
    });

    test('openProfile action stores parameters correctly', () {
      final action = LinkedIn.openProfile(
        profileId: 'john-doe',
        fallbackToStore: true,
      );

      expect(action.profileId, 'john-doe');
      expect(action.fallbackToStore, true);
    });

    test('openCompany action stores parameters correctly', () {
      final action = LinkedIn.openCompany(
        companyId: 'example-company',
        fallbackToStore: true,
      );

      expect(action.companyId, 'example-company');
      expect(action.fallbackToStore, true);
    });
  });
}

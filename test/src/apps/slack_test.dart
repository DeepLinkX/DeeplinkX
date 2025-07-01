import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/mac_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/microsoft_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/slack.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Slack Actions', () {
    test('open action creates Slack instance with correct properties', () {
      final action = Slack.open();

      expect(action.customScheme, 'slack');
      expect(action.androidPackageName, 'com.Slack');
      expect(action.website.toString(), 'https://slack.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.macos));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 4);
      expect(action.macosBundleIdentifier, 'com.tinyspeck.slackmacgap');

      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 4);
    });

    test('open action creates Slack instance with correct type', () {
      final action = Slack.open();

      expect(action, isA<App>());
      expect(action, isA<DownloadableApp>());
    });

    test('openTeam action creates correct URIs', () {
      final action = Slack.openTeam(teamId: 'T123');

      expect(action.appLink.toString(), 'slack://open?team=T123');
      expect(action.fallbackLink.toString(), 'https://app.slack.com/client/T123');
    });

    test('openChannel action creates correct URIs', () {
      final action = Slack.openChannel(teamId: 'T123', channelId: 'C456');

      expect(action.appLink.toString(), 'slack://channel?team=T123&id=C456');
      expect(action.fallbackLink.toString(), 'https://app.slack.com/client/T123/C456');
    });

    test('openUser action creates correct URIs', () {
      final action = Slack.openUser(teamId: 'T123', userId: 'U789');

      expect(action.appLink.toString(), 'slack://user?team=T123&id=U789');
      expect(action.fallbackLink.toString(), 'https://app.slack.com/client/T123/U789');
    });

    test('store actions have correct properties', () {
      final slack = Slack();
      final storeActions = slack.storeActions;

      expect(storeActions[0], isA<PlayStoreOpenAppPageAction>());
      expect(storeActions[1], isA<IOSAppStoreOpenAppPageAction>());
      expect(storeActions[2], isA<MicrosoftStoreOpenAppPageAction>());
      expect(storeActions[3], isA<MacAppStoreOpenAppPageAction>());
    });
  });
}

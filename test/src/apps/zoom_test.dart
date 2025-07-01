import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/microsoft_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/zoom.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Zoom Actions', () {
    test('open action creates Zoom instance with correct properties', () {
      final action = Zoom.open();

      // As App
      expect(action.customScheme, 'zoomus');
      expect(action.androidPackageName, 'us.zoom.videomeetings');
      expect(action.website.toString(), 'https://zoom.us');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.macos));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms, contains(PlatformType.linux));
      expect(action.supportedPlatforms.length, 5);
      expect(action.macosBundleIdentifier, 'us.zoom.xos');

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 3);
    });

    test('open action creates Zoom instance with correct type', () {
      final action = Zoom.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('joinMeeting action creates correct type', () {
      final action = Zoom.joinMeeting(meetingId: '123');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('joinMeeting action creates correct URIs', () {
      final action = Zoom.joinMeeting(meetingId: '123', password: 'abc');

      expect(
        action.appLink.toString(),
        'zoomus://zoom.us/join?confno=123&pwd=abc',
      );
      expect(
        action.fallbackLink.toString(),
        'https://zoom.us/j/123?pwd=abc',
      );
    });

    test('joinMeeting action with display name creates correct URIs', () {
      final action = Zoom.joinMeeting(
        meetingId: '123',
        password: 'abc',
        displayName: 'John Doe',
      );

      expect(
        action.appLink.toString(),
        'zoomus://zoom.us/join?confno=123&pwd=abc&uname=John+Doe',
      );
      expect(
        action.fallbackLink.toString(),
        'https://zoom.us/j/123?pwd=abc&uname=John+Doe',
      );
    });

    test(
        'joinMeeting action with special characters in display name creates correct URIs',
        () {
      final action = Zoom.joinMeeting(
        meetingId: '123',
        password: 'abc',
        displayName: 'John & Jane',
      );

      expect(
        action.appLink.toString(),
        'zoomus://zoom.us/join?confno=123&pwd=abc&uname=John+%26+Jane',
      );
      expect(
        action.fallbackLink.toString(),
        'https://zoom.us/j/123?pwd=abc&uname=John+%26+Jane',
      );
    });

    test(
        'open action with fallbackToStore creates Zoom instance with correct properties',
        () {
      final action = Zoom.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'zoomus');
      expect(action.androidPackageName, 'us.zoom.videomeetings');
      expect(action.website.toString(), 'https://zoom.us');

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 3);
    });

    test('store actions have correct properties', () {
      final zoom = Zoom();
      final storeActions = zoom.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'us.zoom.videomeetings');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '546505307');
      expect(iosStoreAction.appName, 'zoom-cloud-meetings');

      // Mac App Store action
      final macStoreAction = storeActions[2] as MicrosoftStoreOpenAppPageAction;
      expect(macStoreAction.productId, 'xp99j3kp4xz4vv');
    });

    test('actions store parameters correctly with fallbackToStore', () {
      final joinAction = Zoom.joinMeeting(
        meetingId: '123',
        password: 'abc',
        displayName: 'John Doe',
        fallbackToStore: true,
      );
      expect(joinAction.meetingId, '123');
      expect(joinAction.password, 'abc');
      expect(joinAction.displayName, 'John Doe');
      expect(joinAction.fallbackToStore, true);
    });
  });
}

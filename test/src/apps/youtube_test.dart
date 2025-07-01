import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('YouTube Actions', () {
    test('open action creates YouTube instance with correct properties', () {
      final action = YouTube.open();

      // As App
      expect(action.customScheme, 'youtube');
      expect(action.androidPackageName, 'com.google.android.youtube');
      expect(action.website.toString(), 'https://www.youtube.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 3);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 3);
    });

    test('open action creates YouTube instance with correct type', () {
      final action = YouTube.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openVideo action creates correct type', () {
      final action = YouTube.openVideo(
        videoId: 'dQw4w9WgXcQ',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openVideo action creates correct URIs', () {
      final action = YouTube.openVideo(
        videoId: 'dQw4w9WgXcQ',
      );

      expect(
        action.universalLink.toString(),
        'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      );
    });

    test('openChannel action creates correct type', () {
      final action = YouTube.openChannel(
        channelId: 'UCq-Fj5jknLsUf-MWSy4_brA',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openChannel action creates correct URIs', () {
      final action = YouTube.openChannel(
        channelId: 'UCq-Fj5jknLsUf-MWSy4_brA',
      );

      expect(
        action.universalLink.toString(),
        'https://www.youtube.com/channel/UCq-Fj5jknLsUf-MWSy4_brA',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.youtube.com/channel/UCq-Fj5jknLsUf-MWSy4_brA',
      );
    });

    test('openPlaylist action creates correct type', () {
      final action = YouTube.openPlaylist(
        playlistId: 'PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openPlaylist action creates correct URIs', () {
      final action = YouTube.openPlaylist(
        playlistId: 'PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI',
      );

      expect(
        action.universalLink.toString(),
        'https://www.youtube.com/playlist?list=PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.youtube.com/playlist?list=PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI',
      );
    });

    test('search action creates correct type', () {
      final action = YouTube.search(
        query: 'flutter tutorial',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('search action creates correct URIs', () {
      final action = YouTube.search(
        query: 'flutter tutorial',
      );

      expect(
        action.universalLink.toString(),
        'https://www.youtube.com/results?search_query=flutter+tutorial',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.youtube.com/results?search_query=flutter+tutorial',
      );
    });

    test(
        'open action with fallbackToStore creates YouTube instance with correct properties',
        () {
      final action = YouTube.open(fallbackToStore: true);

      // As App
      expect(action.customScheme, 'youtube');
      expect(action.androidPackageName, 'com.google.android.youtube');
      expect(action.website.toString(), 'https://www.youtube.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms, contains(PlatformType.windows));
      expect(action.supportedPlatforms.length, 3);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 3);
    });

    test('store actions have correct properties', () {
      final youtube = YouTube();
      final storeActions = youtube.storeActions;

      // Play Store action
      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.google.android.youtube');

      // iOS App Store action
      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '544007664');
      expect(iosStoreAction.appName, 'youtube');

      // Microsoft Store action
      final microsoftStoreAction =
          storeActions[2] as MicrosoftStoreOpenAppPageAction;
      expect(microsoftStoreAction.productId, '9wzdncrfj2wl');
    });
  });
}

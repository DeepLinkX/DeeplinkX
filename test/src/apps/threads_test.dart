import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/threads.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/universal_link_app_action_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Threads Actions', () {
    test('open action creates Threads instance with correct properties', () {
      final action = Threads.open();

      expect(action.customScheme, 'barcelona');
      expect(action.androidPackageName, 'com.instagram.barcelona');
      expect(action.website.toString(), 'https://www.threads.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates Threads instance with correct type', () {
      final action = Threads.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('openProfile action creates correct type', () {
      final action = Threads.openProfile(username: 'zuck');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openProfile action creates correct URIs', () {
      final action = Threads.openProfile(username: 'zuck');

      expect(
        action.appLink.toString(),
        'barcelona://user?username=zuck',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.threads.com/@zuck',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'https://www.threads.com/@zuck');
      expect(action.androidIntentOptions.package, 'com.instagram.barcelona');
    });

    test('openPost action creates correct type', () {
      final action = Threads.openPost(
        username: 'zuck',
        postId: 'CuN0hdYv8Lq',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openPost action creates correct URIs', () {
      final action = Threads.openPost(
        username: 'zuck',
        postId: 'CuN0hdYv8Lq',
      );

      expect(
        action.appLink.toString(),
        'barcelona://media?shortcode=CuN0hdYv8Lq',
      );
      expect(
        action.universalLink.toString(),
        'https://www.threads.com/@zuck/post/CuN0hdYv8Lq',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.threads.com/@zuck/post/CuN0hdYv8Lq',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'https://www.threads.com/@zuck/post/CuN0hdYv8Lq',
      );
      expect(action.androidIntentOptions.package, 'com.instagram.barcelona');
    });

    test('openComments action creates correct type', () {
      final action = Threads.openComments(
        username: 'zuck',
        postId: 'CuN0hdYv8Lq',
      );

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('openComments action creates correct URIs', () {
      final action = Threads.openComments(
        username: 'zuck',
        postId: 'CuN0hdYv8Lq',
      );

      expect(
        action.appLink.toString(),
        'barcelona://media?shortcode=CuN0hdYv8Lq',
      );
      expect(
        action.universalLink.toString(),
        'https://www.threads.com/@zuck/post/CuN0hdYv8Lq',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.threads.com/@zuck/post/CuN0hdYv8Lq',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'https://www.threads.com/@zuck/post/CuN0hdYv8Lq',
      );
      expect(action.androidIntentOptions.package, 'com.instagram.barcelona');
    });

    test('createPost action creates correct type', () {
      final action = Threads.createPost(text: 'Hello from Threads');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('createPost action creates correct URIs and intent payload', () {
      final action = Threads.createPost(text: 'Hello from Threads');

      expect(
        action.appLink.toString(),
        'barcelona://create?text=Hello+from+Threads',
      );
      expect(
        action.fallbackLink.toString(),
        'https://www.threads.com/intent/post?text=Hello+from+Threads',
      );
      expect(action.androidIntentOptions.action, 'android.intent.action.SEND');
      expect(action.androidIntentOptions.package, 'com.instagram.barcelona');
      expect(action.androidIntentOptions.type, 'text/plain');
      expect(
        action.androidIntentOptions.arguments,
        {'android.intent.extra.TEXT': 'Hello from Threads'},
      );
    });

    test('open action with fallbackToStore creates Threads instance with correct properties', () {
      final action = Threads.open(fallbackToStore: true);

      expect(action.customScheme, 'barcelona');
      expect(action.androidPackageName, 'com.instagram.barcelona');
      expect(action.website.toString(), 'https://www.threads.com');

      expect(action.fallbackToStore, true);
      expect(action.storeActions.length, 2);
    });

    test('store actions have correct properties', () {
      final threads = Threads();
      final storeActions = threads.storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.instagram.barcelona');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '6446901002');
      expect(iosStoreAction.appName, 'threads-an-instagram-app');
    });

    test('actions store parameters correctly with fallbackToStore', () {
      final profileAction = Threads.openProfile(
        username: 'zuck',
        fallbackToStore: true,
      );
      expect(profileAction.username, 'zuck');
      expect(profileAction.fallbackToStore, true);

      final postAction = Threads.openPost(
        username: 'zuck',
        postId: 'CuN0hdYv8Lq',
        fallbackToStore: true,
      );
      expect(postAction.username, 'zuck');
      expect(postAction.postId, 'CuN0hdYv8Lq');
      expect(postAction.fallbackToStore, true);

      final commentsAction = Threads.openComments(
        username: 'zuck',
        postId: 'CuN0hdYv8Lq',
        fallbackToStore: true,
      );
      expect(commentsAction.username, 'zuck');
      expect(commentsAction.postId, 'CuN0hdYv8Lq');
      expect(commentsAction.fallbackToStore, true);

      final createPostAction = Threads.createPost(
        text: 'Hello from Threads',
        fallbackToStore: true,
      );
      expect(createPostAction.text, 'Hello from Threads');
      expect(createPostAction.fallbackToStore, true);
    });
  });
}

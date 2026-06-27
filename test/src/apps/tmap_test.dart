import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/tmap.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TMap Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = TMap.open();

      expect(action.customScheme, 'tmap');
      expect(action.androidPackageName, 'com.skt.tmap.ku');
      expect(action.website.toString(), 'https://www.tmap.co.kr/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = TMap.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = TMap().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.skt.tmap.ku');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '431589174');
      expect(iosStoreAction.appName, 'tmap');
    });

    test('view action builds app link, Android intent, and fallback', () {
      final action = TMap.view(
        coordinate: const Coordinate(latitude: 37.5665, longitude: 126.9780),
        title: 'Seoul City Hall',
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, const Coordinate(latitude: 37.5665, longitude: 126.9780));
      expect(action.title, 'Seoul City Hall');
      expect(action.appLink.toString(), 'tmap://viewmap?name=Seoul+City+Hall&x=126.978&y=37.5665');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'tmap://viewmap?name=Seoul+City+Hall&x=126.978&y=37.5665');
      expect(action.androidIntentOptions.package, 'com.skt.tmap.ku');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://www.tmap.co.kr/');
    });

    test('view action omits title', () {
      final action = TMap.view(
        coordinate: const Coordinate(latitude: 37.5665, longitude: 126.9780),
      );

      expect(action.title, null);
      expect(action.appLink.toString(), 'tmap://viewmap?x=126.978&y=37.5665');
    });

    test('directionsWithCoords action builds route with origin and labels', () {
      final action = TMap.directionsWithCoords(
        origin: const Coordinate(latitude: 37.5665, longitude: 126.9780),
        originTitle: 'City Hall',
        destination: const Coordinate(latitude: 37.5547, longitude: 126.9706),
        destinationTitle: 'Seoul Station',
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, const Coordinate(latitude: 37.5665, longitude: 126.9780));
      expect(action.originTitle, 'City Hall');
      expect(action.destination, const Coordinate(latitude: 37.5547, longitude: 126.9706));
      expect(action.destinationTitle, 'Seoul Station');
      expect(
        action.appLink.toString(),
        'tmap://route?startname=City+Hall&startx=126.978&starty=37.5665&goalname=Seoul+Station&goaly=37.5547&goalx=126.9706&carType=1',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'tmap://route?startname=City+Hall&startx=126.978&starty=37.5665&goalname=Seoul+Station&goaly=37.5547&goalx=126.9706&carType=1',
      );
      expect(action.androidIntentOptions.package, 'com.skt.tmap.ku');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://www.tmap.co.kr/');
    });

    test('directionsWithCoords action supports current-location origin', () {
      final action = TMap.directionsWithCoords(
        destination: const Coordinate(latitude: 37.5547, longitude: 126.9706),
      );

      expect(action.origin, null);
      expect(action.originTitle, null);
      expect(action.destinationTitle, null);
      expect(action.appLink.toString(), 'tmap://route?goaly=37.5547&goalx=126.9706&carType=1');
    });

    test('actions keep fallback flag', () {
      final viewAction = TMap.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final directionsAction = TMap.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsAction.fallbackToStore, true);
    });
  });
}

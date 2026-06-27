import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/kakao_map.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('KakaoMap Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = KakaoMap.open();

      expect(action.customScheme, 'kakaomap');
      expect(action.androidPackageName, 'net.daum.android.map');
      expect(action.website.toString(), 'https://map.kakao.com/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = KakaoMap.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = KakaoMap().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'net.daum.android.map');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '304608425');
      expect(iosStoreAction.appName, 'kakaomap-korea-no-1-map');
    });

    test('view action builds app link, Android intent, and fallback', () {
      final action = KakaoMap.view(
        coordinate: const Coordinate(latitude: 37.5665, longitude: 126.9780),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, const Coordinate(latitude: 37.5665, longitude: 126.9780));
      expect(action.appLink.toString(), 'kakaomap://look?p=37.5665%2C126.978');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'kakaomap://look?p=37.5665%2C126.978');
      expect(action.androidIntentOptions.package, 'net.daum.android.map');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://map.kakao.com/');
    });

    test('directionsWithCoords action builds route with origin', () {
      final action = KakaoMap.directionsWithCoords(
        origin: const Coordinate(latitude: 37.5665, longitude: 126.9780),
        destination: const Coordinate(latitude: 37.5547, longitude: 126.9706),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, const Coordinate(latitude: 37.5665, longitude: 126.9780));
      expect(action.destination, const Coordinate(latitude: 37.5547, longitude: 126.9706));
      expect(
        action.appLink.toString(),
        'kakaomap://route?sp=37.5665%2C126.978&ep=37.5547%2C126.9706',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'kakaomap://route?sp=37.5665%2C126.978&ep=37.5547%2C126.9706',
      );
      expect(action.androidIntentOptions.package, 'net.daum.android.map');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://map.kakao.com/');
    });

    test('directionsWithCoords action supports current-location origin', () {
      final action = KakaoMap.directionsWithCoords(
        destination: const Coordinate(latitude: 37.5547, longitude: 126.9706),
      );

      expect(action.origin, null);
      expect(action.appLink.toString(), 'kakaomap://route?ep=37.5547%2C126.9706');
    });

    test('actions keep fallback flag', () {
      final viewAction = KakaoMap.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final directionsAction = KakaoMap.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsAction.fallbackToStore, true);
    });
  });
}

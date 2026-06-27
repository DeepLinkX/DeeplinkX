import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/naver_map.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NAVER Map Actions', () {
    const origin = Coordinate(latitude: 37.5665, longitude: 126.9780);
    const destination = Coordinate(latitude: 37.5547, longitude: 126.9706);

    test('open action exposes metadata and store actions', () {
      final action = NaverMap.open();

      expect(action.customScheme, 'nmap');
      expect(action.androidPackageName, 'com.nhn.android.nmap');
      expect(action.website.toString(), 'https://map.naver.com/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = NaverMap().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.nhn.android.nmap');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '311867728');
      expect(iosStoreAction.appName, 'naver-maps-navigation');
    });

    test('view action creates place link, Android intent, and fallback', () {
      final action = NaverMap.view(
        coordinate: destination,
        title: 'Seoul Station',
        zoom: 15,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.title, 'Seoul Station');
      expect(action.zoom, 15);
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), 'nmap://place?lat=37.5547&lng=126.9706&zoom=15&name=Seoul+Station');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'com.nhn.android.nmap');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink.toString(), 'https://map.naver.com/');
    });

    test('view action omits empty title and uses default zoom', () {
      final action = NaverMap.view(coordinate: destination, title: '');

      expect(action.title, '');
      expect(action.zoom, 16);
      expect(action.appLink.toString(), 'nmap://place?lat=37.5547&lng=126.9706&zoom=16');
    });

    test('directionsWithCoords action creates route link, Android intent, and fallback', () {
      final action = NaverMap.directionsWithCoords(
        destination: destination,
        origin: origin,
        destinationTitle: 'Seoul Station',
        originTitle: 'City Hall',
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, destination);
      expect(action.origin, origin);
      expect(action.destinationTitle, 'Seoul Station');
      expect(action.originTitle, 'City Hall');
      expect(action.fallbackToStore, true);
      expect(
        action.appLink.toString(),
        'nmap://route/car?slat=37.5665&slng=126.978&sname=City+Hall&dlat=37.5547&dlng=126.9706&dname=Seoul+Station',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.androidIntentOptions.package, 'com.nhn.android.nmap');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://map.naver.com/');
    });

    test('directionsWithCoords action supports current-location origin', () {
      final action = NaverMap.directionsWithCoords(destination: destination);

      expect(action.origin, null);
      expect(action.destinationTitle, null);
      expect(action.originTitle, null);
      expect(action.appLink.toString(), 'nmap://route/car?dlat=37.5547&dlng=126.9706');
    });
  });
}

import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/tomtom_go.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TomTom Go Actions', () {
    const destination = Coordinate(latitude: 52.5163, longitude: 13.3777);

    test('open action exposes metadata and store actions', () {
      final action = TomTomGo.open();

      expect(action.customScheme, 'tomtomgo');
      expect(action.androidPackageName, 'com.tomtom.gplay.navapp');
      expect(action.website.toString(), 'https://www.tomtom.com/navigation/mobile-apps/go-navigation-app/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = TomTomGo().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.tomtom.gplay.navapp');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '884963367');
      expect(iosStoreAction.appName, 'tomtom-go-expert-truck-gps');
    });

    test('view action creates iOS navigation link, Android geo intent, and fallback', () {
      final action = TomTomGo.view(
        coordinate: destination,
        title: 'Brandenburg Gate',
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.title, 'Brandenburg Gate');
      expect(action.fallbackToStore, true);
      expect(action.appLink.scheme, 'tomtomgo');
      expect(action.appLink.host, 'x-callback-url');
      expect(action.appLink.path, '/navigate');
      expect(action.appLink.queryParameters['destination'], '52.5163,13.3777');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'com.tomtom.gplay.navapp');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(
        action.androidIntentOptions.data,
        'geo:52.5163,13.3777?q=52.5163,13.3777(Brandenburg%20Gate)',
      );
      expect(action.fallbackLink.toString(), 'https://www.tomtom.com/navigation/mobile-apps/go-navigation-app/');
    });

    test('view action supports title-less Android geo intent', () {
      final action = TomTomGo.view(coordinate: destination);

      expect(action.title, null);
      expect(action.androidIntentOptions.data, 'geo:52.5163,13.3777?q=52.5163,13.3777');
    });

    test('directionsWithCoords action creates iOS navigation link, Android navigation intent, and fallback', () {
      final action = TomTomGo.directionsWithCoords(
        destination: destination,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, destination);
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), 'tomtomgo://x-callback-url/navigate?destination=52.5163%2C13.3777');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'google.navigation:q=52.5163,13.3777');
      expect(action.androidIntentOptions.package, 'com.tomtom.gplay.navapp');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://www.tomtom.com/navigation/mobile-apps/go-navigation-app/');
    });
  });
}

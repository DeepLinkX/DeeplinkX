import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/mappls.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Mappls Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = Mappls.open();

      expect(action.customScheme, 'mappls');
      expect(action.androidPackageName, 'com.mmi.maps');
      expect(action.website.toString(), 'https://www.mappls.com/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = Mappls.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = Mappls().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.mmi.maps');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '723492531');
      expect(iosStoreAction.appName, 'mappls-mapmyindia-maps');
    });

    test('view action builds web app link, Android intent, and fallback', () {
      final action = Mappls.view(
        coordinate: const Coordinate(latitude: 28.6139, longitude: 77.2090),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, const Coordinate(latitude: 28.6139, longitude: 77.2090));
      expect(action.appLink.toString(), 'https://www.mappls.com/location/28.6139,77.209');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'https://www.mappls.com/location/28.6139,77.209');
      expect(action.androidIntentOptions.package, 'com.mmi.maps');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), action.appLink.toString());
    });

    test('directionsWithCoords action builds route with title and mode', () {
      final action = Mappls.directionsWithCoords(
        destination: const Coordinate(latitude: 28.6129, longitude: 77.2295),
        destinationTitle: 'India Gate',
        mode: MapplsTravelMode.walking,
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, const Coordinate(latitude: 28.6129, longitude: 77.2295));
      expect(action.destinationTitle, 'India Gate');
      expect(action.mode, MapplsTravelMode.walking);
      expect(
        action.appLink.toString(),
        'https://mappls.com/navigation?places=28.6129%2C77.2295%2CIndia+Gate&mode=walking',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'https://mappls.com/navigation?places=28.6129%2C77.2295%2CIndia+Gate&mode=walking',
      );
      expect(action.androidIntentOptions.package, 'com.mmi.maps');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), action.appLink.toString());
    });

    test('directionsWithCoords action supports default and alternate modes', () {
      final defaultAction = Mappls.directionsWithCoords(
        destination: const Coordinate(latitude: 28.6129, longitude: 77.2295),
      );
      final bicyclingAction = Mappls.directionsWithCoords(
        destination: const Coordinate(latitude: 28.6129, longitude: 77.2295),
        mode: MapplsTravelMode.bicycling,
      );
      final transitAction = Mappls.directionsWithCoords(
        destination: const Coordinate(latitude: 28.6129, longitude: 77.2295),
        mode: MapplsTravelMode.transit,
      );

      expect(defaultAction.destinationTitle, null);
      expect(defaultAction.mode, MapplsTravelMode.driving);
      expect(defaultAction.appLink.toString(), 'https://mappls.com/navigation?places=28.6129%2C77.2295&mode=driving');
      expect(bicyclingAction.appLink.toString(), 'https://mappls.com/navigation?places=28.6129%2C77.2295&mode=biking');
      expect(transitAction.appLink.toString(), 'https://mappls.com/navigation?places=28.6129%2C77.2295&mode=d');
    });

    test('directionsWithCoords action ignores empty title', () {
      final action = Mappls.directionsWithCoords(
        destination: const Coordinate(latitude: 28.6129, longitude: 77.2295),
        destinationTitle: '',
      );

      expect(action.destinationTitle, '');
      expect(action.appLink.toString(), 'https://mappls.com/navigation?places=28.6129%2C77.2295&mode=driving');
    });

    test('actions keep fallback flag', () {
      final viewAction = Mappls.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final directionsAction = Mappls.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsAction.fallbackToStore, true);
    });
  });
}

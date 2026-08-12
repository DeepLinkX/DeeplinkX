import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/tomtom_go_fleet.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TomTom Go Fleet Actions', () {
    const destination = Coordinate(latitude: 52.5163, longitude: 13.3777);

    test('open action exposes metadata and store actions', () {
      final action = TomTomGoFleet.open();

      expect(action.customScheme, 'tomtomgofleet');
      expect(action.androidPackageName, 'com.tomtom.gplay.navapp.gofleet');
      expect(action.website.toString(), 'https://www.tomtom.com/solutions/fleet-management-logistics/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 1);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = TomTomGoFleet().storeActions;

      final playStoreAction = storeActions.single as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.tomtom.gplay.navapp.gofleet');
    });

    test('view action creates geo app link, Android geo intent, and fallback', () {
      final action = TomTomGoFleet.view(
        coordinate: destination,
        title: 'Fleet Yard',
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.title, 'Fleet Yard');
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), 'geo:52.5163,13.3777?q=52.5163,13.3777Fleet%20Yard');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'com.tomtom.gplay.navapp.gofleet');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.androidIntentOptions.data, 'geo:52.5163,13.3777?q=52.5163,13.3777Fleet%20Yard');
      expect(action.fallbackLink.toString(), 'https://www.tomtom.com/solutions/fleet-management-logistics/');
    });

    test('view action supports title-less geo link', () {
      final action = TomTomGoFleet.view(coordinate: destination);

      expect(action.title, null);
      expect(action.appLink.toString(), 'geo:52.5163,13.3777?q=52.5163,13.3777');
    });

    test('directionsWithCoords action creates navigation link, Android navigation intent, and fallback', () {
      final action = TomTomGoFleet.directionsWithCoords(
        destination: destination,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, destination);
      expect(action.fallbackToStore, true);
      expect(action.appLink.toString(), 'google.navigation:?q=52.5163,13.3777');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'google.navigation:?q=52.5163,13.3777');
      expect(action.androidIntentOptions.package, 'com.tomtom.gplay.navapp.gofleet');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://www.tomtom.com/solutions/fleet-management-logistics/');
    });
  });
}

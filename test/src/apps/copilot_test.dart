import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/copilot.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoPilot Actions', () {
    const destination = Coordinate(latitude: 52.5163, longitude: 13.3777);

    test('open action exposes metadata and store actions', () {
      final action = Copilot.open();

      expect(action.customScheme, 'copilot');
      expect(action.androidPackageName, 'com.alk.copilot.mapviewer');
      expect(action.website.toString(), 'https://copilotgps.com/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = Copilot().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.alk.copilot.mapviewer');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '504677517');
      expect(iosStoreAction.appName, 'copilot-gps-navigation');
    });

    test('view action creates app link, Android intent, and fallback', () {
      final action = Copilot.view(
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
      expect(
        action.appLink.toString(),
        'copilot://mydestination?type=LOCATION&action=VIEW&marker=52.5163%2C13.3777&name=Fleet+Yard',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'com.alk.copilot.mapviewer');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.fallbackLink.toString(), 'https://copilotgps.com/');
    });

    test('view action omits empty title', () {
      final action = Copilot.view(coordinate: destination, title: '');

      expect(action.title, '');
      expect(action.appLink.toString(), 'copilot://mydestination?type=LOCATION&action=VIEW&marker=52.5163%2C13.3777');
    });

    test('directionsWithCoords action creates app link, Android intent, and fallback', () {
      final action = Copilot.directionsWithCoords(
        destination: destination,
        destinationTitle: 'Warehouse',
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, destination);
      expect(action.destinationTitle, 'Warehouse');
      expect(action.fallbackToStore, true);
      expect(
        action.appLink.toString(),
        'copilot://mydestination?type=LOCATION&action=GOTO&name=Warehouse&lat=52.5163&long=13.3777',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, action.appLink.toString());
      expect(action.androidIntentOptions.package, 'com.alk.copilot.mapviewer');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://copilotgps.com/');
    });

    test('directionsWithCoords action omits missing destination title', () {
      final action = Copilot.directionsWithCoords(destination: destination);

      expect(action.destinationTitle, null);
      expect(action.appLink.toString(), 'copilot://mydestination?type=LOCATION&action=GOTO&lat=52.5163&long=13.3777');
    });
  });
}

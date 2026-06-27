import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/mapy_cz.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapyCz Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = MapyCz.open();

      expect(action.customScheme, 'szn-mapy');
      expect(action.androidPackageName, 'cz.seznam.mapy');
      expect(action.website.toString(), 'https://mapy.cz/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = MapyCz.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = MapyCz().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'cz.seznam.mapy');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '411411020');
      expect(iosStoreAction.appName, 'mapy-com-maps-gps-offline');
    });

    test('view action builds web app link, Android intent, and fallback', () {
      final action = MapyCz.view(
        coordinate: const Coordinate(latitude: 50.0755, longitude: 14.4378),
        zoom: 15,
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, const Coordinate(latitude: 50.0755, longitude: 14.4378));
      expect(action.zoom, 15);
      expect(action.appLink.toString(), 'https://mapy.cz/zakladni?id=14.4378%2C50.0755&z=15&source=coor');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'https://mapy.cz/zakladni?id=14.4378%2C50.0755&z=15&source=coor',
      );
      expect(action.androidIntentOptions.package, 'cz.seznam.mapy');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), action.appLink.toString());
    });

    test('view action uses default zoom', () {
      final action = MapyCz.view(
        coordinate: const Coordinate(latitude: 50.0755, longitude: 14.4378),
      );

      expect(action.zoom, 16);
      expect(action.appLink.toString(), 'https://mapy.cz/zakladni?id=14.4378%2C50.0755&z=16&source=coor');
    });

    test('directionsWithCoords action builds coordinate link', () {
      final action = MapyCz.directionsWithCoords(
        destination: const Coordinate(latitude: 50.0755, longitude: 14.4378),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, const Coordinate(latitude: 50.0755, longitude: 14.4378));
      expect(action.appLink.toString(), 'https://mapy.cz/zakladni?id=14.4378%2C50.0755&source=coor');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'https://mapy.cz/zakladni?id=14.4378%2C50.0755&source=coor');
      expect(action.androidIntentOptions.package, 'cz.seznam.mapy');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), action.appLink.toString());
    });

    test('actions keep fallback flag', () {
      final viewAction = MapyCz.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final directionsAction = MapyCz.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsAction.fallbackToStore, true);
    });
  });
}

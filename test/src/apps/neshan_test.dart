import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/neshan.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Neshan Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = Neshan.open();

      expect(action.customScheme, 'neshan');
      expect(action.androidPackageName, 'org.rajman.neshan.traffic.tehran.navigator');
      expect(action.website.toString(), 'https://neshan.org/maps');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = Neshan.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = Neshan().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'org.rajman.neshan.traffic.tehran.navigator');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '1548188093');
      expect(iosStoreAction.appName, 'neshan-map');
    });

    test('view action builds iOS link, Android intent, and fallback', () {
      final action = Neshan.view(
        coordinate: const Coordinate(latitude: 35.6892, longitude: 51.3890),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, const Coordinate(latitude: 35.6892, longitude: 51.3890));
      expect(action.appLink.toString(), 'neshan://?destination=35.6892%2C51.389');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'https://nshn.ir?lat=35.6892&lng=51.389');
      expect(action.androidIntentOptions.package, 'org.rajman.neshan.traffic.tehran.navigator');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://neshan.org/maps/share/35.6892,51.389');
    });

    test('directionsWithCoords action builds route with origin', () {
      final action = Neshan.directionsWithCoords(
        origin: const Coordinate(latitude: 35.6892, longitude: 51.3890),
        destination: const Coordinate(latitude: 35.7000, longitude: 51.4000),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, const Coordinate(latitude: 35.6892, longitude: 51.3890));
      expect(action.destination, const Coordinate(latitude: 35.7000, longitude: 51.4000));
      expect(action.appLink.toString(), 'neshan://?origin=35.6892%2C51.389&destination=35.7%2C51.4');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'https://nshn.ir/?origin=35.6892%2C51.389&destination=35.7%2C51.4',
      );
      expect(action.androidIntentOptions.package, 'org.rajman.neshan.traffic.tehran.navigator');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://neshan.org/maps');
    });

    test('directionsWithCoords action supports current-location origin', () {
      final action = Neshan.directionsWithCoords(
        destination: const Coordinate(latitude: 35.7000, longitude: 51.4000),
      );

      expect(action.origin, null);
      expect(action.appLink.toString(), 'neshan://?destination=35.7%2C51.4');
      expect(
        action.androidIntentOptions.data,
        'https://nshn.ir/?destination=35.7%2C51.4',
      );
      expect(action.fallbackLink.toString(), 'https://neshan.org/maps');
    });

    test('actions keep fallback flag', () {
      final viewAction = Neshan.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final directionsAction = Neshan.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsAction.fallbackToStore, true);
    });
  });
}

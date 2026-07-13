import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/moovit.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Moovit Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = Moovit.open();

      expect(action.customScheme, 'moovit');
      expect(action.androidPackageName, 'com.tranzmate');
      expect(action.website.toString(), 'https://www.moovit.com/');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = Moovit.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = Moovit().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.tranzmate');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '498477945');
      expect(iosStoreAction.appName, 'moovit-bus-transit-tracker');
    });

    test('view action builds nearby link, Android intent, and fallback', () {
      final action = Moovit.view(
        coordinate: const Coordinate(latitude: 40.7128, longitude: -74.0060),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, const Coordinate(latitude: 40.7128, longitude: -74.0060));
      expect(action.partnerId, 'deeplink_x');
      expect(action.appLink.toString(), 'moovit://nearby?lat=40.7128&lon=-74.006&partner_id=deeplink_x');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'moovit://nearby?lat=40.7128&lon=-74.006&partner_id=deeplink_x');
      expect(action.androidIntentOptions.package, 'com.tranzmate');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://www.moovit.com/');
    });

    test('directionsWithCoords action builds route with origin and labels', () {
      final action = Moovit.directionsWithCoords(
        origin: const Coordinate(latitude: 40.7580, longitude: -73.9855),
        originTitle: 'Times Square',
        destination: const Coordinate(latitude: 40.7527, longitude: -73.9772),
        destinationTitle: 'Grand Central',
        partnerId: 'deeplink_x_tests',
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, const Coordinate(latitude: 40.7580, longitude: -73.9855));
      expect(action.originTitle, 'Times Square');
      expect(action.destination, const Coordinate(latitude: 40.7527, longitude: -73.9772));
      expect(action.destinationTitle, 'Grand Central');
      expect(action.partnerId, 'deeplink_x_tests');
      expect(
        action.appLink.toString(),
        'moovit://directions?dest_lat=40.7527&dest_lon=-73.9772&dest_name=Grand+Central&orig_lat=40.758&orig_lon=-73.9855&orig_name=Times+Square&partner_id=deeplink_x_tests',
      );
      expect(action.androidIntentOptions.action, 'action_view');
      expect(
        action.androidIntentOptions.data,
        'moovit://directions?dest_lat=40.7527&dest_lon=-73.9772&dest_name=Grand+Central&orig_lat=40.758&orig_lon=-73.9855&orig_name=Times+Square&partner_id=deeplink_x_tests',
      );
      expect(action.androidIntentOptions.package, 'com.tranzmate');
      expect(action.androidIntentOptions.flags, const [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://www.moovit.com/');
    });

    test('directionsWithCoords action supports current-location origin', () {
      final action = Moovit.directionsWithCoords(
        destination: const Coordinate(latitude: 40.7527, longitude: -73.9772),
      );

      expect(action.origin, null);
      expect(action.originTitle, null);
      expect(action.destinationTitle, null);
      expect(
        action.appLink.toString(),
        'moovit://directions?dest_lat=40.7527&dest_lon=-73.9772&partner_id=deeplink_x',
      );
    });

    test('rejects blank partner identifiers', () {
      expect(
        () => Moovit.view(
          coordinate: const Coordinate(latitude: 40.7128, longitude: -74.0060),
          partnerId: '   ',
        ),
        throwsArgumentError,
      );
      expect(
        () => Moovit.directionsWithCoords(
          destination: const Coordinate(latitude: 40.7527, longitude: -73.9772),
          partnerId: '',
        ),
        throwsArgumentError,
      );
    });

    test('actions keep fallback flag', () {
      final viewAction = Moovit.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final directionsAction = Moovit.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsAction.fallbackToStore, true);
    });
  });
}

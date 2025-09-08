import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/waze.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/universal_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Waze Actions', () {
    test('open action creates Waze instance with correct properties', () {
      final action = Waze.open();

      // As App
      expect(action.customScheme, 'waze');
      expect(action.androidPackageName, 'com.waze');
      expect(action.website.toString(), 'https://www.waze.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates Waze instance with correct type', () {
      final action = Waze.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('view action creates correct universal link', () {
      final action = Waze.view(
        coordinate: const Coordinate(latitude: 45.6906304, longitude: -120.810983),
      );

      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());

      expect(action.universalLink.scheme, 'https');
      expect(action.universalLink.host, 'waze.com');
      expect(action.universalLink.path, '/ul');
      expect(action.universalLink.queryParameters['ll'], '45.6906304,-120.810983');
      expect(action.universalLink.queryParameters.containsKey('q'), false);
      expect(action.universalLink.queryParameters.containsKey('z'), false);

      // fallback equals universal for view
      expect(action.fallbackLink.toString(), action.universalLink.toString());
    });

    test('search action creates correct universal link without fallback', () {
      final action = Waze.search(query: '66 Acacia Avenue');

      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action.universalLink.scheme, 'https');
      expect(action.universalLink.host, 'waze.com');
      expect(action.universalLink.path, '/ul');
      expect(action.universalLink.queryParameters['q'], '66 Acacia Avenue');
    });

    test('directions action creates correct universal link', () {
      final action = Waze.directions(destination: '66 Acacia Avenue', zoom: 8);

      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.universalLink.scheme, 'https');
      expect(action.universalLink.host, 'waze.com');
      expect(action.universalLink.path, '/ul');
      expect(action.universalLink.queryParameters['q'], '66 Acacia Avenue');
      expect(action.universalLink.queryParameters['navigate'], 'yes');
      expect(action.universalLink.queryParameters['z'], '8');
      expect(action.fallbackLink.toString(), action.universalLink.toString());
    });

    test('directionsWithCoords action creates correct universal link', () {
      final action = Waze.directionsWithCoords(
        destination: const Coordinate(latitude: 45.6906304, longitude: -120.810983),
        zoom: 8,
      );

      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.universalLink.scheme, 'https');
      expect(action.universalLink.host, 'waze.com');
      expect(action.universalLink.path, '/ul');
      expect(action.universalLink.queryParameters['ll'], '45.6906304,-120.810983');
      expect(action.universalLink.queryParameters['navigate'], 'yes');
      expect(action.universalLink.queryParameters['z'], '8');
      expect(action.fallbackLink.toString(), action.universalLink.toString());
    });

    test('store actions have correct properties', () {
      final waze = Waze();
      final storeActions = waze.storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.waze');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '323229106');
      expect(iosStoreAction.appName, 'waze-navigation-live-traffic');
    });

    test('actions store parameters correctly with fallbackToStore', () {
      final viewAction = Waze.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final searchAction = Waze.search(query: 'Main St', fallbackToStore: true);
      expect(searchAction.query, 'Main St');
      expect(searchAction.fallbackToStore, true);

      final directionsAction = Waze.directions(destination: 'Somewhere', fallbackToStore: true);
      expect(directionsAction.destination, 'Somewhere');
      expect(directionsAction.fallbackToStore, true);

      final directionsWithCoordsAction = Waze.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(directionsWithCoordsAction.destination.toString(), '1.0,2.0');
      expect(directionsWithCoordsAction.fallbackToStore, true);
    });
  });
}

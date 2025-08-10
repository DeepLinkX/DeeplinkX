import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/google_maps.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Google Maps Actions', () {
    test('open action creates GoogleMaps instance with correct properties', () {
      final action = GoogleMaps.open();

      // As App
      expect(action.customScheme, 'comgooglemaps');
      expect(action.androidPackageName, 'com.google.android.apps.maps');
      expect(action.website.toString(), 'https://maps.google.com');
      expect(action.supportedPlatforms, contains(PlatformType.android));
      expect(action.supportedPlatforms, contains(PlatformType.ios));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action creates GoogleMaps instance with correct type', () {
      final action = GoogleMaps.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('search action creates correct type', () {
      final action = GoogleMaps.search(query: '1600 Amphitheatre Parkway');

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
    });

    test('search action creates correct URIs', () {
      final action = GoogleMaps.search(query: '1600 Amphitheatre Parkway');

      expect(
        action.appLink.toString(),
        'comgooglemaps:?q=1600+Amphitheatre+Parkway',
      );
      expect(
        action.fallbackLink.toString(),
        'https://maps.google.com?q=1600+Amphitheatre+Parkway',
      );
      expect(
        action.androidIntentOptions.data,
        'geo://0,0?q=1600+Amphitheatre+Parkway',
      );
    });

    test('store actions have correct properties', () {
      final maps = GoogleMaps();
      final storeActions = maps.storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.google.android.apps.maps');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '585027354');
      expect(iosStoreAction.appName, 'google-maps');
    });

    test('actions store parameters correctly with fallbackToStore', () {
      final searchAction = GoogleMaps.search(
        query: 'Central Park',
        fallbackToStore: true,
      );
      expect(searchAction.query, 'Central Park');
      expect(searchAction.fallbackToStore, true);
    });

    test('view action creates correct URIs', () {
      final action = GoogleMaps.view(
        coordinate: const Coordinate(latitude: 37.422, longitude: -122.084),
        zoom: 15,
      );

      expect(action.appLink.scheme, 'comgooglemaps');
      expect(action.appLink.queryParameters['center'], '37.422,-122.084');
      expect(double.parse(action.appLink.queryParameters['zoom']!), 15);

      expect(action.fallbackLink.host, 'maps.google.com');
      expect(action.fallbackLink.queryParameters['q'], '37.422,-122.084');
      expect(double.parse(action.fallbackLink.queryParameters['z']!), 15);

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.scheme, 'geo');
      expect(intentUri.path, '37.422,-122.084');
      expect(double.parse(intentUri.queryParameters['z']!), 15);
    });

    test('directions action creates correct URIs', () {
      final action = GoogleMaps.directions(
        origin: 'Times Square, New York',
        destination: 'Statue of Liberty',
        mode: GoogleMapsTravelMode.transit,
      );

      expect(action.appLink.scheme, 'comgooglemaps');
      expect(action.appLink.queryParameters['daddr'], 'Statue of Liberty');
      expect(action.appLink.queryParameters['saddr'], 'Times Square, New York');
      expect(action.appLink.queryParameters['directionsmode'], 'transit');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.scheme, 'https');
      expect(intentUri.host, 'www.google.com');
      expect(intentUri.path, '/maps/dir/');
      expect(intentUri.queryParameters['destination'], 'Statue of Liberty');
      expect(intentUri.queryParameters['origin'], 'Times Square, New York');
      expect(intentUri.queryParameters['travelmode'], 'transit');

      expect(action.fallbackLink.queryParameters['saddr'], 'Times Square, New York');
      expect(action.fallbackLink.queryParameters['daddr'], 'Statue of Liberty');
      expect(action.fallbackLink.queryParameters['directionsmode'], 'transit');
    });

    test('directionsWithCoords action creates correct URIs', () {
      final action = GoogleMaps.directionsWithCoords(
        origin: const Coordinate(latitude: 40.758, longitude: -73.9855),
        destination: const Coordinate(latitude: 40.6892, longitude: -74.0445),
        mode: GoogleMapsTravelMode.walking,
      );

      expect(action.appLink.scheme, 'comgooglemaps');
      expect(action.appLink.queryParameters['daddr'], '40.6892,-74.0445');
      expect(action.appLink.queryParameters['saddr'], '40.758,-73.9855');
      expect(action.appLink.queryParameters['directionsmode'], 'walking');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(intentUri.scheme, 'https');
      expect(intentUri.host, 'www.google.com');
      expect(intentUri.path, '/maps/dir/');
      expect(intentUri.queryParameters['destination'], '40.6892,-74.0445');
      expect(intentUri.queryParameters['origin'], '40.758,-73.9855');
      expect(intentUri.queryParameters['travelmode'], 'walking');

      expect(action.fallbackLink.queryParameters['saddr'], '40.758,-73.9855');
      expect(action.fallbackLink.queryParameters['daddr'], '40.6892,-74.0445');
      expect(action.fallbackLink.queryParameters['directionsmode'], 'walking');
    });
  });
}

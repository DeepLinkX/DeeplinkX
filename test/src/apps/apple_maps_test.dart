import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/apple_maps.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Apple Maps Actions', () {
    test('open action creates AppleMaps instance with correct properties', () {
      final action = AppleMaps.open();

      // As App
      expect(action.customScheme, 'maps');
      expect(action.androidPackageName, null);
      expect(action.website.toString(), 'https://maps.apple.com');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.macos]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, 'com.apple.Maps');

      // As DownloadableApp
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 1);
    });

    test('open action creates AppleMaps instance with correct type', () {
      final action = AppleMaps.open();

      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store action has correct properties', () {
      final maps = AppleMaps();
      final storeAction = maps.storeActions.first as IOSAppStoreOpenAppPageAction;

      expect(storeAction.appId, '915056765');
      expect(storeAction.appName, 'apple-maps');
      expect(storeAction.mediaType, '8');
    });

    test('search action creates correct type and URIs', () {
      final action = AppleMaps.search(query: 'Central Park');

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());

      expect(action.appLink.toString(), 'maps:?q=Central+Park');
      expect(action.fallbackLink.toString(), 'https://maps.apple.com/?q=Central+Park');
    });

    test('view action creates correct URIs', () {
      final action = AppleMaps.view(
        coordinate: const Coordinate(latitude: 40.7812, longitude: -73.9665),
        zoom: 12.5,
      );

      expect(action.appLink.scheme, 'maps');
      expect(action.appLink.queryParameters['ll'], '40.7812,-73.9665');
      expect(double.parse(action.appLink.queryParameters['z']!), 12.5);

      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'maps.apple.com');
      expect(action.fallbackLink.queryParameters['ll'], '40.7812,-73.9665');
      expect(double.parse(action.fallbackLink.queryParameters['z']!), 12.5);
    });

    test('directions action creates correct URIs', () {
      final action = AppleMaps.directions(
        destination: 'Statue of Liberty',
        origin: 'Central Park, NYC',
        mode: AppleMapsTransportType.transit,
      );

      expect(action.appLink.scheme, 'maps');
      expect(action.appLink.queryParameters['daddr'], 'Statue of Liberty');
      expect(action.appLink.queryParameters['saddr'], 'Central Park, NYC');
      expect(action.appLink.queryParameters['dirflg'], 'r');

      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'maps.apple.com');
      expect(action.fallbackLink.queryParameters['daddr'], 'Statue of Liberty');
      expect(action.fallbackLink.queryParameters['saddr'], 'Central Park, NYC');
      expect(action.fallbackLink.queryParameters['dirflg'], 'r');
    });

    test('directionsWithCoords action creates correct URIs', () {
      final action = AppleMaps.directionsWithCoords(
        destination: const Coordinate(latitude: 40.6892, longitude: -74.0445),
        origin: const Coordinate(latitude: 40.7812, longitude: -73.9665),
        mode: AppleMapsTransportType.walking,
      );

      expect(action.appLink.scheme, 'maps');
      expect(action.appLink.queryParameters['daddr'], '40.6892,-74.0445');
      expect(action.appLink.queryParameters['saddr'], '40.7812,-73.9665');
      expect(action.appLink.queryParameters['dirflg'], 'w');

      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'maps.apple.com');
      expect(action.fallbackLink.queryParameters['daddr'], '40.6892,-74.0445');
      expect(action.fallbackLink.queryParameters['saddr'], '40.7812,-73.9665');
      expect(action.fallbackLink.queryParameters['dirflg'], 'w');
    });

    test('actions store fallback preference', () {
      final action = AppleMaps.search(
        query: 'Times Square',
        fallbackToStore: true,
      );

      expect(action.fallbackToStore, true);
      expect(action.query, 'Times Square');
    });
  });
}

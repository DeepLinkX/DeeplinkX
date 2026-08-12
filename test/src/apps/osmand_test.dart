import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/osmand.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OsmAnd Actions', () {
    const destination = Coordinate(latitude: 52.516275, longitude: 13.377704);

    test('open action exposes metadata and store actions', () {
      final action = OsmAnd.open();

      expect(action.customScheme, 'osmandmaps');
      expect(action.androidPackageName, 'net.osmand');
      expect(action.website.toString(), 'https://osmand.net');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = OsmAnd().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'net.osmand');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '934850257');
      expect(iosStoreAction.appName, 'osmand-maps-travel-navigate');
    });

    test('view action creates iOS app link, Android intent, and fallback URLs', () {
      final action = OsmAnd.view(
        coordinate: destination,
        zoom: 12,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.zoom, 12);
      expect(action.fallbackToStore, true);
      expect(action.appLink, action.fallbackLink);
      expect(action.appLink.scheme, 'https');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'net.osmand');
      expect(action.androidIntentOptions.flags, [0x10000000]);

      final androidUri = Uri.parse(action.androidIntentOptions.data!);
      expect(androidUri.scheme, 'https');
      expect(androidUri.host, 'osmand.net');
      expect(androidUri.path, '/go');
      expect(androidUri.queryParameters['lat'], '52.516275');
      expect(androidUri.queryParameters['lon'], '13.377704');
      expect(androidUri.queryParameters['z'], '12');

      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'osmand.net');
      expect(action.fallbackLink.path, '/map/');
      expect(action.fallbackLink.queryParameters['pin'], '52.516275,13.377704');
      expect(action.fallbackLink.fragment, '12/52.516275/13.377704');
    });

    test('view action defaults to zoom 15', () {
      final action = OsmAnd.view(coordinate: destination);

      expect(action.zoom, 15);
      expect(action.appLink.fragment, '15/52.516275/13.377704');
      expect(action.fallbackLink.fragment, '15/52.516275/13.377704');
    });

    test('directionsWithCoords action creates iOS app link, Android intent, and fallback URLs', () {
      final action = OsmAnd.directionsWithCoords(
        destination: destination,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.destination, destination);
      expect(action.fallbackToStore, true);
      expect(action.appLink.scheme, 'https');
      expect(action.appLink.host, 'osmand.net');
      expect(action.appLink.path, '/map/');
      expect(action.appLink.queryParameters['end'], '52.516275,13.377704');
      expect(action.appLink.queryParameters['finish'], '52.516275,13.377704');
      expect(action.appLink.fragment, '15/52.516275/13.377704');
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'osmand.navigation:q=52.516275,13.377704');
      expect(action.androidIntentOptions.package, 'net.osmand');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'osmand.net');
      expect(action.fallbackLink.path, '/map/');
      expect(action.fallbackLink.queryParameters['finish'], '52.516275,13.377704');
      expect(action.fallbackLink.fragment, '15/52.516275/13.377704');
    });

    test('coordinates preserve zero, signs, integer doubles and precision', () {
      const coordinates = [
        Coordinate(latitude: 0, longitude: 0),
        Coordinate(latitude: -33.8688197, longitude: 151.2092955),
        Coordinate(latitude: 51.5, longitude: -0.125),
        Coordinate(latitude: -90, longitude: -180),
        Coordinate(latitude: 90, longitude: 180),
      ];
      for (final coordinate in coordinates) {
        final view = OsmAnd.view(coordinate: coordinate, zoom: 12);
        final route = OsmAnd.directionsWithCoords(destination: coordinate);
        final androidView = Uri.parse(view.androidIntentOptions.data!);
        expect(androidView.queryParameters, {
          'lat': coordinate.latitude.toString(),
          'lon': coordinate.longitude.toString(),
          'z': '12',
        });
        expect(view.appLink.queryParameters['pin'], coordinate.toString());
        expect(view.appLink.fragment, '12/${coordinate.latitude}/${coordinate.longitude}');
        expect(route.appLink.queryParameters, {'end': coordinate.toString(), 'finish': coordinate.toString()});
        expect(route.fallbackLink.queryParameters, {'finish': coordinate.toString()});
        expect(route.androidIntentOptions.data, 'osmand.navigation:q=$coordinate');
      }
    });

    test('route URLs omit origin, travel mode and waypoint parameters', () {
      final action = OsmAnd.directionsWithCoords(destination: destination);
      expect(action.appLink.queryParameters.keys, unorderedEquals(['end', 'finish']));
      expect(action.fallbackLink.queryParameters.keys, ['finish']);
      expect(action.fallbackToStore, false);
    });

    test('native Android requests target only the free OsmAnd package', () {
      final actions = <IntentAppLinkAction>[
        OsmAnd.view(coordinate: destination),
        OsmAnd.directionsWithCoords(destination: destination),
      ];
      for (final action in actions) {
        expect(action.androidIntentOptions.action, 'action_view');
        expect(action.androidIntentOptions.package, 'net.osmand');
        expect(action.androidIntentOptions.flags, [0x10000000]);
        expect(action.appLink!.scheme, 'https');
      }
    });

    test('all factories preserve both store fallback flags', () {
      for (final fallbackToStore in [false, true]) {
        final actions = <OsmAnd>[
          OsmAnd(fallbackToStore: fallbackToStore),
          OsmAnd.open(fallbackToStore: fallbackToStore),
          OsmAnd.view(coordinate: destination, fallbackToStore: fallbackToStore),
          OsmAnd.directionsWithCoords(destination: destination, fallbackToStore: fallbackToStore),
        ];
        for (final action in actions) {
          expect(action.fallbackToStore, fallbackToStore);
        }
      }
    });
  });
}

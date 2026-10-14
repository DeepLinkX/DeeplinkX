import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/citymapper.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Citymapper Actions', () {
    const origin = Coordinate(latitude: 51.500729, longitude: -0.124625);
    const destination = Coordinate(latitude: 51.503399, longitude: -0.119519);

    test('open action exposes metadata and store actions', () {
      final action = Citymapper.open();

      expect(action.customScheme, 'citymapper');
      expect(action.androidPackageName, 'com.citymapper.app.release');
      expect(action.website.toString(), 'https://citymapper.com');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = Citymapper().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.citymapper.app.release');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '469463298');
      expect(iosStoreAction.appName, 'citymapper-all-live-transit');
    });

    test('view action creates directions-to-point URLs', () {
      final action = Citymapper.view(
        coordinate: destination,
        title: 'London Eye',
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.title, 'London Eye');
      expect(action.fallbackToStore, true);
      expect(action.appLink.scheme, 'citymapper');
      expect(action.appLink.host, 'directions');
      expect(action.appLink.queryParameters['endcoord'], '51.503399,-0.119519');
      expect(action.appLink.queryParameters['endname'], 'London Eye');
      expect(action.fallbackLink.scheme, 'https');
      expect(action.fallbackLink.host, 'citymapper.com');
      expect(action.fallbackLink.path, '/directions');
      expect(action.fallbackLink.queryParameters['endcoord'], '51.503399,-0.119519');

      final intentUri = Uri.parse(action.androidIntentOptions.data!);
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'com.citymapper.app.release');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(intentUri.queryParameters['endname'], 'London Eye');
    });

    test('view action omits optional title', () {
      final action = Citymapper.view(coordinate: destination);

      expect(action.title, null);
      expect(action.appLink.queryParameters.containsKey('endname'), false);
      expect(action.fallbackLink.queryParameters.containsKey('endname'), false);
    });

    test('directionsWithCoords action creates full route URLs', () {
      final arriveBy = DateTime.utc(2026, 1, 2, 3, 4, 5);
      final action = Citymapper.directionsWithCoords(
        origin: origin,
        destination: destination,
        originTitle: 'Westminster',
        destinationTitle: 'London Eye',
        originAddress: 'Westminster, London',
        destinationAddress: 'Riverside Building, London',
        arriveBy: arriveBy,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, origin);
      expect(action.destination, destination);
      expect(action.originTitle, 'Westminster');
      expect(action.destinationTitle, 'London Eye');
      expect(action.originAddress, 'Westminster, London');
      expect(action.destinationAddress, 'Riverside Building, London');
      expect(action.arriveBy, arriveBy);
      expect(action.fallbackToStore, true);
      expect(action.appLink.host, 'directions');
      expect(action.appLink.queryParameters['endcoord'], '51.503399,-0.119519');
      expect(action.appLink.queryParameters['startcoord'], '51.500729,-0.124625');
      expect(action.appLink.queryParameters['endname'], 'London Eye');
      expect(action.appLink.queryParameters['startname'], 'Westminster');
      expect(action.appLink.queryParameters['endaddress'], 'Riverside Building, London');
      expect(action.appLink.queryParameters['startaddress'], 'Westminster, London');
      expect(action.appLink.queryParameters['arriveby'], '2026-01-02T03:04:05.000Z');
      expect(action.fallbackLink.queryParameters['arriveby'], '2026-01-02T03:04:05.000Z');
      expect(Uri.parse(action.androidIntentOptions.data!).queryParameters['startcoord'], '51.500729,-0.124625');
    });

    test('directionsWithCoords action supports destination-only routes', () {
      final action = Citymapper.directionsWithCoords(destination: destination);

      expect(action.origin, null);
      expect(action.originTitle, null);
      expect(action.destinationTitle, null);
      expect(action.originAddress, null);
      expect(action.destinationAddress, null);
      expect(action.arriveBy, null);
      expect(action.appLink.queryParameters['endcoord'], '51.503399,-0.119519');
      expect(action.appLink.queryParameters.containsKey('startcoord'), false);
      expect(action.appLink.queryParameters.containsKey('startname'), false);
      expect(action.appLink.queryParameters.containsKey('arriveby'), false);
    });

    test('ignores orphaned origin labels and addresses', () {
      final action = Citymapper.directionsWithCoords(
        destination: destination,
        originTitle: 'Ignored origin',
        originAddress: 'Ignored address',
      );
      expect(action.originTitle, 'Ignored origin');
      expect(action.originAddress, 'Ignored address');
      expect(action.appLink.queryParameters, {'endcoord': destination.toString()});
      expect(action.fallbackLink.queryParameters, action.appLink.queryParameters);
      expect(action.androidIntentOptions.data, action.appLink.toString());
    });

    test('explicit origins support independently omitted optional metadata', () {
      for (final includeTitle in [false, true]) {
        for (final includeAddress in [false, true]) {
          final action = Citymapper.directionsWithCoords(
            destination: destination,
            origin: origin,
            originTitle: includeTitle ? 'Start' : null,
            originAddress: includeAddress ? 'Start address' : null,
          );
          expect(action.appLink.queryParameters['startcoord'], origin.toString());
          expect(action.appLink.queryParameters.containsKey('startname'), includeTitle);
          expect(action.appLink.queryParameters.containsKey('startaddress'), includeAddress);
          expect(action.fallbackLink.queryParameters, action.appLink.queryParameters);
        }
      }
    });

    test('query values round trip Unicode and reserved characters', () {
      const label = 'Café / A,B?x=1&y=2#50% + تهران';
      final view = Citymapper.view(coordinate: destination, title: label);
      final route = Citymapper.directionsWithCoords(
        destination: destination,
        origin: origin,
        destinationTitle: label,
        destinationAddress: label,
        originTitle: label,
        originAddress: label,
      );
      expect(Uri.parse(view.appLink.toString()).queryParameters['endname'], label);
      expect(view.appLink.queryParameters.length, 2);
      expect(view.fallbackLink.queryParameters, view.appLink.queryParameters);
      expect(route.appLink.queryParameters.length, 6);
      for (final key in ['endname', 'endaddress', 'startname', 'startaddress']) {
        expect(Uri.parse(route.appLink.toString()).queryParameters[key], label);
      }
      expect(route.appLink.fragment, isEmpty);
      expect(route.fallbackLink.queryParameters, route.appLink.queryParameters);
    });

    test('empty strings remain optional supplied values', () {
      final action = Citymapper.directionsWithCoords(
        origin: origin,
        destination: destination,
        originTitle: '',
        originAddress: '',
        destinationTitle: '',
        destinationAddress: '',
      );
      for (final key in ['endname', 'endaddress', 'startname', 'startaddress']) {
        expect(action.appLink.queryParameters[key], '');
      }
      expect(Citymapper.view(coordinate: destination, title: '').appLink.queryParameters['endname'], '');
    });

    test('arrival times preserve their instant and serialize in UTC', () {
      final instant = DateTime.utc(2026, 12, 2, 12, 0, 0, 123, 456);
      final local = instant.toLocal();
      final offset = DateTime.parse('2026-12-02T15:30:00.123456+03:30');
      expect(local.isUtc, false);
      for (final arrival in [instant, local, offset]) {
        final action = Citymapper.directionsWithCoords(destination: destination, arriveBy: arrival);
        expect(action.arriveBy, arrival);
        expect(action.appLink.queryParameters['arriveby'], '2026-12-02T12:00:00.123456Z');
        expect(action.fallbackLink.queryParameters, action.appLink.queryParameters);
        expect(Uri.parse(action.androidIntentOptions.data!).queryParameters, action.appLink.queryParameters);
      }
    });

    test('view and directions intents target Citymapper with identical native data', () {
      final actions = <IntentAppLinkAction>[
        Citymapper.view(coordinate: destination),
        Citymapper.directionsWithCoords(destination: destination),
      ];
      for (final action in actions) {
        expect(action.androidIntentOptions.action, 'action_view');
        expect(action.androidIntentOptions.package, 'com.citymapper.app.release');
        expect(action.androidIntentOptions.flags, [0x10000000]);
        expect(action.androidIntentOptions.data, action.appLink.toString());
        expect(action.appLink!.host, 'directions');
      }
    });

    test('all constructors and factories preserve fallback flags', () {
      for (final fallbackToStore in [false, true]) {
        final actions = <Citymapper>[
          Citymapper(fallbackToStore: fallbackToStore),
          Citymapper.open(fallbackToStore: fallbackToStore),
          Citymapper.view(coordinate: destination, fallbackToStore: fallbackToStore),
          Citymapper.directionsWithCoords(destination: destination, fallbackToStore: fallbackToStore),
        ];
        for (final action in actions) {
          expect(action.fallbackToStore, fallbackToStore);
        }
      }
    });
  });
}

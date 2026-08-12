import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/tomtom_go_fleet.dart';
import 'package:deeplink_x/src/core/deeplink_x.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/intent_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:deeplink_x/src/utils/launcher_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLauncherUtil extends Mock implements LauncherUtil {}

void main() {
  group('TomTom Go Fleet Actions', () {
    const destination = Coordinate(latitude: 52.5163, longitude: 13.3777);

    test('open action exposes metadata and store actions', () {
      final action = TomTomGoFleet.open();

      expect(action.customScheme, null);
      expect(action.androidPackageName, 'com.tomtom.gplay.navapp.gofleet');
      expect(action.website.toString(), 'https://www.tomtom.com/solutions/fleet-management-logistics/');
      expect(action.supportedPlatforms, [PlatformType.android]);
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

    test('view action creates documented Android geo link and fallback', () {
      final action = TomTomGoFleet.view(
        coordinate: destination,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<IntentAppLinkAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.fallbackToStore, true);
      expect(action.appLink, isNull);
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.package, 'com.tomtom.gplay.navapp.gofleet');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.androidIntentOptions.data, 'geo:52.5163,13.3777');
      expect(action.fallbackLink.toString(), 'https://www.tomtom.com/solutions/fleet-management-logistics/');
    });

    test('view action creates a coordinate-only geo URI', () {
      final action = TomTomGoFleet.view(coordinate: destination);

      expect(action.androidIntentOptions.data, 'geo:52.5163,13.3777');
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
      expect(action.appLink, isNull);
      expect(action.androidIntentOptions.action, 'action_view');
      expect(action.androidIntentOptions.data, 'google.navigation:q=52.5163,13.3777');
      expect(action.androidIntentOptions.package, 'com.tomtom.gplay.navapp.gofleet');
      expect(action.androidIntentOptions.flags, [0x10000000]);
      expect(action.fallbackLink.toString(), 'https://www.tomtom.com/solutions/fleet-management-logistics/');
    });

    for (final action in [
      TomTomGoFleet.view(coordinate: destination),
      TomTomGoFleet.directionsWithCoords(destination: destination),
    ]) {
      group('${action.runtimeType} dispatch', () {
        late MockLauncherUtil launcher;
        late DeeplinkX deeplinkX;
        final intentAction = action as IntentAppLinkAction;
        final fallbackAction = action as Fallbackable;
        final options = intentAction.androidIntentOptions;

        setUp(() {
          launcher = MockLauncherUtil();
          deeplinkX = DeeplinkX(launcherUtil: launcher, platformType: PlatformType.android);
          when(() => launcher.isAppInstalled(action)).thenAnswer((final _) async => true);
          when(() => launcher.launchIntent(options)).thenAnswer((final _) async => true);
        });

        test('launches only the package-targeted intent', () async {
          expect(await deeplinkX.launchAction(action), isTrue);
          expect(options.package, 'com.tomtom.gplay.navapp.gofleet');
          verifyInOrder([
            () => launcher.isAppInstalled(action),
            () => launcher.launchIntent(options),
          ]);
          verifyNoMoreInteractions(launcher);
        });

        test('failed intent uses website without launching a shared URI', () async {
          when(() => launcher.launchIntent(options)).thenAnswer((final _) async => false);
          when(() => launcher.launchUrl(fallbackAction.fallbackLink)).thenAnswer((final _) async => true);

          expect(await deeplinkX.launchAction(action), isTrue);
          verifyInOrder([
            () => launcher.isAppInstalled(action),
            () => launcher.launchIntent(options),
            () => launcher.launchUrl(fallbackAction.fallbackLink),
          ]);
          verifyNoMoreInteractions(launcher);
        });

        test('failed intent returns false when fallback is disabled', () async {
          when(() => launcher.launchIntent(options)).thenAnswer((final _) async => false);

          expect(await deeplinkX.launchAction(action, disableFallback: true), isFalse);
          verifyInOrder([
            () => launcher.isAppInstalled(action),
            () => launcher.launchIntent(options),
          ]);
          verifyNoMoreInteractions(launcher);
        });
      });
    }
  });
}

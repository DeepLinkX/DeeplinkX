import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/sygic.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/app_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sygic Actions', () {
    test('open action exposes metadata and store actions', () {
      final action = Sygic.open();

      expect(action.customScheme, 'com.sygic.aura');
      expect(action.androidPackageName, 'com.sygic.aura');
      expect(action.website.toString(), 'https://www.sygic.com/gps-navigation');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);

      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
    });

    test('open action implements app interfaces', () {
      final action = Sygic.open();
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('view action builds proper app link and fallback', () {
      final action = Sygic.view(
        coordinate: const Coordinate(latitude: 48.1486, longitude: 17.1077),
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.appLink.toString(), 'com.sygic.aura://coordinate%7C17.1077%7C48.1486%7Cshow');
      expect(action.fallbackLink.toString(), 'https://www.sygic.com/gps-navigation');
    });

    test('directionsWithCoords action supports transport modes', () {
      final action = Sygic.directionsWithCoords(
        destination: const Coordinate(latitude: 48.1486, longitude: 17.1077),
        mode: SygicTransportMode.walk,
      );

      expect(action, isInstanceOf<AppLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.appLink.toString(), 'com.sygic.aura://coordinate%7C17.1077%7C48.1486%7Cwalk');
      expect(action.mode, SygicTransportMode.walk);
    });

    test('directionsWithCoords action has website fallback', () {
      final action = Sygic.directionsWithCoords(
        destination: const Coordinate(latitude: 48.1486, longitude: 17.1077),
      );

      expect(action.fallbackLink.toString(), 'https://www.sygic.com/gps-navigation');
    });

    test('store actions resolve to expected stores', () {
      final storeActions = Sygic().storeActions;
      expect(storeActions.length, 2);

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.sygic.aura');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '585193266');
      expect(iosStoreAction.appName, 'sygic-gps-navigation-offline');
    });

    test('actions keep fallback flag', () {
      final viewAction = Sygic.view(
        coordinate: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(viewAction.fallbackToStore, true);

      final navigateAction = Sygic.directionsWithCoords(
        destination: const Coordinate(latitude: 1, longitude: 2),
        fallbackToStore: true,
      );
      expect(navigateAction.fallbackToStore, true);
    });
  });
}

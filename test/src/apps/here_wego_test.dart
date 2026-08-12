import 'package:deeplink_x/src/apps/app_stores/ios_app_store.dart';
import 'package:deeplink_x/src/apps/app_stores/play_store.dart';
import 'package:deeplink_x/src/apps/downloadable_apps/here_wego.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';
import 'package:deeplink_x/src/core/interfaces/app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/interfaces/fallbackable_interface.dart';
import 'package:deeplink_x/src/core/interfaces/map_app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/universal_link_app_action_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HERE WeGo Actions', () {
    const origin = Coordinate(latitude: 52.5308, longitude: 13.3847);
    const destination = Coordinate(latitude: 52.5163, longitude: 13.3777);

    test('open action exposes metadata and store actions', () {
      final action = HereWeGo.open();

      expect(action.customScheme, 'here-location');
      expect(action.androidPackageName, 'com.here.app.maps');
      expect(action.website.toString(), 'https://wego.here.com');
      expect(action.supportedPlatforms, containsAll(<PlatformType>[PlatformType.ios, PlatformType.android]));
      expect(action.supportedPlatforms.length, 2);
      expect(action.macosBundleIdentifier, null);
      expect(action.fallbackToStore, false);
      expect(action.storeActions.length, 2);
      expect(action, isInstanceOf<App>());
      expect(action, isInstanceOf<DownloadableApp>());
    });

    test('store actions resolve to expected stores', () {
      final storeActions = HereWeGo().storeActions;

      final playStoreAction = storeActions[0] as PlayStoreOpenAppPageAction;
      expect(playStoreAction.packageName, 'com.here.app.maps');

      final iosStoreAction = storeActions[1] as IOSAppStoreOpenAppPageAction;
      expect(iosStoreAction.appId, '955837609');
      expect(iosStoreAction.appName, 'here-wego-maps-navigation');
    });

    test('travel modes expose provider values', () {
      expect(HereWeGoTravelMode.driving.value, 'd');
      expect(HereWeGoTravelMode.transit.value, 'pt');
      expect(HereWeGoTravelMode.walking.value, 'w');
      expect(HereWeGoTravelMode.bicycling.value, 'b');
    });

    test('view action creates location link and fallback', () {
      final action = HereWeGo.view(
        coordinate: destination,
        title: 'Brandenburg Gate',
        zoom: 15,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapViewAction>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.coordinate, destination);
      expect(action.title, 'Brandenburg Gate');
      expect(action.zoom, 15);
      expect(action.fallbackToStore, true);
      expect(action.universalLink.scheme, 'https');
      expect(action.universalLink.host, 'share.here.com');
      expect(action.universalLink.path, '/l/52.5163,13.3777,Brandenburg%20Gate');
      expect(action.universalLink.queryParameters['z'], '15');
      expect(action.fallbackLink.toString(), action.universalLink.toString());
    });

    test('view action supports title-less default zoom links', () {
      final action = HereWeGo.view(coordinate: destination);

      expect(action.title, null);
      expect(action.zoom, 16);
      expect(action.universalLink.path, '/l/52.5163,13.3777');
      expect(action.universalLink.queryParameters['z'], '16');
    });

    test('directionsWithCoords action creates route link with origin and titles', () {
      final action = HereWeGo.directionsWithCoords(
        origin: origin,
        originTitle: 'Berlin Central Station',
        destination: destination,
        destinationTitle: 'Brandenburg Gate',
        mode: HereWeGoTravelMode.transit,
        fallbackToStore: true,
      );

      expect(action, isInstanceOf<MapDirectionsWithCoordsAction>());
      expect(action, isInstanceOf<UniversalLinkAppAction>());
      expect(action, isInstanceOf<Fallbackable>());
      expect(action.origin, origin);
      expect(action.originTitle, 'Berlin Central Station');
      expect(action.destination, destination);
      expect(action.destinationTitle, 'Brandenburg Gate');
      expect(action.mode, HereWeGoTravelMode.transit);
      expect(action.fallbackToStore, true);
      expect(
        action.universalLink.path,
        '/r/52.5308,13.3847,Berlin%20Central%20Station/52.5163,13.3777,Brandenburg%20Gate',
      );
      expect(action.universalLink.queryParameters['m'], 'pt');
      expect(action.fallbackLink.toString(), action.universalLink.toString());
    });

    test('directionsWithCoords action supports destination-only route links', () {
      final action = HereWeGo.directionsWithCoords(destination: destination);

      expect(action.origin, null);
      expect(action.originTitle, null);
      expect(action.destinationTitle, null);
      expect(action.mode, HereWeGoTravelMode.driving);
      expect(action.universalLink.path, '/r/52.5163,13.3777');
      expect(action.universalLink.queryParameters['m'], 'd');
    });
  });
}

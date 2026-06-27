import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Map action abstractions', () {
    const coordinate = Coordinate(latitude: 1, longitude: 2);

    test('Google Maps actions implement map abstractions', () {
      expect(GoogleMaps.view(coordinate: coordinate), isA<MapViewAction>());
      expect(GoogleMaps.search(query: 'Central Park'), isA<MapSearchAction>());
      expect(GoogleMaps.directions(destination: 'Central Park'), isA<MapDirectionsAction>());
      expect(GoogleMaps.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Amap actions implement map abstractions', () {
      expect(Amap.view(coordinate: coordinate), isA<MapViewAction>());
      expect(Amap.search(query: 'Central Park'), isA<MapSearchAction>());
      expect(Amap.directions(destination: 'Central Park'), isA<MapDirectionsAction>());
      expect(Amap.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Baidu Maps actions implement map abstractions', () {
      expect(BaiduMaps.view(coordinate: coordinate), isA<MapViewAction>());
      expect(BaiduMaps.search(query: 'Central Park'), isA<MapSearchAction>());
      expect(BaiduMaps.directions(destination: 'Central Park'), isA<MapDirectionsAction>());
      expect(BaiduMaps.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Apple Maps actions implement map abstractions', () {
      expect(AppleMaps.view(coordinate: coordinate), isA<MapViewAction>());
      expect(AppleMaps.search(query: 'Central Park'), isA<MapSearchAction>());
      expect(AppleMaps.directions(destination: 'Central Park'), isA<MapDirectionsAction>());
      expect(AppleMaps.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('2GIS actions implement supported map abstractions', () {
      expect(TwoGis.view(coordinate: coordinate), isA<MapViewAction>());
      expect(TwoGis.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Waze actions implement map abstractions', () {
      expect(Waze.view(coordinate: coordinate), isA<MapViewAction>());
      expect(Waze.search(query: 'Central Park'), isA<MapSearchAction>());
      expect(Waze.directions(destination: 'Central Park'), isA<MapDirectionsAction>());
      expect(Waze.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Sygic actions implement supported map abstractions', () {
      expect(Sygic.view(coordinate: coordinate), isA<MapViewAction>());
      expect(Sygic.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Moovit actions implement supported map abstractions', () {
      expect(Moovit.view(coordinate: coordinate), isA<MapViewAction>());
      expect(Moovit.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Neshan actions implement supported map abstractions', () {
      expect(Neshan.view(coordinate: coordinate), isA<MapViewAction>());
      expect(Neshan.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Yandex Maps actions implement supported map abstractions', () {
      expect(YandexMaps.view(coordinate: coordinate), isA<MapViewAction>());
      expect(YandexMaps.search(query: 'Central Park'), isA<MapSearchAction>());
      expect(YandexMaps.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });

    test('Yandex Navigator actions implement supported map abstractions', () {
      expect(YandexNavigator.view(coordinate: coordinate), isA<MapViewAction>());
      expect(YandexNavigator.search(query: 'Central Park'), isA<MapSearchAction>());
      expect(YandexNavigator.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });
  });
}

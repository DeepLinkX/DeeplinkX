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

    test('Apple Maps actions implement map abstractions', () {
      expect(AppleMaps.view(coordinate: coordinate), isA<MapViewAction>());
      expect(AppleMaps.search(query: 'Central Park'), isA<MapSearchAction>());
      expect(AppleMaps.directions(destination: 'Central Park'), isA<MapDirectionsAction>());
      expect(AppleMaps.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
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

    test('TomTom Go actions implement supported map abstractions', () {
      expect(TomTomGo.view(coordinate: coordinate), isA<MapViewAction>());
      expect(TomTomGo.directionsWithCoords(destination: coordinate), isA<MapDirectionsWithCoordsAction>());
    });
  });
}

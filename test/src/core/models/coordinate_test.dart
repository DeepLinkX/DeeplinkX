import 'package:deeplink_x/src/core/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Coordinate', () {
    test('stores latitude and longitude', () {
      // not const on purpose so VM executes the constructor (coverage)
      final coordinate = Coordinate(latitude: 12.34, longitude: -56.78); // ignore: prefer_const_constructors
      expect(coordinate.latitude, 12.34);
      expect(coordinate.longitude, -56.78);
    });

    test('toString returns comma-separated lat,long', () {
      const coordinate = Coordinate(latitude: 45.6906304, longitude: -120.810983);
      expect(coordinate.toString(), '45.6906304,-120.810983');
    });

    test('toString includes .0 for integer doubles', () {
      // not const on purpose so VM executes the constructor (coverage)
      final coordinate = Coordinate(latitude: 1, longitude: 2); // ignore: prefer_const_constructors
      expect(coordinate.toString(), '1.0,2.0');
    });
  });
}

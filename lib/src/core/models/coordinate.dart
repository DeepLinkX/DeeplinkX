/// A geographic coordinate with latitude and longitude values.
class Coordinate {
  /// Creates a [Coordinate] with the given [latitude] and [longitude].
  const Coordinate({required this.latitude, required this.longitude});

  /// Latitude component of the coordinate.
  final double latitude;

  /// Longitude component of the coordinate.
  final double longitude;

  @override
  String toString() => '$latitude,$longitude';
}

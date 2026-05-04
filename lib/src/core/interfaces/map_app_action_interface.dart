import 'package:deeplink_x/src/core/interfaces/app_action_interface.dart';
import 'package:deeplink_x/src/core/interfaces/downloadable_app_interface.dart';
import 'package:deeplink_x/src/core/models/coordinate.dart';

/// Represents a map-specific app action.
///
/// Map actions are downloadable app actions that can be grouped and launched
/// through the map utility methods on DeeplinkX.
abstract class MapAppAction extends DownloadableApp implements AppAction {}

/// Represents a map action that displays a coordinate.
abstract class MapViewAction extends MapAppAction {
  /// Coordinate to display on the map.
  Coordinate get coordinate;
}

/// Represents a map action that searches for a query.
abstract class MapSearchAction extends MapAppAction {
  /// Search query.
  String get query;
}

/// Represents a map action that navigates to a destination string.
abstract class MapDirectionsAction extends MapAppAction {
  /// Destination address or place name.
  String get destination;
}

/// Represents a map action that navigates to destination coordinates.
abstract class MapDirectionsWithCoordsAction extends MapAppAction {
  /// Destination coordinates.
  Coordinate get destination;
}

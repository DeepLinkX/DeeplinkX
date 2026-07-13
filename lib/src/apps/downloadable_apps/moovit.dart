import 'package:deeplink_x/src/src.dart';

/// Moovit transit app (iOS and Android).
class Moovit extends App implements DownloadableApp {
  /// Creates a new [Moovit] instance.
  Moovit({this.fallbackToStore = false});

  /// Creates an action to open Moovit (use with `launchApp`).
  factory Moovit.open({final bool fallbackToStore = false}) => Moovit(fallbackToStore: fallbackToStore);

  /// Store actions for Moovit.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.tranzmate'),
        IOSAppStore.openAppPage(appId: '498477945', appName: 'moovit-bus-transit-tracker'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.tranzmate';

  /// Custom scheme for install detection and deeplinks.
  @override
  String get customScheme => 'moovit';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported platforms (iOS and Android).
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to fallback to stores if the app is missing.
  @override
  bool fallbackToStore;

  /// Moovit web fallback.
  @override
  Uri get website => Uri.parse('https://www.moovit.com/');

  /// Creates an action that shows nearby transit options at [coordinate].
  static MoovitViewAction view({
    required final Coordinate coordinate,
    final String partnerId = 'deeplink_x',
    final bool fallbackToStore = false,
  }) =>
      MoovitViewAction(
        coordinate: coordinate,
        partnerId: partnerId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action that starts directions to [destination].
  static MoovitDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final String partnerId = 'deeplink_x',
    final bool fallbackToStore = false,
  }) =>
      MoovitDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        destinationTitle: destinationTitle,
        originTitle: originTitle,
        partnerId: partnerId,
        fallbackToStore: fallbackToStore,
      );
}

/// Moovit nearby transit action.
class MoovitViewAction extends Moovit implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapViewAction {
  /// Creates a new [MoovitViewAction].
  MoovitViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    final String partnerId = 'deeplink_x',
  }) : partnerId = _validatedPartnerId(partnerId);

  /// Coordinate to show nearby transit options for.
  @override
  final Coordinate coordinate;

  /// Partner identifier required by Moovit deeplinks.
  final String partnerId;

  @override
  Uri get appLink => Uri(
        scheme: 'moovit',
        host: 'nearby',
        queryParameters: {
          'lat': coordinate.latitude.toString(),
          'lon': coordinate.longitude.toString(),
          'partner_id': partnerId,
        },
      );

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;
}

/// Moovit coordinate directions action.
class MoovitDirectionsWithCoordsAction extends Moovit
    implements IntentAppLinkAction, AppLinkAppAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [MoovitDirectionsWithCoordsAction].
  MoovitDirectionsWithCoordsAction({
    required this.destination,
    required this.origin,
    required this.destinationTitle,
    required this.originTitle,
    required super.fallbackToStore,
    final String partnerId = 'deeplink_x',
  }) : partnerId = _validatedPartnerId(partnerId);

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional destination label.
  final String? destinationTitle;

  /// Optional origin label.
  final String? originTitle;

  /// Partner identifier required by Moovit deeplinks.
  final String partnerId;

  @override
  Uri get appLink {
    final routeOrigin = origin;
    final routeOriginTitle = originTitle;
    final routeDestinationTitle = destinationTitle;

    return Uri(
      scheme: 'moovit',
      host: 'directions',
      queryParameters: {
        'dest_lat': destination.latitude.toString(),
        'dest_lon': destination.longitude.toString(),
        if (routeDestinationTitle != null) 'dest_name': routeDestinationTitle,
        if (routeOrigin != null) 'orig_lat': routeOrigin.latitude.toString(),
        if (routeOrigin != null) 'orig_lon': routeOrigin.longitude.toString(),
        if (routeOriginTitle != null) 'orig_name': routeOriginTitle,
        'partner_id': partnerId,
      },
    );
  }

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [0x10000000],
      );

  @override
  Uri get fallbackLink => website;
}

String _validatedPartnerId(final String partnerId) {
  if (partnerId.trim().isEmpty) {
    throw ArgumentError.value(partnerId, 'partnerId', 'must not be blank');
  }
  return partnerId;
}

import 'package:deeplink_x/src/src.dart';

/// Citymapper app for iOS and Android.
class Citymapper extends App implements DownloadableApp {
  /// Creates a new [Citymapper] instance.
  Citymapper({this.fallbackToStore = false});

  /// Creates an action to open the Citymapper app.
  factory Citymapper.open({final bool fallbackToStore = false}) => Citymapper(fallbackToStore: fallbackToStore);

  /// Creates an action to open Citymapper directions to [coordinate].
  ///
  /// Citymapper does not expose a dedicated marker URL. This uses the
  /// provider-supported directions URL with the coordinate as the destination.
  static CitymapperViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final bool fallbackToStore = false,
  }) =>
      CitymapperViewAction(
        coordinate: coordinate,
        title: title,
        fallbackToStore: fallbackToStore,
      );

  /// Creates a coordinate-based directions action.
  static CitymapperDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final Coordinate? origin,
    final String? destinationTitle,
    final String? originTitle,
    final String? destinationAddress,
    final String? originAddress,
    final DateTime? arriveBy,
    final bool fallbackToStore = false,
  }) =>
      CitymapperDirectionsWithCoordsAction(
        destination: destination,
        origin: origin,
        destinationTitle: destinationTitle,
        originTitle: originTitle,
        destinationAddress: destinationAddress,
        originAddress: originAddress,
        arriveBy: arriveBy,
        fallbackToStore: fallbackToStore,
      );

  /// Store actions for Citymapper.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.citymapper.app.release'),
        IOSAppStore.openAppPage(
          appId: '469463298',
          appName: 'citymapper-all-live-transit',
        ),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.citymapper.app.release';

  /// Custom scheme for Citymapper.
  @override
  String get customScheme => 'citymapper';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// Citymapper website used as the app fallback.
  @override
  Uri get website => Uri.parse('https://citymapper.com');
}

/// Opens Citymapper directions to a coordinate.
class CitymapperViewAction extends Citymapper implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a Citymapper view action.
  CitymapperViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    this.title,
  });

  /// Destination coordinate.
  @override
  final Coordinate coordinate;

  /// Optional destination label.
  final String? title;

  Map<String, String> get _queryParameters => {
        'endcoord': coordinate.toString(),
        if (title != null) 'endname': title!,
      };

  @override
  Uri get appLink => _citymapperAppUri(_queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _citymapperWebUri(_queryParameters);
}

/// Builds coordinate directions in Citymapper.
class CitymapperDirectionsWithCoordsAction extends Citymapper
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a Citymapper coordinate directions action.
  CitymapperDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.origin,
    this.destinationTitle,
    this.originTitle,
    this.destinationAddress,
    this.originAddress,
    this.arriveBy,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional origin coordinate.
  final Coordinate? origin;

  /// Optional destination label.
  final String? destinationTitle;

  /// Optional origin label.
  final String? originTitle;

  /// Optional destination address.
  final String? destinationAddress;

  /// Optional origin address.
  final String? originAddress;

  /// Optional arrival time.
  final DateTime? arriveBy;

  Map<String, String> get _queryParameters => {
        'endcoord': destination.toString(),
        if (destinationTitle != null) 'endname': destinationTitle!,
        if (destinationAddress != null) 'endaddress': destinationAddress!,
        if (origin != null) 'startcoord': origin!.toString(),
        if (originTitle != null) 'startname': originTitle!,
        if (originAddress != null) 'startaddress': originAddress!,
        if (arriveBy != null) 'arriveby': arriveBy!.toIso8601String(),
      };

  @override
  Uri get appLink => _citymapperAppUri(_queryParameters);

  @override
  AndroidIntentOption get androidIntentOptions => _androidIntentOptions(this);

  @override
  Uri get fallbackLink => _citymapperWebUri(_queryParameters);
}

Uri _citymapperAppUri(final Map<String, String> queryParameters) => Uri(
      scheme: 'citymapper',
      host: 'directions',
      queryParameters: queryParameters,
    );

Uri _citymapperWebUri(final Map<String, String> queryParameters) => Uri(
      scheme: 'https',
      host: 'citymapper.com',
      path: 'directions',
      queryParameters: queryParameters,
    );

AndroidIntentOption _androidIntentOptions(final IntentAppLinkAction action) => AndroidIntentOption(
      action: 'action_view',
      data: action.appLink.toString(),
      package: 'com.citymapper.app.release',
      flags: const [0x10000000],
    );

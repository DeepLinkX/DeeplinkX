import 'package:deeplink_x/src/src.dart';

const _newTaskFlag = 0x10000000;

/// CoPilot GPS Navigation app for iOS and Android.
class Copilot extends App implements DownloadableApp {
  /// Creates a new [Copilot] instance.
  Copilot({this.fallbackToStore = false});

  /// Creates an action to open CoPilot.
  factory Copilot.open({final bool fallbackToStore = false}) => Copilot(fallbackToStore: fallbackToStore);

  /// Store actions for CoPilot.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.alk.copilot.mapviewer'),
        IOSAppStore.openAppPage(appId: '504677517', appName: 'copilot-gps-navigation'),
      ];

  /// Android package name.
  @override
  String get androidPackageName => 'com.alk.copilot.mapviewer';

  /// Custom scheme.
  @override
  String get customScheme => 'copilot';

  /// macOS is not supported.
  @override
  String? get macosBundleIdentifier => null;

  /// Supported mobile platforms.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to redirect to a store listing when the native app is missing.
  @override
  bool fallbackToStore;

  /// CoPilot website.
  @override
  Uri get website => Uri.parse('https://copilotgps.com/');

  /// Creates an action that shows [coordinate] in CoPilot.
  static CopilotViewAction view({
    required final Coordinate coordinate,
    final String? title,
    final bool fallbackToStore = false,
  }) =>
      CopilotViewAction(
        coordinate: coordinate,
        fallbackToStore: fallbackToStore,
        title: title,
      );

  /// Creates a coordinate navigation action.
  static CopilotDirectionsWithCoordsAction directionsWithCoords({
    required final Coordinate destination,
    final String? destinationTitle,
    final bool fallbackToStore = false,
  }) =>
      CopilotDirectionsWithCoordsAction(
        destination: destination,
        destinationTitle: destinationTitle,
        fallbackToStore: fallbackToStore,
      );
}

/// Shows a coordinate in CoPilot.
class CopilotViewAction extends Copilot implements IntentAppLinkAction, Fallbackable, MapViewAction {
  /// Creates a new [CopilotViewAction].
  CopilotViewAction({
    required this.coordinate,
    required super.fallbackToStore,
    this.title,
  });

  /// Coordinate to display.
  @override
  final Coordinate coordinate;

  /// Optional marker title.
  final String? title;

  @override
  Uri get appLink => _buildCopilotUri({
        'type': 'LOCATION',
        'action': 'VIEW',
        'marker': coordinate.toString(),
        if (title != null && title!.isNotEmpty) 'name': title!,
      });

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [_newTaskFlag],
      );

  @override
  Uri get fallbackLink => website;
}

/// Builds a coordinate route in CoPilot.
class CopilotDirectionsWithCoordsAction extends Copilot
    implements IntentAppLinkAction, Fallbackable, MapDirectionsWithCoordsAction {
  /// Creates a new [CopilotDirectionsWithCoordsAction].
  CopilotDirectionsWithCoordsAction({
    required this.destination,
    required super.fallbackToStore,
    this.destinationTitle,
  });

  /// Destination coordinate.
  @override
  final Coordinate destination;

  /// Optional destination label.
  final String? destinationTitle;

  @override
  Uri get appLink => _buildCopilotUri({
        'type': 'LOCATION',
        'action': 'GOTO',
        if (destinationTitle != null && destinationTitle!.isNotEmpty) 'name': destinationTitle!,
        'lat': destination.latitude.toString(),
        'long': destination.longitude.toString(),
      });

  @override
  AndroidIntentOption get androidIntentOptions => AndroidIntentOption(
        action: 'action_view',
        data: appLink.toString(),
        package: androidPackageName,
        flags: const [_newTaskFlag],
      );

  @override
  Uri get fallbackLink => website;
}

Uri _buildCopilotUri(final Map<String, String> queryParameters) => Uri(
      scheme: 'copilot',
      host: 'mydestination',
      queryParameters: queryParameters,
    );

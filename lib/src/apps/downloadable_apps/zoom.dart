import 'package:deeplink_x/src/src.dart';

/// Zoom application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the Zoom app on various platforms.
class Zoom extends App implements DownloadableApp {
  /// Creates a new [Zoom] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Zoom app is not installed. Default is false.
  Zoom({this.fallbackToStore = false});

  /// Creates an action to open the Zoom app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Zoom app is not installed. Default is false.
  ///
  /// Returns a [Zoom] instance that can be used to open the Zoom app.
  factory Zoom.open({final bool fallbackToStore = false}) => Zoom(fallbackToStore: fallbackToStore);

  /// A list of actions to open the Zoom app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'us.zoom.videomeetings'),
        IOSAppStore.openAppPage(appId: '546505307', appName: 'zoom-cloud-meetings'),
        MicrosoftStore.openAppPage(productId: 'xp99j3kp4xz4vv'),
      ];

  /// The Android package name for the Zoom app.
  @override
  String get androidPackageName => 'us.zoom.videomeetings';

  /// The custom URL scheme for the Zoom app.
  @override
  String get customScheme => 'zoomus';

  /// The MacOS bundle identifier for the Zoom app.
  @override
  String get macosBundleIdentifier => 'us.zoom.xos';

  /// The platforms that the Zoom app supports.
  @override
  List<PlatformType> get supportedPlatforms => [
        PlatformType.android,
        PlatformType.ios,
        PlatformType.macos,
        PlatformType.windows,
        PlatformType.linux,
      ];

  /// Whether to automatically redirect to app stores when the Zoom app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for Zoom.
  @override
  Uri get website => Uri.parse('https://zoom.us');

  /// Creates an action to join a Zoom meeting.
  ///
  /// Parameters:
  /// - [meetingId]: The ID of the meeting to join.
  /// - [password]: Optional password for the meeting.
  /// - [displayName]: Optional display name to use when joining the meeting.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Zoom app is not installed. Default is false.
  ///
  /// Returns a [ZoomJoinMeetingAction] instance that can be used to join
  /// the specified meeting in the Zoom app.
  static ZoomJoinMeetingAction joinMeeting({
    required final String meetingId,
    final String? password,
    final String? displayName,
    final bool fallbackToStore = false,
  }) =>
      ZoomJoinMeetingAction(
        meetingId: meetingId,
        password: password,
        displayName: displayName,
        fallbackToStore: fallbackToStore,
      );
}

/// An action to join a Zoom meeting.
///
/// This class extends [Zoom] and implements multiple interfaces to provide
/// comprehensive functionality for joining meetings with fallback support.
class ZoomJoinMeetingAction extends Zoom implements AppLinkAppAction, Fallbackable {
  /// Creates a new [ZoomJoinMeetingAction] instance.
  ///
  /// Parameters:
  /// - [meetingId]: The ID of the meeting to join.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Zoom app is not installed.
  /// - [password]: Optional password for the meeting.
  /// - [displayName]: Optional display name to use when joining the meeting.
  ZoomJoinMeetingAction({
    required this.meetingId,
    required super.fallbackToStore,
    this.password,
    this.displayName,
  });

  /// The ID of the meeting to join.
  final String meetingId;

  /// Optional password for the meeting.
  final String? password;

  /// Optional display name to use when joining the meeting.
  final String? displayName;

  /// The app link URL for joining the specified meeting in the Zoom app.
  @override
  Uri get appLink => Uri(
        scheme: 'zoomus',
        host: 'zoom.us',
        path: 'join',
        queryParameters: {
          'confno': meetingId,
          if (password != null) 'pwd': password,
          if (displayName != null) 'uname': displayName,
        },
      );

  /// The fallback link to use when the Zoom app cannot be opened.
  ///
  /// This URL opens the specified meeting on the Zoom web interface.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'zoom.us',
        pathSegments: ['j', meetingId],
        queryParameters: {
          if (password != null) 'pwd': password,
          if (displayName != null) 'uname': displayName,
        },
      );
}

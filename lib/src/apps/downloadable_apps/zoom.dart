import 'package:deeplink_x/src/src.dart';

/// Zoom application.
///
/// Provides deeplink support for joining and starting Zoom meetings.
class Zoom extends App implements DownloadableApp {
  /// Creates a new [Zoom] instance.
  Zoom({this.fallbackToStore = false});

  /// Creates an action to open the Zoom app.
  factory Zoom.open({bool fallbackToStore = false}) => Zoom(fallbackToStore: fallbackToStore);

  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'us.zoom.videomeetings'),
        IOSAppStore.openAppPage(appId: '546505307', appName: 'zoom-cloud-meetings'),
        MacAppStore.openAppPage(appId: '546505307', appName: 'zoom.us'),
      ];

  @override
  String get androidPackageName => 'us.zoom.videomeetings';

  @override
  String get customScheme => 'zoomus';

  @override
  String get macosBundleIdentifier => 'us.zoom.Zoom';

  @override
  List<PlatformType> get supportedPlatforms => [
        PlatformType.android,
        PlatformType.ios,
        PlatformType.macos,
      ];

  @override
  bool fallbackToStore;

  @override
  Uri get website => Uri.parse('https://zoom.us');

  /// Creates an action to join a Zoom meeting.
  static ZoomJoinMeetingAction joinMeeting({
    required String meetingId,
    String? password,
    String? displayName,
    bool fallbackToStore = false,
  }) =>
      ZoomJoinMeetingAction(
        meetingId: meetingId,
        password: password,
        displayName: displayName,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to start a Zoom meeting.
  static ZoomStartMeetingAction startMeeting({
    required String meetingId,
    String? password,
    String? displayName,
    bool fallbackToStore = false,
  }) =>
      ZoomStartMeetingAction(
        meetingId: meetingId,
        password: password,
        displayName: displayName,
        fallbackToStore: fallbackToStore,
      );
}

/// Action to join a Zoom meeting.
class ZoomJoinMeetingAction extends Zoom implements AppLinkAppAction, Fallbackable {
  ZoomJoinMeetingAction({
    required this.meetingId,
    this.password,
    this.displayName,
    required super.fallbackToStore,
  });

  final String meetingId;
  final String? password;
  final String? displayName;

  @override
  Uri get appLink => Uri(
        scheme: 'zoomus',
        host: 'zoom.us',
        path: 'join',
        queryParameters: {
          'confno': meetingId,
          if (password != null) 'pwd': password!,
          if (displayName != null) 'uname': displayName!,
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'zoom.us',
        pathSegments: ['j', meetingId],
        queryParameters: {
          if (password != null) 'pwd': password!,
        },
      );
}

/// Action to start a Zoom meeting.
class ZoomStartMeetingAction extends Zoom implements AppLinkAppAction, Fallbackable {
  ZoomStartMeetingAction({
    required this.meetingId,
    this.password,
    this.displayName,
    required super.fallbackToStore,
  });

  final String meetingId;
  final String? password;
  final String? displayName;

  @override
  Uri get appLink => Uri(
        scheme: 'zoomus',
        host: 'zoom.us',
        path: 'start',
        queryParameters: {
          'confno': meetingId,
          if (password != null) 'pwd': password!,
          if (displayName != null) 'uname': displayName!,
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'zoom.us',
        pathSegments: ['j', meetingId],
        queryParameters: {
          if (password != null) 'pwd': password!,
        },
      );
}

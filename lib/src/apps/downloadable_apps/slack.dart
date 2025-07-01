import 'package:deeplink_x/src/src.dart';

/// Slack application.
class Slack extends App implements DownloadableApp {
  /// Creates a new [Slack] instance.
  Slack({this.fallbackToStore = false});

  /// Creates an action to open the Slack app.
  factory Slack.open({final bool fallbackToStore = false}) => Slack(fallbackToStore: fallbackToStore);

  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.Slack'),
        IOSAppStore.openAppPage(appId: '618783545', appName: 'slack'),
        MicrosoftStore.openAppPage(productId: '9wzdncrdk3wp'),
        MacAppStore.openAppPage(appId: '803453959', appName: 'slack'),
      ];

  @override
  String get androidPackageName => 'com.Slack';

  @override
  String get customScheme => 'slack';

  @override
  String get macosBundleIdentifier => 'com.tinyspeck.slackmacgap';

  @override
  List<PlatformType> get supportedPlatforms => [
        PlatformType.ios,
        PlatformType.android,
        PlatformType.macos,
        PlatformType.windows,
      ];

  @override
  bool fallbackToStore;

  @override
  Uri get website => Uri.parse('https://slack.com');

  /// Opens Slack workspace by team ID.
  static SlackOpenTeamAction openTeam({
    required final String teamId,
    final bool fallbackToStore = false,
  }) =>
      SlackOpenTeamAction(teamId: teamId, fallbackToStore: fallbackToStore);

  /// Opens Slack channel by channel ID and team ID.
  static SlackOpenChannelAction openChannel({
    required final String teamId,
    required final String channelId,
    final bool fallbackToStore = false,
  }) =>
      SlackOpenChannelAction(
        teamId: teamId,
        channelId: channelId,
        fallbackToStore: fallbackToStore,
      );

  /// Opens Slack direct message with user ID.
  static SlackOpenUserAction openUser({
    required final String teamId,
    required final String userId,
    final bool fallbackToStore = false,
  }) =>
      SlackOpenUserAction(
        teamId: teamId,
        userId: userId,
        fallbackToStore: fallbackToStore,
      );
}

/// Action to open a specific team in Slack.
class SlackOpenTeamAction extends Slack implements AppLinkAppAction, Fallbackable {
  /// Creates a new [SlackOpenTeamAction].
  SlackOpenTeamAction({required this.teamId, required super.fallbackToStore});

  /// The ID of the Slack team to open.
  final String teamId;

  @override
  Uri get appLink => Uri(
        scheme: 'slack',
        host: 'open',
        queryParameters: {
          'team': teamId,
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'app.slack.com',
        pathSegments: [
          'client',
          teamId,
        ],
      );
}

/// Action to open a Slack channel.
class SlackOpenChannelAction extends Slack implements AppLinkAppAction, Fallbackable {
  /// Creates a new [SlackOpenChannelAction].
  SlackOpenChannelAction({
    required this.teamId,
    required this.channelId,
    required super.fallbackToStore,
  });

  /// The team ID of the workspace.
  final String teamId;

  /// The channel ID to open.
  final String channelId;

  @override
  Uri get appLink => Uri(
        scheme: 'slack',
        host: 'channel',
        queryParameters: {
          'team': teamId,
          'id': channelId,
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'app.slack.com',
        pathSegments: [
          'client',
          teamId,
          channelId,
        ],
      );
}

/// Action to open a Slack direct message.
///
/// Opens a direct message with the given user ID on the specified team.
class SlackOpenUserAction extends Slack implements AppLinkAppAction, Fallbackable {
  /// Creates a new [SlackOpenUserAction].
  SlackOpenUserAction({
    required this.teamId,
    required this.userId,
    required super.fallbackToStore,
  });

  /// The team ID of the workspace.
  final String teamId;

  /// The user ID to open the DM with.
  final String userId;

  @override
  Uri get appLink => Uri(
        scheme: 'slack',
        host: 'user',
        queryParameters: {
          'team': teamId,
          'id': userId,
        },
      );

  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'app.slack.com',
        pathSegments: [
          'client',
          teamId,
          userId,
        ],
      );
}

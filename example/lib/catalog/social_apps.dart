import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/catalog/models.dart';
import 'package:flutter/material.dart';

/// Social and communication apps shown in the example gallery.
final List<AppSpec> socialApps = [
  AppSpec(
    id: 'instagram',
    name: 'Instagram',
    assetName: 'assets/instagram.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Instagram.open(fallbackToStore)',
        buttonLabel: 'Open Instagram',
        runner: OpenAppRunner(({required final fallbackToStore}) => Instagram.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Open profile',
        apiLabel: 'Instagram.openProfile(username)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'username', label: 'Username', defaultValue: 'instagram')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Instagram.openProfile(username: v.value('username'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'telegram',
    name: 'Telegram',
    assetName: 'assets/telegram.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Telegram.open(fallbackToStore)',
        buttonLabel: 'Open Telegram',
        runner: OpenAppRunner(({required final fallbackToStore}) => Telegram.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Open profile',
        apiLabel: 'Telegram.openProfile(username)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'username', label: 'Username', defaultValue: 'durov')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Telegram.openProfile(username: v.value('username'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.call_rounded,
        title: 'Profile by phone',
        apiLabel: 'Telegram.openProfileByPhoneNumber(phoneNumber)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'phone', label: 'Phone number', defaultValue: '14155552671')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Telegram.openProfileByPhoneNumber(phoneNumber: v.value('phone'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.send_rounded,
        title: 'Send message',
        apiLabel: 'Telegram.sendMessage(username, message)',
        buttonLabel: 'Send message',
        fields: const [
          ActionField(key: 'username', label: 'Username', defaultValue: 'durov'),
          ActionField(key: 'message', label: 'Message', defaultValue: 'Hello! How are you?'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Telegram.sendMessage(
            username: v.value('username'),
            message: v.value('message'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.forward_to_inbox_rounded,
        title: 'Message by phone',
        apiLabel: 'Telegram.sendMessageByPhoneNumber(phoneNumber, message)',
        buttonLabel: 'Send message',
        fields: const [
          ActionField(key: 'phone', label: 'Phone number', defaultValue: '14155552671'),
          ActionField(key: 'message', label: 'Message', defaultValue: 'Hello! How are you?'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Telegram.sendMessageByPhoneNumber(
            phoneNumber: v.value('phone'),
            message: v.value('message'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'whatsapp',
    name: 'WhatsApp',
    assetName: 'assets/whatsapp.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'WhatsApp.open(fallbackToStore)',
        buttonLabel: 'Open WhatsApp',
        runner: OpenAppRunner(({required final fallbackToStore}) => WhatsApp.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.chat_rounded,
        title: 'Chat with number',
        apiLabel: 'WhatsApp.chat(phoneNumber, message)',
        buttonLabel: 'Start chat',
        fields: const [
          ActionField(key: 'phone', label: 'Phone number', defaultValue: '14155552671'),
          ActionField(key: 'message', label: 'Message (optional)', defaultValue: 'Hello! How are you?', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => WhatsApp.chat(
            phoneNumber: v.value('phone'),
            message: v.optionalValue('message'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.share_rounded,
        title: 'Share text',
        apiLabel: 'WhatsApp.shareText(text)',
        buttonLabel: 'Share',
        fields: const [
          ActionField(key: 'text', label: 'Share text', defaultValue: 'Try DeeplinkX for type-safe Flutter deeplinks.'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              WhatsApp.shareText(text: v.value('text'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'facebook',
    name: 'Facebook',
    assetName: 'assets/facebook.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Facebook.open(fallbackToStore)',
        buttonLabel: 'Open Facebook',
        runner: OpenAppRunner(({required final fallbackToStore}) => Facebook.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.badge_rounded,
        title: 'Profile by ID',
        apiLabel: 'Facebook.openProfileById(id)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'id', label: 'Profile ID', defaultValue: '4')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Facebook.openProfileById(id: v.value('id'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Profile by username',
        apiLabel: 'Facebook.openProfileByUsername(username)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'username', label: 'Username', defaultValue: 'zuck')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Facebook.openProfileByUsername(username: v.value('username'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.flag_rounded,
        title: 'Open page',
        apiLabel: 'Facebook.openPage(pageId)',
        buttonLabel: 'Open page',
        fields: const [ActionField(key: 'pageId', label: 'Page ID', defaultValue: 'facebookapp')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Facebook.openPage(pageId: v.value('pageId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.groups_rounded,
        title: 'Open group',
        apiLabel: 'Facebook.openGroup(groupId)',
        buttonLabel: 'Open group',
        fields: const [ActionField(key: 'groupId', label: 'Group ID', defaultValue: '231104380821004')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Facebook.openGroup(groupId: v.value('groupId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.event_rounded,
        title: 'Open event',
        apiLabel: 'Facebook.openEvent(eventId)',
        buttonLabel: 'Open event',
        fields: const [ActionField(key: 'eventId', label: 'Event ID', defaultValue: '10155945715431729')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Facebook.openEvent(eventId: v.value('eventId'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'linkedin',
    name: 'LinkedIn',
    assetName: 'assets/linkedin.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'LinkedIn.open(fallbackToStore)',
        buttonLabel: 'Open LinkedIn',
        runner: OpenAppRunner(({required final fallbackToStore}) => LinkedIn.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Open profile',
        apiLabel: 'LinkedIn.openProfile(profileId)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'profileId', label: 'Profile ID', defaultValue: 'satyanadella')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              LinkedIn.openProfile(profileId: v.value('profileId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.business_center_rounded,
        title: 'Company page',
        apiLabel: 'LinkedIn.openCompany(companyId)',
        buttonLabel: 'Open company',
        fields: const [ActionField(key: 'companyId', label: 'Company ID', defaultValue: 'microsoft')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              LinkedIn.openCompany(companyId: v.value('companyId'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'youtube',
    name: 'YouTube',
    assetName: 'assets/youtube.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'YouTube.open(fallbackToStore)',
        buttonLabel: 'Open YouTube',
        runner: OpenAppRunner(({required final fallbackToStore}) => YouTube.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.play_circle_rounded,
        title: 'Open video',
        apiLabel: 'YouTube.openVideo(videoId)',
        buttonLabel: 'Open video',
        fields: const [ActionField(key: 'videoId', label: 'Video ID', defaultValue: 'dQw4w9WgXcQ')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YouTube.openVideo(videoId: v.value('videoId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.subscriptions_rounded,
        title: 'Open channel',
        apiLabel: 'YouTube.openChannel(channelId)',
        buttonLabel: 'Open channel',
        fields: const [ActionField(key: 'channelId', label: 'Channel ID', defaultValue: 'UCq-Fj5jknLsUf-MWSy4_brA')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YouTube.openChannel(channelId: v.value('channelId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.playlist_play_rounded,
        title: 'Open playlist',
        apiLabel: 'YouTube.openPlaylist(playlistId)',
        buttonLabel: 'Open playlist',
        fields: const [
          ActionField(key: 'playlistId', label: 'Playlist ID', defaultValue: 'PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YouTube.openPlaylist(playlistId: v.value('playlistId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search',
        apiLabel: 'YouTube.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: 'flutter deeplinks')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YouTube.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'twitter',
    name: 'Twitter',
    assetName: 'assets/twitter.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Twitter.open(fallbackToStore)',
        buttonLabel: 'Open Twitter',
        runner: OpenAppRunner(({required final fallbackToStore}) => Twitter.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Open profile',
        apiLabel: 'Twitter.openProfile(username)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'username', label: 'Username', defaultValue: 'jack')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Twitter.openProfile(username: v.value('username'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.chat_bubble_rounded,
        title: 'Open tweet',
        apiLabel: 'Twitter.openTweet(tweetId)',
        buttonLabel: 'Open tweet',
        fields: const [ActionField(key: 'tweetId', label: 'Tweet ID', defaultValue: '20')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Twitter.openTweet(tweetId: v.value('tweetId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search',
        apiLabel: 'Twitter.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: 'deeplink_x')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Twitter.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'threads',
    name: 'Threads',
    assetName: 'assets/threads.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Threads.open(fallbackToStore)',
        buttonLabel: 'Open Threads',
        runner: OpenAppRunner(({required final fallbackToStore}) => Threads.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Open profile',
        apiLabel: 'Threads.openProfile(username)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'username', label: 'Username', defaultValue: 'zuck')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Threads.openProfile(username: v.value('username'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.article_rounded,
        title: 'Open post',
        apiLabel: 'Threads.openPost(username, postId)',
        buttonLabel: 'Open post',
        fields: const [
          ActionField(key: 'username', label: 'Username', defaultValue: 'zuck'),
          ActionField(key: 'postId', label: 'Post ID', defaultValue: 'DY11ZLWG_eY'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Threads.openPost(
            username: v.value('username'),
            postId: v.value('postId'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.forum_rounded,
        title: 'Open comments',
        apiLabel: 'Threads.openComments(username, postId)',
        buttonLabel: 'Open comments',
        fields: const [
          ActionField(key: 'username', label: 'Username', defaultValue: 'zuck'),
          ActionField(key: 'postId', label: 'Post ID', defaultValue: 'DY11ZLWG_eY'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Threads.openComments(
            username: v.value('username'),
            postId: v.value('postId'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.edit_rounded,
        title: 'Create post',
        apiLabel: 'Threads.createPost(text)',
        buttonLabel: 'Create post',
        fields: const [ActionField(key: 'text', label: 'Text', defaultValue: 'Hello from DeeplinkX')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Threads.createPost(text: v.value('text'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search',
        apiLabel: 'Threads.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: 'flutter')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Threads.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.tag_rounded,
        title: 'Open topic tag',
        apiLabel: 'Threads.openTag(tag)',
        buttonLabel: 'Open tag',
        fields: const [ActionField(key: 'tag', label: 'Tag', defaultValue: 'Flutter')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Threads.openTag(tag: v.value('tag'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'pinterest',
    name: 'Pinterest',
    assetName: 'assets/pinterest.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Pinterest.open(fallbackToStore)',
        buttonLabel: 'Open Pinterest',
        runner: OpenAppRunner(({required final fallbackToStore}) => Pinterest.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Open profile',
        apiLabel: 'Pinterest.openProfile(username)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'username', label: 'Username', defaultValue: 'pinterest')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Pinterest.openProfile(username: v.value('username'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.push_pin_rounded,
        title: 'Open pin',
        apiLabel: 'Pinterest.openPin(pinId)',
        buttonLabel: 'Open pin',
        fields: const [ActionField(key: 'pinId', label: 'Pin ID', defaultValue: '1120622319784769688')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Pinterest.openPin(pinId: v.value('pinId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search',
        apiLabel: 'Pinterest.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: 'minimal ui')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Pinterest.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.dashboard_rounded,
        title: 'Open board',
        apiLabel: 'Pinterest.openBoard(username, board)',
        buttonLabel: 'Open board',
        fields: const [
          ActionField(key: 'username', label: 'Username', defaultValue: 'pinterest'),
          ActionField(key: 'board', label: 'Board', defaultValue: 'official-news'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Pinterest.openBoard(
            username: v.value('username'),
            board: v.value('board'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'tiktok',
    name: 'TikTok',
    assetName: 'assets/tiktok.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'TikTok.open(fallbackToStore)',
        buttonLabel: 'Open TikTok',
        runner: OpenAppRunner(({required final fallbackToStore}) => TikTok.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Open profile',
        apiLabel: 'TikTok.openProfile(username)',
        buttonLabel: 'Open profile',
        fields: const [ActionField(key: 'username', label: 'Username', defaultValue: 'tiktok')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              TikTok.openProfile(username: v.value('username'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.play_circle_rounded,
        title: 'Open video',
        apiLabel: 'TikTok.openVideo(username, videoId)',
        buttonLabel: 'Open video',
        fields: const [
          ActionField(key: 'username', label: 'Username', defaultValue: 'tiktok'),
          ActionField(key: 'videoId', label: 'Video ID', defaultValue: '7511774168241704222'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => TikTok.openVideo(
            videoId: v.value('videoId'),
            username: v.value('username'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.tag_rounded,
        title: 'Open tag',
        apiLabel: 'TikTok.openTag(tagName)',
        buttonLabel: 'Open tag',
        fields: const [ActionField(key: 'tagName', label: 'Tag', defaultValue: 'flutter')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              TikTok.openTag(tagName: v.value('tagName'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'zoom',
    name: 'Zoom',
    assetName: 'assets/zoom.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Zoom.open(fallbackToStore)',
        buttonLabel: 'Open Zoom',
        runner: OpenAppRunner(({required final fallbackToStore}) => Zoom.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.videocam_rounded,
        title: 'Join meeting',
        apiLabel: 'Zoom.joinMeeting(meetingId, password, displayName)',
        buttonLabel: 'Join meeting',
        fields: const [
          ActionField(key: 'meetingId', label: 'Meeting ID', placeholder: '0000000000'),
          ActionField(key: 'password', label: 'Password (optional)', optional: true),
          ActionField(key: 'displayName', label: 'Display name (optional)', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Zoom.joinMeeting(
            meetingId: v.value('meetingId'),
            password: v.optionalValue('password'),
            displayName: v.optionalValue('displayName'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'slack',
    name: 'Slack',
    assetName: 'assets/slack.png',
    category: CatalogCategory.social,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Slack.open(fallbackToStore)',
        buttonLabel: 'Open Slack',
        runner: OpenAppRunner(({required final fallbackToStore}) => Slack.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.workspaces_rounded,
        title: 'Open team',
        apiLabel: 'Slack.openTeam(teamId)',
        buttonLabel: 'Open team',
        fields: const [ActionField(key: 'teamId', label: 'Workspace ID', placeholder: 'T00000000')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Slack.openTeam(teamId: v.value('teamId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.tag_rounded,
        title: 'Open channel',
        apiLabel: 'Slack.openChannel(teamId, channelId)',
        buttonLabel: 'Open channel',
        fields: const [
          ActionField(key: 'teamId', label: 'Workspace ID', placeholder: 'T00000000'),
          ActionField(key: 'channelId', label: 'Channel ID', placeholder: 'C00000000'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Slack.openChannel(
            teamId: v.value('teamId'),
            channelId: v.value('channelId'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.person_rounded,
        title: 'Open user',
        apiLabel: 'Slack.openUser(teamId, userId)',
        buttonLabel: 'Open user',
        fields: const [
          ActionField(key: 'teamId', label: 'Workspace ID', placeholder: 'T00000000'),
          ActionField(key: 'userId', label: 'User ID', placeholder: 'U00000000'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Slack.openUser(teamId: v.value('teamId'), userId: v.value('userId'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
];

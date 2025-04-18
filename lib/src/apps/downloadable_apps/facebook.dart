import 'package:deeplink_x/src/src.dart';

/// Facebook application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the Facebook app on various platforms.
class Facebook extends App implements DownloadableApp {
  /// Creates a new [Facebook] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed. Default is false.
  Facebook({this.fallbackToStore = false});

  /// Creates an action to open the Facebook app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed. Default is false.
  ///
  /// Returns a [Facebook] instance that can be used to open the Facebook app.
  factory Facebook.open({final bool fallbackToStore = false}) => Facebook(fallbackToStore: fallbackToStore);

  /// A list of actions to open the Facebook app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.facebook.katana'),
        IOSAppStore.openAppPage(appId: '284882215', appName: 'facebook'),
        MicrosoftStore.openAppPage(productId: '9wzdncrfj2wl'),
      ];

  /// The Android package name for the Facebook app.
  @override
  String get androidPackageName => 'com.facebook.katana';

  /// The custom URL scheme for the Facebook app.
  @override
  String get customScheme => 'fb';

  /// The MacOS bundle identifier for the Facebook app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the Facebook app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android, PlatformType.windows];

  /// Whether to automatically redirect to app stores when the Facebook app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for Facebook.
  @override
  Uri get website => Uri.parse('https://www.facebook.com');

  /// Creates an action to open a specific profile by ID in the Facebook app.
  ///
  /// Parameters:
  /// - [id]: The ID of the profile to open. (e.g. '123456789')
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed. Default is false.
  ///
  /// Returns a [FacebookOpenProfileByIdAction] instance that can be used to open
  /// the specified profile in the Facebook app.
  static FacebookOpenProfileByIdAction openProfileById({
    required final String id,
    final bool fallbackToStore = false,
  }) =>
      FacebookOpenProfileByIdAction(
        id: id,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific profile by username in the Facebook app.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open. (e.g. 'johndoe')
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed. Default is false.
  ///
  /// Returns a [FacebookOpenProfileByUsernameAction] instance that can be used to open
  /// the specified profile in the Facebook app.
  static FacebookOpenProfileByUsernameAction openProfileByUsername({
    required final String username,
    final bool fallbackToStore = false,
  }) =>
      FacebookOpenProfileByUsernameAction(
        username: username,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific page in the Facebook app.
  ///
  /// Parameters:
  /// - [pageId]: The ID of the page to open. (e.g. 'facebookapp')
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed. Default is false.
  ///
  /// Returns a [FacebookOpenPageAction] instance that can be used to open
  /// the specified page in the Facebook app.
  static FacebookOpenPageAction openPage({
    required final String pageId,
    final bool fallbackToStore = false,
  }) =>
      FacebookOpenPageAction(
        pageId: pageId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific group in the Facebook app.
  ///
  /// Parameters:
  /// - [groupId]: The ID of the group to open. (e.g. '231104380821004')
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed. Default is false.
  ///
  /// Returns a [FacebookOpenGroupAction] instance that can be used to open
  /// the specified group in the Facebook app.
  static FacebookOpenGroupAction openGroup({
    required final String groupId,
    final bool fallbackToStore = false,
  }) =>
      FacebookOpenGroupAction(
        groupId: groupId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific event in the Facebook app.
  ///
  /// Parameters:
  /// - [eventId]: The ID of the event to open. (e.g. '10155945715431729')
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed. Default is false.
  ///
  /// Returns a [FacebookOpenEventAction] instance that can be used to open
  /// the specified event in the Facebook app.
  static FacebookOpenEventAction openEvent({
    required final String eventId,
    final bool fallbackToStore = false,
  }) =>
      FacebookOpenEventAction(
        eventId: eventId,
        fallbackToStore: fallbackToStore,
      );
}

/// An action to open a specific profile by ID in the Facebook app.
///
/// This class extends [Facebook] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class FacebookOpenProfileByIdAction extends Facebook implements AppLinkAppAction, Fallbackable {
  /// Creates a new [FacebookOpenProfileByIdAction] instance.
  ///
  /// Parameters:
  /// - [id]: The ID of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed.
  FacebookOpenProfileByIdAction({
    required this.id,
    required super.fallbackToStore,
  });

  /// The ID of the profile to open.
  final String id;

  /// The app link URL for opening the specified profile in the Facebook app.
  @override
  Uri get appLink => Uri(
        scheme: 'fb',
        host: 'profile',
        path: id,
      );

  /// The fallback link to use when the Facebook app cannot be opened.
  ///
  /// This URL opens the specified profile on the Facebook website.
  @override
  Uri get fallbackLink => Uri(
        scheme: 'https',
        host: 'www.facebook.com',
        path: id,
      );
}

/// An action to open a specific profile by username in the Facebook app.
///
/// This class extends [Facebook] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class FacebookOpenProfileByUsernameAction extends Facebook implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [FacebookOpenProfileByUsernameAction] instance.
  ///
  /// Parameters:
  /// - [username]: The username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed.
  FacebookOpenProfileByUsernameAction({
    required this.username,
    required super.fallbackToStore,
  });

  /// The username of the profile to open.
  final String username;

  /// The fallback link to use when the Facebook app cannot be opened.
  ///
  /// This URL opens the specified profile on the Facebook website.
  @override
  Uri get fallbackLink => universalLink;

  /// The universal link URL for opening the specified profile in the Facebook app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.facebook.com',
        path: username,
      );
}

/// An action to open a specific page in the Facebook app.
///
/// This class extends [Facebook] and implements multiple interfaces to provide
/// comprehensive functionality for opening pages with fallback support.
class FacebookOpenPageAction extends Facebook implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [FacebookOpenPageAction] instance.
  ///
  /// Parameters:
  /// - [pageId]: The ID of the page to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed.
  FacebookOpenPageAction({
    required this.pageId,
    required super.fallbackToStore,
  });

  /// The ID of the page to open.
  final String pageId;

  /// The fallback link to use when the Facebook app cannot be opened.
  ///
  /// This URL opens the specified page on the Facebook website.
  @override
  Uri get fallbackLink => universalLink;

  /// The universal link URL for opening the specified page in the Facebook app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.facebook.com',
        path: pageId,
      );
}

/// An action to open a specific group in the Facebook app.
///
/// This class extends [Facebook] and implements multiple interfaces to provide
/// comprehensive functionality for opening groups with fallback support.
class FacebookOpenGroupAction extends Facebook implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [FacebookOpenGroupAction] instance.
  ///
  /// Parameters:
  /// - [groupId]: The ID of the group to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed.
  FacebookOpenGroupAction({
    required this.groupId,
    required super.fallbackToStore,
  });

  /// The ID of the group to open.
  final String groupId;

  /// The fallback link to use when the Facebook app cannot be opened.
  ///
  /// This URL opens the specified group on the Facebook website.
  @override
  Uri get fallbackLink => universalLink;

  /// The universal link URL for opening the specified group in the Facebook app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.facebook.com',
        pathSegments: ['groups', groupId],
      );
}

/// An action to open a specific event in the Facebook app.
///
/// This class extends [Facebook] and implements multiple interfaces to provide
/// comprehensive functionality for opening events with fallback support.
class FacebookOpenEventAction extends Facebook implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [FacebookOpenEventAction] instance.
  ///
  /// Parameters:
  /// - [eventId]: The ID of the event to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the Facebook app is not installed.
  FacebookOpenEventAction({
    required this.eventId,
    required super.fallbackToStore,
  });

  /// The ID of the event to open.
  final String eventId;

  /// The fallback link to use when the Facebook app cannot be opened.
  ///
  /// This URL opens the specified event on the Facebook website.
  @override
  Uri get fallbackLink => universalLink;

  /// The universal link URL for opening the specified event in the Facebook app.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.facebook.com',
        pathSegments: ['events', eventId],
      );
}

import 'package:deeplink_x/src/src.dart';

/// LinkedIn application.
///
/// This class implements the [DownloadableApp] interface to provide capabilities
/// for interacting with the LinkedIn app on various platforms.
class LinkedIn extends App implements DownloadableApp {
  /// Creates a new [LinkedIn] instance.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the LinkedIn app is not installed. Default is false.
  LinkedIn({this.fallbackToStore = false});

  /// Creates an action to open the LinkedIn app.
  ///
  /// Parameters:
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the LinkedIn app is not installed. Default is false.
  ///
  /// Returns a [LinkedIn] instance that can be used to open the LinkedIn app.
  factory LinkedIn.open({final bool fallbackToStore = false}) => LinkedIn(fallbackToStore: fallbackToStore);

  /// A list of actions to open the LinkedIn app's page in various app stores.
  @override
  List<StoreOpenAppPageAction> get storeActions => [
        PlayStore.openAppPage(packageName: 'com.linkedin.android'),
        IOSAppStore.openAppPage(
          appId: '288429040',
          appName: 'linkedin-network-job-finder',
        ),
      ];

  /// The Android package name for the LinkedIn app.
  @override
  String get androidPackageName => 'com.linkedin.android';

  /// The custom URL scheme for the LinkedIn app.
  @override
  String get customScheme => 'linkedin';

  /// The MacOS bundle identifier for the LinkedIn app.
  @override
  String? macosBundleIdentifier;

  /// The platforms that the LinkedIn app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios, PlatformType.android];

  /// Whether to automatically redirect to app stores when the LinkedIn app is not installed.
  @override
  bool fallbackToStore;

  /// The web URL for LinkedIn.
  @override
  Uri get website => Uri.parse('https://www.linkedin.com');

  /// Creates an action to open a specific profile in the LinkedIn app.
  ///
  /// Parameters:
  /// - [profileId]: The profile ID or username of the profile to open (e.g. 'johndoe').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the LinkedIn app is not installed. Default is false.
  ///
  /// Returns a [LinkedInOpenProfileAction] instance that can be used to open
  /// the specified profile in the LinkedIn app.
  static LinkedInOpenProfileAction openProfile({
    required final String profileId,
    final bool fallbackToStore = false,
  }) =>
      LinkedInOpenProfileAction(
        profileId: profileId,
        fallbackToStore: fallbackToStore,
      );

  /// Creates an action to open a specific company page in the LinkedIn app.
  ///
  /// Parameters:
  /// - [companyId]: The company ID of the company page to open (e.g. 'johndoe').
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the LinkedIn app is not installed. Default is false.
  ///
  /// Returns a [LinkedInOpenCompanyAction] instance that can be used to open
  /// the specified company page in the LinkedIn app.
  static LinkedInOpenCompanyAction openCompany({
    required final String companyId,
    final bool fallbackToStore = false,
  }) =>
      LinkedInOpenCompanyAction(
        companyId: companyId,
        fallbackToStore: fallbackToStore,
      );
}

/// An action to open a specific profile in the LinkedIn app.
///
/// This class extends [LinkedIn] and implements multiple interfaces to provide
/// comprehensive functionality for opening profiles with fallback support.
class LinkedInOpenProfileAction extends LinkedIn implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [LinkedInOpenProfileAction] instance.
  ///
  /// Parameters:
  /// - [profileId]: The profile ID or username of the profile to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the LinkedIn app is not installed.
  LinkedInOpenProfileAction({
    required this.profileId,
    required super.fallbackToStore,
  });

  /// The profile ID or username of the profile to open.
  final String profileId;

  /// The universal link URL for opening the specified profile in the LinkedIn app.
  ///
  /// This URL can be used on any platform to open the profile in the LinkedIn app
  /// or website if the app is not available.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.linkedin.com',
        path: 'in/$profileId',
      );

  /// The fallback link to use when the LinkedIn app cannot be opened.
  ///
  /// This returns the same URL as [universalLink] to open the profile on the LinkedIn website.
  @override
  Uri get fallbackLink => universalLink;
}

/// An action to open a specific company page in the LinkedIn app.
///
/// This class extends [LinkedIn] and implements multiple interfaces to provide
/// comprehensive functionality for opening company pages with fallback support.
class LinkedInOpenCompanyAction extends LinkedIn implements UniversalLinkAppAction, Fallbackable {
  /// Creates a new [LinkedInOpenCompanyAction] instance.
  ///
  /// Parameters:
  /// - [companyId]: The company ID of the company page to open.
  /// - [fallbackToStore]: Whether to automatically redirect to app stores when
  ///   the LinkedIn app is not installed.
  LinkedInOpenCompanyAction({
    required this.companyId,
    required super.fallbackToStore,
  });

  /// The company ID of the company page to open.
  final String companyId;

  /// The universal link URL for opening the specified company page in the LinkedIn app.
  ///
  /// This URL can be used on any platform to open the company page in the LinkedIn app
  /// or website if the app is not available.
  @override
  Uri get universalLink => Uri(
        scheme: 'https',
        host: 'www.linkedin.com',
        path: 'company/$companyId',
      );

  /// The fallback link to use when the LinkedIn app cannot be opened.
  ///
  /// This returns the same URL as [universalLink] to open the company page on the LinkedIn website.
  @override
  Uri get fallbackLink => universalLink;
}

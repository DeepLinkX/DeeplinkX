import 'package:deeplink_x/src/core/core.dart';

/// Apple App Store for iOS devices.
///
/// This class implements the [StoreApp] interface to provide capabilities
/// for interacting with the App Store on iOS devices.
class IOSAppStore implements StoreApp {
  /// Creates a new [IOSAppStore] instance.
  IOSAppStore();

  /// Creates an action to open the iOS App Store.
  ///
  /// Returns an [IOSAppStore] instance that can be used to open the iOS App Store app.
  factory IOSAppStore.open() => IOSAppStore();

  /// The platform this store app is associated with (iOS).
  @override
  PlatformType platform = PlatformType.ios;

  /// The Android package name for the App Store (not applicable for iOS).
  @override
  String? get androidPackageName => null;

  /// The custom URL scheme for the iOS App Store.
  @override
  String get customScheme => 'itms-apps';

  /// The MacOS bundle identifier for the iOS App Store (not applicable for iOS).
  @override
  String? get macosBundleIdentifier => null;

  /// The platforms that the iOS App Store supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.ios];

  /// The web URL for the Apple App Store.
  @override
  Uri get website => Uri.parse('https://www.apple.com/app-store/');

  /// Creates an action to open a specific app's page in the iOS App Store.
  ///
  /// Parameters:
  /// - [appId]: The App Store ID of the app to open.
  /// - [appName]: The name of the app to open.
  /// - [mediaType]: The media type identifier (default is '8' for iOS apps) (e.g. '12' for MacOS apps, '8' for iOS apps).
  /// - [country]: Optional two-letter country code to specify a country-specific store (e.g. 'us').
  /// - [campaignToken]: Optional campaign token for tracking (e.g. 'campaign123').
  /// - [providerToken]: Optional provider token for affiliate programs (e.g. 'provider456').
  /// - [affiliateToken]: Optional affiliate token for affiliate programs (e.g. 'affiliate789').
  /// - [uniqueOrigin]: Optional unique origin identifier for tracking (e.g. 'origin123').
  ///
  /// Returns an [IOSAppStoreOpenAppPageAction] instance that can be used to open
  /// the specified app's page in the App Store.
  static IOSAppStoreOpenAppPageAction openAppPage({
    required final String appId,
    required final String appName,
    final String mediaType = '8',
    final String? country,
    final String? campaignToken,
    final String? providerToken,
    final String? affiliateToken,
    final String? uniqueOrigin,
  }) =>
      IOSAppStoreOpenAppPageAction(
        appId: appId,
        appName: appName,
        mediaType: mediaType,
        country: country,
        campaignToken: campaignToken,
        providerToken: providerToken,
        affiliateToken: affiliateToken,
        uniqueOrigin: uniqueOrigin,
      );

  /// Creates an action to rate a specific app in the iOS App Store.
  ///
  /// Parameters:
  /// - [appId]: The App Store ID of the app to rate.
  /// - [appName]: The name of the app to rate.
  /// - [mediaType]: The media type identifier (default is '8' for iOS apps) (e.g. '12' for MacOS apps, '8' for iOS apps).
  /// - [country]: Optional two-letter country code to specify a country-specific store (e.g. 'us').
  /// - [campaignToken]: Optional campaign token for tracking (e.g. 'campaign123').
  /// - [providerToken]: Optional provider token for affiliate programs (e.g. 'provider456').
  /// - [affiliateToken]: Optional affiliate token for affiliate programs (e.g. 'affiliate789').
  ///
  /// Returns an [IOSAppStoreRateAppAction] instance that can be used to open
  /// the app's rating page in the App Store.
  static IOSAppStoreRateAppAction rateApp({
    required final String appId,
    required final String appName,
    final String mediaType = '8',
    final String? country,
    final String? campaignToken,
    final String? providerToken,
    final String? affiliateToken,
  }) =>
      IOSAppStoreRateAppAction(
        appId: appId,
        appName: appName,
        mediaType: mediaType,
        country: country,
        campaignToken: campaignToken,
        providerToken: providerToken,
        affiliateToken: affiliateToken,
      );
}

/// An action to open a specific app's page in the iOS App Store.
///
/// This class extends [IOSAppStore] and implements multiple interfaces to provide
/// comprehensive functionality for opening app pages with fallback support.
class IOSAppStoreOpenAppPageAction extends IOSAppStore
    implements AppLinkAppAction, Fallbackable, StoreOpenAppPageAction {
  /// Creates a new [IOSAppStoreOpenAppPageAction] instance.
  ///
  /// Parameters:
  /// - [appId]: The App Store ID of the app to open.
  /// - [appName]: The name of the app to open.
  /// - [mediaType]: The media type identifier.
  /// - [country]: Optional two-letter country code to specify a country-specific store.
  /// - [campaignToken]: Optional campaign token for tracking.
  /// - [providerToken]: Optional provider token for affiliate programs.
  /// - [affiliateToken]: Optional affiliate token for affiliate programs.
  /// - [uniqueOrigin]: Optional unique origin identifier for tracking.
  IOSAppStoreOpenAppPageAction({
    required this.appId,
    required this.appName,
    required this.mediaType,
    this.country,
    this.campaignToken,
    this.providerToken,
    this.affiliateToken,
    this.uniqueOrigin,
  });

  /// The App Store ID of the app to open.
  final String appId;

  /// The name of the app to open.
  final String appName;

  /// The media type identifier.
  final String mediaType;

  /// Optional two-letter country code to specify a country-specific store.
  final String? country;

  /// Optional campaign token for tracking.
  final String? campaignToken;

  /// Optional provider token for affiliate programs.
  final String? providerToken;

  /// Optional affiliate token for affiliate programs.
  final String? affiliateToken;

  /// Optional unique origin identifier for tracking.
  final String? uniqueOrigin;

  /// The app link URL for opening the specified app in the App Store app.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'mt': mediaType,
      if (campaignToken != null) 'ct': campaignToken!,
      if (providerToken != null) 'pt': providerToken!,
      if (affiliateToken != null) 'at': affiliateToken!,
      if (uniqueOrigin != null) 'uo': uniqueOrigin!,
    };
    final pathSegments = <String>[
      if (country != null) ...[country!],
      'app',
      appName,
      'id$appId',
    ];
    return Uri(
      scheme: 'itms-apps',
      host: 'itunes.apple.com',
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the App Store app cannot be opened.
  ///
  /// This URL opens the app's page on the Apple App Store website.
  @override
  Uri get fallbackLink {
    final queryParameters = <String, String>{
      'mt': mediaType,
      if (campaignToken != null) 'ct': campaignToken!,
      if (providerToken != null) 'pt': providerToken!,
      if (affiliateToken != null) 'at': affiliateToken!,
      if (uniqueOrigin != null) 'uo': uniqueOrigin!,
    };
    final pathSegments = <String>[
      if (country != null) ...[country!],
      'app',
      appName,
      'id$appId',
    ];
    return Uri(
      scheme: 'https',
      host: 'apps.apple.com',
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }
}

/// An action to rate a specific app in the iOS App Store.
///
/// This class extends [IOSAppStore] and implements [AppLinkAppAction] to provide
/// functionality for opening the rating page of an app in the App Store.
class IOSAppStoreRateAppAction extends IOSAppStore implements AppLinkAppAction {
  /// Creates a new [IOSAppStoreRateAppAction] instance.
  ///
  /// Parameters:
  /// - [appId]: The App Store ID of the app to rate.
  /// - [appName]: The name of the app to rate.
  /// - [mediaType]: The media type identifier.
  /// - [country]: Optional two-letter country code to specify a country-specific store.
  /// - [campaignToken]: Optional campaign token for tracking.
  /// - [providerToken]: Optional provider token for affiliate programs.
  /// - [affiliateToken]: Optional affiliate token for affiliate programs.
  IOSAppStoreRateAppAction({
    required this.appId,
    required this.appName,
    required this.mediaType,
    this.country,
    this.campaignToken,
    this.providerToken,
    this.affiliateToken,
  });

  /// The App Store ID of the app to rate.
  final String appId;

  /// The name of the app to rate.
  final String appName;

  /// The media type identifier.
  final String mediaType;

  /// Optional two-letter country code to specify a country-specific store.
  final String? country;

  /// Optional campaign token for tracking.
  final String? campaignToken;

  /// Optional provider token for affiliate programs.
  final String? providerToken;

  /// Optional affiliate token for affiliate programs.
  final String? affiliateToken;

  /// The app link URL for opening the app's rating page in the App Store app.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'mt': mediaType,
      'action': 'write-review',
      if (campaignToken != null) 'ct': campaignToken!,
      if (providerToken != null) 'pt': providerToken!,
      if (affiliateToken != null) 'at': affiliateToken!,
    };
    final pathSegments = <String>[
      if (country != null) ...[country!],
      'app',
      appName,
      'id$appId',
    ];
    return Uri(
      scheme: 'itms-apps',
      host: 'itunes.apple.com',
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }
}

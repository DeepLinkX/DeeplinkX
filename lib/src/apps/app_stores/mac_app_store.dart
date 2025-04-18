import 'package:deeplink_x/src/core/core.dart';

/// Mac App Store application.
///
/// This class implements the [StoreApp] interface to provide capabilities
/// for interacting with the Mac App Store on macOS devices.
class MacAppStore implements StoreApp {
  /// Creates a new [MacAppStore] instance.
  MacAppStore();

  /// Creates an action to open the Mac App Store.
  ///
  /// Returns a [MacAppStore] instance that can be used to open the Mac App Store.
  factory MacAppStore.open() => MacAppStore();

  /// The platform this store app is associated with (macOS).
  @override
  PlatformType platform = PlatformType.macos;

  /// The Android package name for the Mac App Store (not applicable for macOS).
  @override
  String? get androidPackageName => null;

  /// The custom URL scheme for the Mac App Store.
  @override
  String get customScheme => 'macappstore';

  /// The MacOS bundle identifier for the Mac App Store.
  @override
  String? get macosBundleIdentifier => 'com.apple.AppStore';

  /// The platforms that the Mac App Store supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.macos];

  /// The web URL for the Mac App Store.
  @override
  Uri get website => Uri.parse('https://www.apple.com/app-store/');

  /// Creates an action to open a specific app's page in the Mac App Store.
  ///
  /// Parameters:
  /// - [appId]: The App Store ID of the app to open.
  /// - [appName]: The name of the app to open.
  /// - [mediaType]: The media type identifier (default is '12' for apps) (e.g. '12' for apps, '11' for macOS apps).
  /// - [country]: Optional two-letter country code to specify a country-specific store (e.g. 'us').
  /// - [campaignToken]: Optional campaign token for tracking (e.g. 'campaign123').
  /// - [providerToken]: Optional provider token for affiliate programs (e.g. 'provider456').
  /// - [affiliateToken]: Optional affiliate token for affiliate programs (e.g. 'affiliate789').
  ///
  /// Returns a [MacAppStoreOpenAppPageAction] instance that can be used to open
  /// the specified app's page in the Mac App Store.
  static MacAppStoreOpenAppPageAction openAppPage({
    required final String appId,
    required final String appName,
    final String mediaType = '12',
    final String? country,
    final String? campaignToken,
    final String? providerToken,
    final String? affiliateToken,
  }) =>
      MacAppStoreOpenAppPageAction(
        appId: appId,
        appName: appName,
        mediaType: mediaType,
        country: country,
        campaignToken: campaignToken,
        providerToken: providerToken,
        affiliateToken: affiliateToken,
      );

  /// Creates an action to rate a specific app in the Mac App Store.
  ///
  /// Parameters:
  /// - [appId]: The App Store ID of the app to rate.
  /// - [appName]: The name of the app to rate.
  /// - [mediaType]: The media type identifier (default is '12' for ratings) (e.g. '12' for ratings, '11' for macOS apps).
  /// - [country]: Optional two-letter country code to specify a country-specific store (e.g. 'us').
  /// - [campaignToken]: Optional campaign token for tracking (e.g. 'campaign123').
  /// - [providerToken]: Optional provider token for affiliate programs (e.g. 'provider456').
  /// - [affiliateToken]: Optional affiliate token for affiliate programs (e.g. 'affiliate789').
  ///
  /// Returns a [MacAppStoreRateAppAction] instance that can be used to open
  /// the app's rating page in the Mac App Store.
  static MacAppStoreRateAppAction rateApp({
    required final String appId,
    required final String appName,
    final String mediaType = '12',
    final String? country,
    final String? campaignToken,
    final String? providerToken,
    final String? affiliateToken,
  }) =>
      MacAppStoreRateAppAction(
        appId: appId,
        appName: appName,
        mediaType: mediaType,
        country: country,
        campaignToken: campaignToken,
        providerToken: providerToken,
        affiliateToken: affiliateToken,
      );
}

/// An action to open a specific app's page in the Mac App Store.
///
/// This class extends [MacAppStore] and implements multiple interfaces to provide
/// comprehensive functionality for opening app pages with fallback support.
class MacAppStoreOpenAppPageAction extends MacAppStore
    implements AppLinkAppAction, Fallbackable, StoreOpenAppPageAction {
  /// Creates a new [MacAppStoreOpenAppPageAction] instance.
  ///
  /// Parameters:
  /// - [appId]: The App Store ID of the app to open.
  /// - [appName]: The name of the app to open.
  /// - [mediaType]: The media type identifier.
  /// - [country]: Optional two-letter country code to specify a country-specific store.
  /// - [campaignToken]: Optional campaign token for tracking.
  /// - [providerToken]: Optional provider token for affiliate programs.
  /// - [affiliateToken]: Optional affiliate token for affiliate programs.
  MacAppStoreOpenAppPageAction({
    required this.appId,
    required this.appName,
    required this.mediaType,
    this.country,
    this.campaignToken,
    this.providerToken,
    this.affiliateToken,
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

  /// The app link URL for opening the specified app in the Mac App Store.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'mt': mediaType,
      if (campaignToken != null) 'ct': campaignToken!,
      if (providerToken != null) 'pt': providerToken!,
      if (affiliateToken != null) 'at': affiliateToken!,
    };
    final pathSegments = <String>[
      if (country != null) ...[country!],
      'app',
      'mac',
      appName,
      'id$appId',
    ];
    return Uri(
      scheme: 'macappstore',
      host: 'itunes.apple.com',
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the Mac App Store app cannot be opened.
  ///
  /// This URL opens the app's page on the Apple App Store website.
  @override
  Uri get fallbackLink {
    final queryParameters = <String, String>{
      'mt': mediaType,
      if (campaignToken != null) 'ct': campaignToken!,
      if (providerToken != null) 'pt': providerToken!,
      if (affiliateToken != null) 'at': affiliateToken!,
    };
    final pathSegments = <String>[
      if (country != null) ...[country!],
      'app',
      'mac',
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

/// An action to rate a specific app in the Mac App Store.
///
/// This class extends [MacAppStore] and implements [AppLinkAppAction] to provide
/// functionality for opening the rating page of an app in the Mac App Store.
class MacAppStoreRateAppAction extends MacAppStore implements AppLinkAppAction {
  /// Creates a new [MacAppStoreRateAppAction] instance.
  ///
  /// Parameters:
  /// - [appId]: The App Store ID of the app to rate.
  /// - [appName]: The name of the app to rate.
  /// - [mediaType]: The media type identifier.
  /// - [country]: Optional two-letter country code to specify a country-specific store.
  /// - [campaignToken]: Optional campaign token for tracking.
  /// - [providerToken]: Optional provider token for affiliate programs.
  /// - [affiliateToken]: Optional affiliate token for affiliate programs.
  MacAppStoreRateAppAction({
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

  /// The app link URL for opening the app's rating page in the Mac App Store.
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
      'mac',
      appName,
      'id$appId',
    ];
    return Uri(
      scheme: 'macappstore',
      host: 'itunes.apple.com',
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }
}

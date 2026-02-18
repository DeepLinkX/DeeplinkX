import 'package:deeplink_x/src/core/core.dart';

/// Huawei AppGallery store application.
///
/// This class implements the [StoreApp] interface to provide capabilities
/// for interacting with the Huawei AppGallery store on Android devices.
class HuaweiAppGalleryStore implements StoreApp {
  /// Creates a new [HuaweiAppGalleryStore] instance.
  HuaweiAppGalleryStore();

  /// Creates an action to open the Huawei AppGallery.
  ///
  /// Returns a [HuaweiAppGalleryStore] instance that can be used to open the Huawei AppGallery app.
  factory HuaweiAppGalleryStore.open() => HuaweiAppGalleryStore();

  /// The platform this store app is associated with (Android).
  @override
  PlatformType get platform => PlatformType.android;

  /// The Android package name for the Huawei AppGallery app.
  @override
  String? get androidPackageName => 'com.huawei.appmarket';

  /// The MacOS bundle identifier for the Huawei AppGallery app (not applicable for Android).
  @override
  String? get macosBundleIdentifier => null;

  /// The platforms that the Huawei AppGallery supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.android];

  /// The custom URL scheme for the Huawei AppGallery app.
  @override
  String get customScheme => 'appmarket';

  /// The web URL for the Huawei AppGallery store.
  @override
  Uri get website => Uri.parse('https://appgallery.huawei.com');

  /// Creates an action to open a specific app's page in the Huawei AppGallery store.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to open in the AppGallery store.
  /// - [appId]: The unique identifier for the app in the AppGallery store.
  /// - [referrer]: Optional referrer parameter for tracking (e.g. 'utm_source=test_app').
  /// - [locale]: Optional locale parameter to specify language (e.g. 'en_US').
  ///
  /// Returns a [HuaweiAppGalleryStoreOpenAppPageAction] instance that can be used to open
  /// the specified app's page in the Huawei AppGallery store.
  static HuaweiAppGalleryStoreOpenAppPageAction openAppPage({
    required final String packageName,
    required final String appId,
    final String? referrer,
    final String? locale,
  }) =>
      HuaweiAppGalleryStoreOpenAppPageAction(
        packageName: packageName,
        appId: appId,
        referrer: referrer,
        locale: locale,
      );
}

/// An action to open a specific app's page in the Huawei AppGallery store.
///
/// This class extends [HuaweiAppGalleryStore] and implements multiple interfaces to provide
/// comprehensive functionality for opening app pages with fallback support.
class HuaweiAppGalleryStoreOpenAppPageAction extends HuaweiAppGalleryStore
    implements AppLinkAppAction, Fallbackable, StoreOpenAppPageAction {
  /// Creates a new [HuaweiAppGalleryStoreOpenAppPageAction] instance.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to open in the AppGallery store.
  /// - [appId]: The unique identifier for the app in the AppGallery store.
  /// - [referrer]: Optional referrer parameter for tracking.
  /// - [locale]: Optional locale parameter to specify language.
  HuaweiAppGalleryStoreOpenAppPageAction({
    required this.packageName,
    required this.appId,
    this.referrer,
    this.locale,
  });

  /// The package name of the app to open in the AppGallery store.
  final String packageName;

  /// The unique identifier for the app in the AppGallery store.
  final String appId;

  /// Optional referrer parameter for tracking.
  final String? referrer;

  /// Optional locale parameter to specify language.
  final String? locale;

  /// The app link URL for opening the specified app in the Huawei AppGallery app.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'id': packageName,
      if (referrer != null) 'referrer': referrer!,
      if (locale != null) 'locale': locale!,
    };
    return Uri(
      scheme: 'appmarket',
      host: 'details',
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the Huawei AppGallery app cannot be opened.
  ///
  /// This URL opens the app's page on the Huawei AppGallery website.
  @override
  Uri get fallbackLink {
    final queryParameters = <String, String>{
      if (referrer != null) 'referrer': referrer!,
      if (locale != null) 'locale': locale!,
    };
    return Uri(
      scheme: 'https',
      host: 'appgallery.huawei.com',
      path: 'app/$appId',
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
  }
}

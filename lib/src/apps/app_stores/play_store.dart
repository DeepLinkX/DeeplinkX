import 'package:deeplink_x/src/core/core.dart';

/// Google Play Store application for Android.
///
/// This class implements the [StoreApp] interface to provide capabilities
/// for interacting with the Google Play Store on Android devices.
class PlayStore implements StoreApp {
  /// Creates a new [PlayStore] instance.
  PlayStore();

  /// Creates an action to open the Google Play Store.
  ///
  /// Returns a [PlayStore] instance that can be used to open the Google Play Store app.
  factory PlayStore.open() => PlayStore();

  /// The platform this store app is associated with (Android).
  @override
  PlatformType get platform => PlatformType.android;

  /// The Android package name for the Google Play Store app.
  @override
  String? get androidPackageName => 'com.android.vending';

  /// The custom URL scheme for the Google Play Store.
  @override
  String get customScheme => 'market';

  /// The MacOS bundle identifier for the Google Play Store (not applicable for Android).
  @override
  String? get macosBundleIdentifier => null;

  /// The platforms that the Google Play Store supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.android];

  /// The web URL for the Google Play Store.
  @override
  Uri get website => Uri.parse('https://play.google.com/store/apps');

  /// Creates an action to open a specific app's page in the Google Play Store.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to open in the Play Store.
  /// - [referrer]: Optional referrer parameter for tracking (e.g. 'utm_source=test_app').
  /// - [language]: Optional language code to display the store page in a specific language (e.g. 'en').
  ///
  /// Returns a [PlayStoreOpenAppPageAction] instance that can be used to open
  /// the specified app's page in the Google Play Store.
  static PlayStoreOpenAppPageAction openAppPage({
    required final String packageName,
    final String? referrer,
    final String? language,
  }) =>
      PlayStoreOpenAppPageAction(
        packageName: packageName,
        referrer: referrer,
        language: language,
      );
}

/// An action to open a specific app's page in the Google Play Store.
///
/// This class extends [PlayStore] and implements multiple interfaces to provide
/// comprehensive functionality for opening app pages in the Play Store with
/// fallback support.
class PlayStoreOpenAppPageAction extends PlayStore
    implements UniversalLinkAppAction, Fallbackable, StoreOpenAppPageAction {
  /// Creates a new [PlayStoreOpenAppPageAction] instance.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to open in the Play Store.
  /// - [referrer]: Optional referrer parameter for tracking.
  /// - [language]: Optional language code to display the store page in a specific language.
  PlayStoreOpenAppPageAction({
    required this.packageName,
    this.referrer,
    this.language,
  });

  /// The package name of the app to open in the Play Store.
  final String packageName;

  /// Optional referrer parameter for tracking.
  final String? referrer;

  /// Optional language code to display the store page in a specific language.
  final String? language;

  /// The universal link URL for opening the app's page in the Play Store.
  ///
  /// This URL can be used on any platform to open the app's page in a web browser
  /// if the Play Store app is not available.
  @override
  Uri get universalLink {
    final queryParameters = <String, String>{
      'id': packageName,
      if (referrer != null) 'referrer': referrer!,
      if (language != null) 'hl': language!,
    };
    return Uri(
      scheme: 'https',
      host: 'play.google.com',
      path: 'store/apps/details',
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the Play Store app cannot be opened.
  ///
  /// This returns the same URL as [universalLink] to open the app's page in a web browser.
  @override
  Uri get fallbackLink => universalLink;
}

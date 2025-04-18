import 'package:deeplink_x/src/core/core.dart';

/// Cafe Bazaar Store application for Android.
///
/// This class implements the [StoreApp] interface to provide capabilities
/// for interacting with the Cafe Bazaar store on Android devices. Cafe Bazaar
/// is a popular app store in Iran.
class CafeBazaarStore implements StoreApp {
  /// Creates a new [CafeBazaarStore] instance.
  CafeBazaarStore();

  /// Creates an action to open the Cafe Bazaar app.
  ///
  /// Returns a [CafeBazaarStore] instance that can be used to open the Cafe Bazaar app.
  factory CafeBazaarStore.open() => CafeBazaarStore();

  /// The platform this store app is associated with (Android).
  @override
  PlatformType platform = PlatformType.android;

  /// The Android package name for the Cafe Bazaar app.
  @override
  String? get androidPackageName => 'com.farsitel.bazaar';

  /// The custom URL scheme for the Cafe Bazaar app (not applicable for other platforms).
  @override
  String? customScheme;

  /// The MacOS bundle identifier for the Cafe Bazaar app (not applicable for Android).
  @override
  String? get macosBundleIdentifier => null;

  /// The platforms that the Cafe Bazaar app supports.
  @override
  List<PlatformType> get supportedPlatforms => [PlatformType.android];

  /// The web URL for the Cafe Bazaar store.
  @override
  Uri get website => Uri.parse('https://cafebazaar.ir');

  /// Creates an action to open a specific app's page in the Cafe Bazaar store.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to open in the Cafe Bazaar store.
  /// - [referrer]: Optional referrer parameter for tracking (e.g. 'utm_source=test_app').
  ///
  /// Returns a [CafeBazaarStoreOpenAppPageAction] instance that can be used to open
  /// the specified app's page in the Cafe Bazaar store.
  static CafeBazaarStoreOpenAppPageAction openAppPage({
    required final String packageName,
    final String? referrer,
  }) =>
      CafeBazaarStoreOpenAppPageAction(
        packageName: packageName,
        referrer: referrer,
      );
}

/// An action to open a specific app's page in the Cafe Bazaar store.
///
/// This class extends [CafeBazaarStore] and implements multiple interfaces to provide
/// comprehensive functionality for opening app pages with fallback support.
class CafeBazaarStoreOpenAppPageAction extends CafeBazaarStore
    implements IntentAppLinkAction, Fallbackable, StoreOpenAppPageAction {
  /// Creates a new [CafeBazaarStoreOpenAppPageAction] instance.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to open in the Cafe Bazaar store.
  /// - [referrer]: Optional referrer parameter for tracking (e.g. 'utm_source=test_app').
  CafeBazaarStoreOpenAppPageAction({
    required this.packageName,
    this.referrer,
  });

  /// The package name of the app to open in the Cafe Bazaar store.
  final String packageName;

  /// Optional referrer parameter for tracking.
  final String? referrer;

  /// The app link URL for opening the specified app in the Cafe Bazaar app.
  @override
  Uri? appLink;

  /// The fallback link to use when the Cafe Bazaar app cannot be opened.
  ///
  /// This URL opens the app's page on the Cafe Bazaar website.
  @override
  Uri get fallbackLink {
    final queryParameters = <String, String>{
      if (referrer != null) 'referrer': referrer!,
    };
    return Uri(
      scheme: 'https',
      host: 'cafebazaar.ir',
      path: 'app/$packageName',
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
  }

  @override
  AndroidIntentOption get androidIntentOptions {
    final queryParameters = <String, String>{
      'id': packageName,
      if (referrer != null) 'referrer': referrer!,
    };
    final dataUri = Uri(
      scheme: 'bazaar',
      host: 'details',
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
    return AndroidIntentOption(
      action: 'action_view',
      data: dataUri.toString(),
      package: androidPackageName,
      flags: const [0x10000000], // Intent.FLAG_ACTIVITY_NEW_TASK
    );
  }
}

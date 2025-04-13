import 'package:deeplink_x/src/core/core.dart';

/// Myket Store application for Android.
///
/// This class implements the [StoreApp] interface to provide capabilities
/// for interacting with the Myket store on Android devices. Myket is
/// a popular app store in Iran.
class MyketStore implements StoreApp {
  /// Creates a new [MyketStore] instance.
  MyketStore();

  /// Creates an action to open the Myket app.
  ///
  /// Returns a [MyketStore] instance that can be used to open the Myket app.
  factory MyketStore.open() => MyketStore();

  /// The platform this store app is associated with (Android).
  @override
  PlatformType platform = PlatformType.android;

  /// The Android package name for the Myket app.
  @override
  String get androidPackageName => 'ir.mservices.market';

  /// The custom URL scheme for the Myket app.
  @override
  String get customScheme => 'myket';

  /// The web URL for the Myket store.
  @override
  Uri get website => Uri.parse('https://myket.ir');

  /// Creates an action to open a specific app's page in the Myket store.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to open in the Myket store.
  /// - [referrer]: Optional referrer parameter for tracking (e.g. 'utm_source=test_app').
  ///
  /// Returns a [MyketStoreOpenAppPageAction] instance that can be used to open
  /// the specified app's page in the Myket store.
  static MyketStoreOpenAppPageAction openAppPage({
    required final String packageName,
    final String? referrer,
  }) =>
      MyketStoreOpenAppPageAction(
        packageName: packageName,
        referrer: referrer,
      );

  /// Creates an action to rate a specific app in the Myket store.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to rate in the Myket store.
  ///
  /// Returns a [MyketStoreRateAppAction] instance that can be used to open
  /// the rating page for the specified app in the Myket store.
  static MyketStoreRateAppAction rateApp({
    required final String packageName,
  }) =>
      MyketStoreRateAppAction(
        packageName: packageName,
      );
}

/// An action to open a specific app's page in the Myket store.
///
/// This class extends [MyketStore] and implements multiple interfaces to provide
/// comprehensive functionality for opening app pages with fallback support.
class MyketStoreOpenAppPageAction extends MyketStore implements AppLinkAppAction, Fallbackable, StoreOpenAppPageAction {
  /// Creates a new [MyketStoreOpenAppPageAction] instance.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to open in the Myket store.
  /// - [referrer]: Optional referrer parameter for tracking.
  MyketStoreOpenAppPageAction({
    required this.packageName,
    this.referrer,
  });

  /// The package name of the app to open in the Myket store.
  final String packageName;

  /// Optional referrer parameter for tracking.
  final String? referrer;

  /// The app link URL for opening the specified app in the Myket app.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'id': packageName,
      if (referrer != null) 'referrer': referrer!,
    };
    return Uri(
      scheme: 'myket',
      host: 'details',
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the Myket app cannot be opened.
  ///
  /// This URL opens the app's page on the Myket website.
  @override
  Uri get fallbackLink {
    final queryParameters = <String, String>{
      if (referrer != null) 'referrer': referrer!,
    };
    return Uri(
      scheme: 'https',
      host: 'myket.ir',
      pathSegments: ['app', packageName],
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
  }
}

/// An action to rate a specific app in the Myket store.
///
/// This class extends [MyketStore] and implements [AppLinkAppAction] to provide
/// functionality for opening the rating page of an app in the Myket store.
class MyketStoreRateAppAction extends MyketStore implements AppLinkAppAction {
  /// Creates a new [MyketStoreRateAppAction] instance.
  ///
  /// Parameters:
  /// - [packageName]: The package name of the app to rate in the Myket store.
  MyketStoreRateAppAction({
    required this.packageName,
  });

  /// The package name of the app to rate in the Myket store.
  final String packageName;

  /// The app link URL for opening the app's rating page in the Myket app.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{'id': packageName};
    return Uri(
      scheme: 'myket',
      host: 'comment',
      queryParameters: queryParameters,
    );
  }
}

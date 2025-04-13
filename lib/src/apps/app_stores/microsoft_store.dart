import 'package:deeplink_x/src/core/core.dart';

/// Microsoft Store application for Windows.
///
/// This class implements the [StoreApp] interface to provide capabilities
/// for interacting with the Microsoft Store on Windows devices.
class MicrosoftStore implements StoreApp {
  /// Creates a new [MicrosoftStore] instance.
  MicrosoftStore();

  /// Creates an action to open the Microsoft Store.
  ///
  /// Returns a [MicrosoftStore] instance that can be used to open the Microsoft Store app.
  factory MicrosoftStore.open() => MicrosoftStore();

  /// The platform this store app is associated with (Windows).
  @override
  PlatformType platform = PlatformType.windows;

  /// The Android package name for the Microsoft Store (not applicable for Windows).
  @override
  String? get androidPackageName => null;

  /// The custom URL scheme for the Microsoft Store.
  @override
  String get customScheme => 'ms-windows-store';

  /// The web URL for the Microsoft Store.
  @override
  Uri get website => Uri.parse('https://apps.microsoft.com/home');

  /// Creates an action to open a specific app's page in the Microsoft Store.
  ///
  /// Parameters:
  /// - [productId]: The product ID of the app to open in the Microsoft Store.
  /// - [language]: Optional language code to display the store page in a specific language (e.g. 'en-us').
  /// - [countryCode]: Optional country code to specify a country-specific store (e.g. 'us').
  ///
  /// Returns a [MicrosoftStoreOpenAppPageAction] instance that can be used to open
  /// the specified app's page in the Microsoft Store.
  static MicrosoftStoreOpenAppPageAction openAppPage({
    required final String productId,
    final String? language,
    final String? countryCode,
  }) =>
      MicrosoftStoreOpenAppPageAction(
        productId: productId,
        language: language,
        countryCode: countryCode,
      );

  /// Creates an action to rate a specific app in the Microsoft Store.
  ///
  /// Parameters:
  /// - [productId]: The product ID of the app to rate in the Microsoft Store.
  /// - [language]: Optional language code to display the rating page in a specific language (e.g. 'en-us').
  /// - [countryCode]: Optional country code to specify a country-specific store (e.g. 'us').
  ///
  /// Returns a [MicrosoftStoreRateAppAction] instance that can be used to open
  /// the rating page for the specified app in the Microsoft Store.
  static MicrosoftStoreRateAppAction rateApp({
    required final String productId,
    final String? language,
    final String? countryCode,
  }) =>
      MicrosoftStoreRateAppAction(
        productId: productId,
        language: language,
        countryCode: countryCode,
      );
}

/// An action to open a specific app's page in the Microsoft Store.
///
/// This class extends [MicrosoftStore] and implements multiple interfaces to provide
/// comprehensive functionality for opening app pages with fallback support.
class MicrosoftStoreOpenAppPageAction extends MicrosoftStore
    implements AppLinkAppAction, Fallbackable, StoreOpenAppPageAction {
  /// Creates a new [MicrosoftStoreOpenAppPageAction] instance.
  ///
  /// Parameters:
  /// - [productId]: The product ID of the app to open in the Microsoft Store.
  /// - [language]: Optional language code to display the store page in a specific language.
  /// - [countryCode]: Optional country code to specify a country-specific store.
  MicrosoftStoreOpenAppPageAction({
    required this.productId,
    this.language,
    this.countryCode,
  });

  /// The product ID of the app to open in the Microsoft Store.
  final String productId;

  /// Optional language code to display the store page in a specific language.
  final String? language;

  /// Optional country code to specify a country-specific store.
  final String? countryCode;

  /// The app link URL for opening the specified app in the Microsoft Store.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'ProductId': productId,
      if (language != null) 'hl': language!,
      if (countryCode != null) 'gl': countryCode!,
    };
    return Uri(
      scheme: 'ms-windows-store',
      host: 'pdp',
      path: '/',
      queryParameters: queryParameters,
    );
  }

  /// The fallback link to use when the Microsoft Store app cannot be opened.
  ///
  /// This URL opens the app's page on the Microsoft Store website.
  @override
  Uri get fallbackLink {
    final queryParameters = <String, String>{
      if (language != null) 'hl': language!,
      if (countryCode != null) 'gl': countryCode!,
    };
    return Uri(
      scheme: 'https',
      host: 'apps.microsoft.com',
      pathSegments: ['store', 'detail', 'app', productId],
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
  }
}

/// An action to rate a specific app in the Microsoft Store.
///
/// This class extends [MicrosoftStore] and implements [AppLinkAppAction] to provide
/// functionality for opening the rating page of an app in the Microsoft Store.
class MicrosoftStoreRateAppAction extends MicrosoftStore implements AppLinkAppAction {
  /// Creates a new [MicrosoftStoreRateAppAction] instance.
  ///
  /// Parameters:
  /// - [productId]: The product ID of the app to rate in the Microsoft Store.
  /// - [language]: Optional language code to display the rating page in a specific language.
  /// - [countryCode]: Optional country code to specify a country-specific store.
  MicrosoftStoreRateAppAction({
    required this.productId,
    this.language,
    this.countryCode,
  });

  /// The product ID of the app to rate in the Microsoft Store.
  final String productId;

  /// Optional language code to display the rating page in a specific language.
  final String? language;

  /// Optional country code to specify a country-specific store.
  final String? countryCode;

  /// The app link URL for opening the app's rating page in the Microsoft Store.
  @override
  Uri get appLink {
    final queryParameters = <String, String>{
      'ProductId': productId,
      if (language != null) 'hl': language!,
      if (countryCode != null) 'gl': countryCode!,
    };
    return Uri(
      scheme: 'ms-windows-store',
      host: 'review',
      path: '/',
      queryParameters: queryParameters,
    );
  }
}

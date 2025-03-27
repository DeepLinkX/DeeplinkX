import 'dart:core';

import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';

/// Microsoft Store-specific action types that define available deeplink actions
enum MicrosoftStoreActionType implements ActionTypeEnum {
  /// Opens the Microsoft Store app
  open,

  /// Opens a specific app page in the Microsoft Store
  openAppPage,

  /// Opens the review page for a specific app
  openAppReviewPage,
}

/// Microsoft Store action implementation for handling Microsoft Store-specific deeplinks
class MicrosoftStoreAction extends StoreAppAction {
  /// Creates a new Microsoft Store action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const MicrosoftStoreAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type, platform: platformType);

  /// The native platform type
  static const platformType = PlatformType.windows;

  /// Base URI for Microsoft Store app deeplinks
  static const baseUrl = 'ms-windows-store://';

  /// Base URI for Microsoft Store web fallback
  static const fallBackUri = 'https://apps.microsoft.com';

  /// The type of Microsoft Store action to perform
  final MicrosoftStoreActionType type;

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case MicrosoftStoreActionType.open:
        return Uri.parse(baseUrl);
      case MicrosoftStoreActionType.openAppPage:
        final productId = parameters!['productId'];
        final language = parameters!['language'];
        final countryCode = parameters!['countryCode'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (language != null) {
          queryParams['hl'] = language;
        }

        if (countryCode != null) {
          queryParams['gl'] = countryCode;
        }

        final nativeQueryParams = Map<String, String>.from(queryParams);
        nativeQueryParams['ProductId'] = productId!;

        // Native app URI with query parameters
        return Uri.parse(baseUrl).replace(
          host: 'pdp',
          path: '/',
          queryParameters: nativeQueryParams,
        );
      case MicrosoftStoreActionType.openAppReviewPage:
        final productId = parameters!['productId'];
        final language = parameters!['language'];
        final countryCode = parameters!['countryCode'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (language != null) {
          queryParams['hl'] = language;
        }

        if (countryCode != null) {
          queryParams['gl'] = countryCode;
        }

        final nativeQueryParams = Map<String, String>.from(queryParams);
        nativeQueryParams['ProductId'] = productId!;

        // Native app URI with query parameters
        return Uri.parse(baseUrl).replace(
          host: 'review',
          path: '/',
          queryParameters: nativeQueryParams,
        );
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case MicrosoftStoreActionType.open:
        return Uri.parse(fallBackUri);
      case MicrosoftStoreActionType.openAppPage:
        final productId = parameters!['productId'];
        final language = parameters!['language'];
        final countryCode = parameters!['countryCode'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (language != null) {
          queryParams['hl'] = language;
        }

        if (countryCode != null) {
          queryParams['gl'] = countryCode;
        }

        // Web fallback URI with query parameters
        return Uri.parse(fallBackUri).replace(
          path: 'store/detail/app/$productId',
          queryParameters: queryParams.isNotEmpty ? queryParams : null,
        );
      case MicrosoftStoreActionType.openAppReviewPage:
        final productId = parameters!['productId'];
        final language = parameters!['language'];
        final countryCode = parameters!['countryCode'];

        // Build query parameters
        final queryParams = <String, String>{};

        if (language != null) {
          queryParams['hl'] = language;
        }

        if (countryCode != null) {
          queryParams['gl'] = countryCode;
        }

        // Web fallback URI with query parameters
        return Uri.parse(fallBackUri).replace(
          path: 'store/detail/app/$productId',
          queryParameters: queryParams.isNotEmpty ? queryParams : null,
          fragment: 'reviews',
        );
    }
  }
}

/// Factory class for creating Microsoft Store deeplink actions
///
/// This class provides convenient factory methods for creating common Microsoft Store
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for Microsoft Store-specific action creation.
class MicrosoftStore {
  MicrosoftStore._();

  /// Opens the Microsoft Store app
  static const MicrosoftStoreAction open = MicrosoftStoreAction(MicrosoftStoreActionType.open);

  /// Opens a specific app page in the Microsoft Store
  ///
  /// [productId] is the Microsoft Store product ID of the app to open (e.g., '9WZDNCRFHVJL' for Microsoft Edge).
  /// [language] is the language code for the store page (optional, e.g., 'en-us').
  /// [countryCode] is the country code for the store page (optional, e.g., 'US').
  static MicrosoftStoreAction openAppPage({
    required final String productId,
    final String? language,
    final String? countryCode,
  }) {
    final parameters = <String, String>{
      'productId': productId,
    };

    if (language != null) {
      parameters['language'] = language;
    }

    if (countryCode != null) {
      parameters['countryCode'] = countryCode;
    }

    return MicrosoftStoreAction(
      MicrosoftStoreActionType.openAppPage,
      parameters: parameters,
    );
  }

  /// Opens the review page for a specific app
  ///
  /// [productId] is the Microsoft Store product ID of the app to open (e.g., '9WZDNCRFHVJL' for Microsoft Edge).
  /// [language] is the language code for the store page (optional, e.g., 'en-us').
  /// [countryCode] is the country code for the store page (optional, e.g., 'US').
  static MicrosoftStoreAction openAppReviewPage({
    required final String productId,
    final String? language,
    final String? countryCode,
  }) {
    final parameters = <String, String>{
      'productId': productId,
    };

    if (language != null) {
      parameters['language'] = language;
    }

    if (countryCode != null) {
      parameters['countryCode'] = countryCode;
    }

    return MicrosoftStoreAction(
      MicrosoftStoreActionType.openAppReviewPage,
      parameters: parameters,
    );
  }
}

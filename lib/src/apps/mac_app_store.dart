import 'dart:core';

import 'package:deeplink_x/src/core/app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';

/// Mac App Store-specific action types that define available deeplink actions
enum MacAppStoreActionType implements ActionTypeEnum {
  /// Opens the Mac App Store app
  open,

  /// Opens a specific app page in the Mac App Store
  openAppPage,

  /// Opens the review page for a specific app
  openReview,
}

/// Mac App Store action implementation for handling Mac App Store-specific deeplinks
class MacAppStoreAction extends AppAction {
  /// Creates a new Mac App Store action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const MacAppStoreAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type);

  /// Base URI for Mac App Store app deeplinks
  static const baseUrl = 'macappstore://itunes.apple.com';

  /// Base URI for Mac App Store web fallback
  static const fallBackUri = 'https://apps.apple.com/app/mac';

  /// The type of Mac App Store action to perform
  final MacAppStoreActionType type;

  @override
  Future<List<Uri>> getUris() async {
    final List<Uri> uris = [];

    switch (type) {
      case MacAppStoreActionType.open:
        uris.add(Uri.parse(baseUrl));
        uris.add(Uri.parse(fallBackUri));
      case MacAppStoreActionType.openAppPage:
        final appId = parameters!['appId'];
        final appName = parameters!['appName'];
        final country = parameters!['country'];
        final mediaType = parameters!['mt'];
        final campaignToken = parameters!['ct'];
        final providerToken = parameters!['pt'];
        final affiliateToken = parameters!['at'];

        // Build query parameters
        final queryParams = <String, String>{'mt': mediaType!};

        if (campaignToken != null) {
          queryParams['ct'] = campaignToken;
        }
        if (providerToken != null) {
          queryParams['pt'] = providerToken;
        }
        if (affiliateToken != null) {
          queryParams['at'] = affiliateToken;
        }

        final pathSegments = <String>[];
        if (country != null) {
          pathSegments.add(country);
        }
        pathSegments.add('app');
        pathSegments.add('mac');
        pathSegments.add(appName!);
        pathSegments.add('id$appId');

        // Native app URI
        final nativeUri = Uri.parse(baseUrl).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );

        // Web fallback URI
        final webUri = Uri.parse(fallBackUri).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );

        uris.add(nativeUri);
        uris.add(webUri);

      case MacAppStoreActionType.openReview:
        final appId = parameters!['appId'];
        final appName = parameters!['appName'];
        final country = parameters!['country'];
        final mediaType = parameters!['mt'];

        // Add action=write-review parameter
        final queryParams = <String, String>{'action': 'write-review', 'mt': mediaType!};

        // Add other parameters if provided
        if (parameters!['ct'] != null) {
          queryParams['ct'] = parameters!['ct']!;
        }
        if (parameters!['pt'] != null) {
          queryParams['pt'] = parameters!['pt']!;
        }
        if (parameters!['at'] != null) {
          queryParams['at'] = parameters!['at']!;
        }

        final pathSegments = <String>[];
        if (country != null) {
          pathSegments.add(country);
        }
        pathSegments.add('app');
        pathSegments.add('mac');
        pathSegments.add(appName!);
        pathSegments.add('id$appId');

        // Native app URI for review
        final nativeUri = Uri.parse(baseUrl).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );

        // Web fallback URI for review
        final webUri = Uri.parse(fallBackUri).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );

        uris.add(nativeUri);
        uris.add(webUri);
    }

    return uris;
  }
}

/// Factory class for creating Mac App Store deeplink actions
///
/// This class provides convenient factory methods for creating common Mac App Store
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for Mac App Store-specific action creation.
class MacAppStore {
  MacAppStore._();

  /// Opens the Mac App Store app
  static const MacAppStoreAction open = MacAppStoreAction(MacAppStoreActionType.open);

  /// Opens a specific app page in the Mac App Store
  ///
  /// [appId] is the Mac App Store ID of the app to open. Must be a valid numeric ID
  /// between 1 and 10 digits long (e.g., '497799835' for Xcode).
  /// [appName] is the app name slug for the web URL
  /// [country] is the two-letter country code (optional)
  /// [mediaType] specifies the type of content (default: '12' for macOS apps)
  /// [campaignToken] is used to track campaigns (optional)
  /// [providerToken] is a numeric identifier for your team/developer (optional)
  /// [affiliateToken] is used for Apple's affiliate tracking (optional)
  static MacAppStoreAction openAppPage({
    required final String appId,
    required final String appName,
    final String? country,
    final String mediaType = '12',
    final String? campaignToken,
    final String? providerToken,
    final String? affiliateToken,
  }) {
    final parameters = <String, String>{
      'appId': appId,
      'appName': appName,
      'mt': mediaType,
    };

    if (country != null) {
      parameters['country'] = country;
    }
    if (campaignToken != null) {
      parameters['ct'] = campaignToken;
    }
    if (providerToken != null) {
      parameters['pt'] = providerToken;
    }
    if (affiliateToken != null) {
      parameters['at'] = affiliateToken;
    }

    return MacAppStoreAction(
      MacAppStoreActionType.openAppPage,
      parameters: parameters,
    );
  }

  /// Opens the review page for a specific app in the Mac App Store
  ///
  /// [appId] is the Mac App Store ID of the app to open. Must be a valid numeric ID
  /// between 1 and 10 digits long (e.g., '497799835' for Xcode).
  /// [appName] is the app name slug for the web URL
  /// [country] is the two-letter country code (optional)
  /// [mediaType] specifies the type of content (default: '12' for macOS apps)
  /// [campaignToken] is used to track campaigns (optional)
  /// [providerToken] is a numeric identifier for your team/developer (optional)
  /// [affiliateToken] is used for Apple's affiliate tracking (optional)
  static MacAppStoreAction openReview({
    required final String appId,
    required final String appName,
    final String? country,
    final String mediaType = '12',
    final String? campaignToken,
    final String? providerToken,
    final String? affiliateToken,
  }) {
    final parameters = <String, String>{'appId': appId, 'appName': appName, 'mt': mediaType};

    if (country != null) {
      parameters['country'] = country;
    }
    if (campaignToken != null) {
      parameters['ct'] = campaignToken;
    }
    if (providerToken != null) {
      parameters['pt'] = providerToken;
    }
    if (affiliateToken != null) {
      parameters['at'] = affiliateToken;
    }

    return MacAppStoreAction(
      MacAppStoreActionType.openReview,
      parameters: parameters,
    );
  }
}

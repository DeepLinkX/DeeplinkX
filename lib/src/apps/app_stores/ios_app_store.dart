import 'dart:core';

import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';

/// iOS App Store-specific action types that define available deeplink actions
enum IOSAppStoreActionType implements ActionTypeEnum {
  /// Opens the App Store app
  open,

  /// Opens a specific app page in the App Store
  openAppPage,

  /// Opens the review page for a specific app
  openReview,

  /// Opens the iMessage extension page for a specific app
  openMessagesExtension,
}

/// iOS App Store action implementation for handling App Store-specific deeplinks
class IOSAppStoreAction extends StoreAppAction {
  /// Creates a new iOS App Store action
  ///
  /// [type] specifies the type of action to perform
  /// [parameters] contains any additional data needed for the action
  const IOSAppStoreAction(
    this.type, {
    super.parameters,
  }) : super(actionType: type, platform: platformType);

  /// The native platform type
  static const platformType = PlatformType.ios;

  /// Base URI for App Store app deeplinks
  static const baseUrl = 'itms-apps://itunes.apple.com';

  /// Base URI for App Store web fallback
  static const fallBackUri = 'https://apps.apple.com';

  /// The type of iOS App Store action to perform
  final IOSAppStoreActionType type;

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case IOSAppStoreActionType.open:
        return Uri.parse(baseUrl);
      case IOSAppStoreActionType.openAppPage:
        final appId = parameters!['appId'];
        final appName = parameters!['appName'];
        final country = parameters!['country'];
        final mediaType = parameters!['mt'];
        final campaignToken = parameters!['ct'];
        final providerToken = parameters!['pt'];
        final affiliateToken = parameters!['at'];
        final uniqueOrigin = parameters!['uo'];

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
        if (uniqueOrigin != null) {
          queryParams['uo'] = uniqueOrigin;
        }

        final pathSegments = <String>[];
        if (country != null) {
          pathSegments.add(country);
        }
        pathSegments.add('app');
        pathSegments.add(appName!);
        pathSegments.add('id$appId');

        // Native app URI
        return Uri.parse(baseUrl).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );
      case IOSAppStoreActionType.openReview:
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
        pathSegments.add(appName!);
        pathSegments.add('id$appId');

        // Native app URI for review
        return Uri.parse(baseUrl).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );
      case IOSAppStoreActionType.openMessagesExtension:
        final appId = parameters!['appId'];
        final appName = parameters!['appName'];
        final country = parameters!['country'];
        final mediaType = parameters!['mt'];

        // Build query parameters with app=messages
        final queryParams = <String, String>{'app': 'messages', 'mt': mediaType!};

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
        pathSegments.add(appName!);
        pathSegments.add('id$appId');

        // Native app URI for messages extension
        return Uri.parse(baseUrl).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case IOSAppStoreActionType.open:
        return Uri.parse(fallBackUri);
      case IOSAppStoreActionType.openAppPage:
        final appId = parameters!['appId'];
        final appName = parameters!['appName'];
        final country = parameters!['country'];
        final mediaType = parameters!['mt'];
        final campaignToken = parameters!['ct'];
        final providerToken = parameters!['pt'];
        final affiliateToken = parameters!['at'];
        final uniqueOrigin = parameters!['uo'];

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
        if (uniqueOrigin != null) {
          queryParams['uo'] = uniqueOrigin;
        }

        final pathSegments = <String>[];
        if (country != null) {
          pathSegments.add(country);
        }
        pathSegments.add('app');
        pathSegments.add(appName!);
        pathSegments.add('id$appId');

        // Web fallback URI
        return Uri.parse(fallBackUri).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );
      case IOSAppStoreActionType.openReview:
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
        pathSegments.add(appName!);
        pathSegments.add('id$appId');

        // Web fallback URI for review
        return Uri.parse(fallBackUri).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );
      case IOSAppStoreActionType.openMessagesExtension:
        final appId = parameters!['appId'];
        final appName = parameters!['appName'];
        final country = parameters!['country'];
        final mediaType = parameters!['mt'];

        // Build query parameters with app=messages
        final queryParams = <String, String>{'app': 'messages', 'mt': mediaType!};

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
        pathSegments.add(appName!);
        pathSegments.add('id$appId');

        // Web fallback URI for messages extension
        return Uri.parse(fallBackUri).replace(
          pathSegments: pathSegments,
          queryParameters: queryParams,
        );
    }
  }
}

/// Factory class for creating iOS App Store deeplink actions
///
/// This class provides convenient factory methods for creating common iOS App Store
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for iOS App Store-specific action creation.
class IOSAppStore {
  IOSAppStore._();

  /// Opens the App Store app
  static const IOSAppStoreAction open = IOSAppStoreAction(IOSAppStoreActionType.open);

  /// Opens a specific app page in the App Store
  ///
  /// [appId] is the App Store ID of the app to open. Must be a valid numeric ID
  /// between 1 and 10 digits long (e.g., '284882215' for Facebook).
  /// [appName] is the app name slug for the web URL
  /// [country] is the two-letter country code (optional)
  /// [mediaType] specifies the type of content (default: '8' for iOS apps)
  /// [campaignToken] is used to track campaigns (optional)
  /// [providerToken] is a numeric identifier for your team/developer (optional)
  /// [affiliateToken] is used for Apple's affiliate tracking (optional)
  /// [uniqueOrigin] indicates the origin of the link (optional)
  static IOSAppStoreAction openAppPage({
    required final String appId,
    required final String appName,
    final String? country,
    final String mediaType = '8',
    final String? campaignToken,
    final String? providerToken,
    final String? affiliateToken,
    final String? uniqueOrigin,
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
    if (uniqueOrigin != null) {
      parameters['uo'] = uniqueOrigin;
    }

    return IOSAppStoreAction(
      IOSAppStoreActionType.openAppPage,
      parameters: parameters,
    );
  }

  /// Opens the review page for a specific app
  ///
  /// [appId] is the App Store ID of the app to open. Must be a valid numeric ID
  /// between 1 and 10 digits long (e.g., '284882215' for Facebook).
  /// [appName] is the app name slug for the web URL
  /// [country] is the two-letter country code (optional)
  /// [mediaType] specifies the type of content (default: '8' for iOS apps)
  /// [campaignToken] is used to track campaigns (optional)
  /// [providerToken] is a numeric identifier for your team/developer (optional)
  /// [affiliateToken] is used for Apple's affiliate tracking (optional)
  static IOSAppStoreAction openReview({
    required final String appId,
    required final String appName,
    final String? country,
    final String mediaType = '8',
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

    return IOSAppStoreAction(
      IOSAppStoreActionType.openReview,
      parameters: parameters,
    );
  }

  /// Opens the iMessage extension page for a specific app
  ///
  /// [appId] is the App Store ID of the app to open. Must be a valid numeric ID
  /// between 1 and 10 digits long (e.g., '284882215' for Facebook).
  /// [appName] is the app name slug for the web URL
  /// [country] is the two-letter country code (optional)
  /// [mediaType] specifies the type of content (default: '8' for iOS apps)
  /// [campaignToken] is used to track campaigns (optional)
  /// [providerToken] is a numeric identifier for your team/developer (optional)
  /// [affiliateToken] is used for Apple's affiliate tracking (optional)
  static IOSAppStoreAction openMessagesExtension({
    required final String appId,
    required final String appName,
    final String? country,
    final String mediaType = '8',
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

    return IOSAppStoreAction(
      IOSAppStoreActionType.openMessagesExtension,
      parameters: parameters,
    );
  }
}

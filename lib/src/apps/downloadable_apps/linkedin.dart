import 'package:deeplink_x/src/apps/app_stores/app_stores.dart';
import 'package:deeplink_x/src/core/app_actions/downloadable_app_action.dart';
import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/action_type_enum.dart';

/// LinkedIn-specific action types that define available deeplink actions
enum LinkedInActionType implements ActionTypeEnum {
  /// Opens a specific LinkedIn profile
  openProfile,

  /// Opens a specific LinkedIn company page
  openCompany,
}

/// LinkedIn action implementation for handling LinkedIn-specific deeplinks
class LinkedInAction extends DownloadableAppAction {
  /// Creates a new LinkedIn action
  ///
  /// [type] specifies the type of action to perform (e.g., open app, open profile)
  /// [fallBackToStore] determines if the action should redirect to app store when app isn't installed
  /// [parameters] contains any additional data needed for the action (e.g., profile ID)
  /// [actionType] is internally set to [type] for action handling
  /// [supportedStoresActions] is set to predefined [storesActions] for store handling
  LinkedInAction(
    this.type, {
    required super.fallBackToStore,
    super.parameters,
  }) : super(
          actionType: type,
          supportedStoresActions: storesActions,
        );

  /// Base URI for LinkedIn app deeplinks
  static const baseUrl = 'linkedin://';

  /// Base URI for LinkedIn web fallback
  static const fallBackUri = 'https://www.linkedin.com';

  /// The type of LinkedIn action to perform
  final LinkedInActionType type;

  /// List of store actions for downloading/opening LinkedIn across different platforms
  ///
  /// Contains actions for:
  /// - Play Store
  /// - iOS App Store
  static final List<StoreAppAction> storesActions = [
    PlayStore.openAppPage(packageName: 'com.linkedin.android'),
    IOSAppStore.openAppPage(appId: '288429040', appName: 'linkedin-network-job-finder'),
  ];

  @override
  Future<Uri> getNativeUri() async {
    switch (type) {
      case LinkedInActionType.openProfile:
        final profileId = parameters!['profileId'];

        return Uri.parse(baseUrl).replace(
          host: 'profile',
          path: profileId,
        );
      case LinkedInActionType.openCompany:
        final companyId = parameters!['companyId'];

        return Uri.parse(baseUrl).replace(
          host: 'company',
          path: companyId,
        );
    }
  }

  @override
  Future<Uri> getFallbackUri() async {
    switch (type) {
      case LinkedInActionType.openProfile:
        final profileId = parameters!['profileId'];

        return Uri.parse(fallBackUri).replace(
          pathSegments: ['in', profileId!],
        );
      case LinkedInActionType.openCompany:
        final companyId = parameters!['companyId'];

        return Uri.parse(fallBackUri).replace(
          pathSegments: ['company', companyId!],
        );
    }
  }
}

/// Factory class for creating LinkedIn deeplink actions
///
/// This class provides convenient factory methods for creating common LinkedIn
/// deeplink actions. While it only contains static members, this is intentional
/// as it serves as a namespace for LinkedIn-specific action creation.
class LinkedIn {
  LinkedIn._();

  /// Opens a specific LinkedIn profile
  ///
  /// [profileId] is the LinkedIn profile ID to open
  static LinkedInAction openProfile(
    final String profileId, {
    final bool fallBackToStore = false,
  }) =>
      LinkedInAction(
        LinkedInActionType.openProfile,
        fallBackToStore: fallBackToStore,
        parameters: {'profileId': profileId},
      );

  /// Opens a specific LinkedIn company page
  ///
  /// [companyId] is the LinkedIn company ID to open
  static LinkedInAction openCompany(
    final String companyId, {
    final bool fallBackToStore = false,
  }) =>
      LinkedInAction(
        LinkedInActionType.openCompany,
        fallBackToStore: fallBackToStore,
        parameters: {'companyId': companyId},
      );
}

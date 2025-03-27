import 'package:deeplink_x/src/core/app_actions/app_action.dart';
import 'package:deeplink_x/src/core/app_actions/store_app_action.dart';
import 'package:deeplink_x/src/core/enums/platform_type.dart';

/// Base class for all downloadable app actions.
///
/// This abstract class extends [AppAction] and adds functionality for apps
/// that can be downloaded from app stores if not installed on the device.
abstract class DownloadableAppAction extends AppAction {
  /// Creates a new downloadable app action.
  ///
  /// [actionType] specifies the type of action to perform.
  /// [fallBackToStore] determines if the action should redirect to an app store if the app is not installed.
  /// [supportedStoresActions] provides a list of store actions for different platforms.
  /// [parameters] contains any additional data needed for the action.
  const DownloadableAppAction({
    required this.fallBackToStore,
    required this.supportedStoresActions,
    required super.actionType,
    super.parameters,
  });

  /// Whether to redirect to an app store if the app is not installed.
  ///
  /// If true, the action will attempt to open the app store page for the app
  /// when the app is not installed on the device.
  final bool fallBackToStore;

  /// List of store actions for different platforms.
  ///
  /// These actions are used when [fallBackToStore] is true and the app
  /// is not installed on the device.
  final List<StoreAppAction> supportedStoresActions;

  /// Returns a list of URIs for this action based on the given platform.
  ///
  /// The method constructs and returns a list of URIs in the following order:
  /// 1. Native URI for the app action (always first)
  /// 2. If [fallBackToStore] is true and store actions exist for the platform:
  ///    - Store URIs for all supported stores on the platform (e.g. Play Store, App Store)
  ///    - These URIs will open the app's store page for download
  /// 3. Fallback URI (always last)
  ///    - A web or alternative URI that works when app/store links fail
  ///
  /// Example for a social media app:
  /// - Native URI: socialapp://profile/123
  /// - Store URIs: market://details?id=com.socialapp (Android)
  /// - Fallback: https://socialapp.com/profile/123
  ///
  /// [platform] The target platform (iOS, Android, etc.) to get URIs for
  /// Returns a list of URIs to try in sequential order
  @override
  Future<List<Uri>> getUris(final PlatformType platform) async {
    final List<Uri> uris = [await getNativeUri()];
    if (fallBackToStore) {
      final supportedStores = supportedStoresActions.where((final store) => store.platform == platform);
      if (supportedStores.isNotEmpty) {
        uris.addAll(await Future.wait(supportedStores.map((final store) => store.getNativeUri())));
      }
    }
    uris.add(await getFallbackUri());
    return uris;
  }
}

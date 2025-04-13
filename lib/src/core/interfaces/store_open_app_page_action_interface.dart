import 'package:deeplink_x/src/core/interfaces/interfaces.dart';

/// Represents an action to open an app's page in an app store.
///
/// This interface combines [StoreApp] and [AppAction] to define actions
/// that open specific app pages within app stores. This is typically used
/// to redirect users to download or update an app when it's not installed
/// or when a fallback is needed.
abstract class StoreOpenAppPageAction extends StoreApp implements AppAction {}

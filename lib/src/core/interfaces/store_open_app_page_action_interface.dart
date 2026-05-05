import 'package:deeplink_x/src/core/interfaces/interfaces.dart';

/// Represents an action to open an app's page in an app store.
///
/// This interface combines [StoreApp] and [AppAction] to define actions
/// that open specific app pages within app stores. This can be used to
/// redirect users to download, update, promote, or advertise a target app.
abstract class StoreOpenAppPageAction extends StoreApp implements AppAction {}

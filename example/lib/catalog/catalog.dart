import 'package:deeplink_x_example/catalog/map_apps.dart';
import 'package:deeplink_x_example/catalog/models.dart';
import 'package:deeplink_x_example/catalog/social_apps.dart';
import 'package:deeplink_x_example/catalog/stores.dart';

export 'package:deeplink_x_example/catalog/map_apps.dart';
export 'package:deeplink_x_example/catalog/models.dart';
export 'package:deeplink_x_example/catalog/social_apps.dart';
export 'package:deeplink_x_example/catalog/stores.dart';

/// Every supported app (social + maps) in gallery order.
final List<AppSpec> catalogApps = [...socialApps, ...mapApps];

/// Every supported store in gallery order.
final List<AppSpec> catalogStores = storeApps;

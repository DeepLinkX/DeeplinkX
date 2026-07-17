import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/catalog/models.dart';
import 'package:flutter/material.dart';

/// App stores shown in the example gallery.
///
/// Store deeplinks have no store fallback of their own, so their runners
/// ignore the detail screen's fallback toggle.
final List<AppSpec> storeApps = [
  AppSpec(
    id: 'play_store',
    name: 'Play Store',
    assetName: 'assets/google_play.png',
    category: CatalogCategory.stores,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open store',
        apiLabel: 'PlayStore.open()',
        buttonLabel: 'Open Play Store',
        runner: OpenAppRunner(({required final fallbackToStore}) => PlayStore.open()),
      ),
      ActionSpec(
        icon: Icons.apps_rounded,
        title: 'Open app page',
        apiLabel: 'PlayStore.openAppPage(packageName, referrer)',
        buttonLabel: 'Open listing',
        fields: const [
          ActionField(key: 'packageName', label: 'Package name', defaultValue: 'com.instagram.android'),
          ActionField(key: 'referrer', label: 'Referrer (optional)', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              PlayStore.openAppPage(packageName: v.value('packageName'), referrer: v.optionalValue('referrer')),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'ios_app_store',
    name: 'iOS App Store',
    assetName: 'assets/apple.png',
    category: CatalogCategory.stores,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open store',
        apiLabel: 'IOSAppStore.open()',
        buttonLabel: 'Open App Store',
        runner: OpenAppRunner(({required final fallbackToStore}) => IOSAppStore.open()),
      ),
      ActionSpec(
        icon: Icons.apps_rounded,
        title: 'Open app page',
        apiLabel: 'IOSAppStore.openAppPage(appId, appName)',
        buttonLabel: 'Open listing',
        fields: const [
          ActionField(key: 'appId', label: 'App ID', defaultValue: '389801252'),
          ActionField(key: 'appName', label: 'App name', defaultValue: 'instagram'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              IOSAppStore.openAppPage(appId: v.value('appId'), appName: v.value('appName')),
        ),
      ),
      ActionSpec(
        icon: Icons.star_rate_rounded,
        title: 'Rate app',
        apiLabel: 'IOSAppStore.rateApp(appId, appName)',
        buttonLabel: 'Open rating',
        fields: const [
          ActionField(key: 'appId', label: 'App ID', defaultValue: '389801252'),
          ActionField(key: 'appName', label: 'App name', defaultValue: 'instagram'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              IOSAppStore.rateApp(appId: v.value('appId'), appName: v.value('appName')),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'mac_app_store',
    name: 'Mac App Store',
    assetName: 'assets/apple.png',
    category: CatalogCategory.stores,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open store',
        apiLabel: 'MacAppStore.open()',
        buttonLabel: 'Open App Store',
        runner: OpenAppRunner(({required final fallbackToStore}) => MacAppStore.open()),
      ),
      ActionSpec(
        icon: Icons.apps_rounded,
        title: 'Open app page',
        apiLabel: 'MacAppStore.openAppPage(appId, appName)',
        buttonLabel: 'Open listing',
        fields: const [
          ActionField(key: 'appId', label: 'App ID', defaultValue: '497799835'),
          ActionField(key: 'appName', label: 'App name', defaultValue: 'xcode'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              MacAppStore.openAppPage(appId: v.value('appId'), appName: v.value('appName')),
        ),
      ),
      ActionSpec(
        icon: Icons.star_rate_rounded,
        title: 'Rate app',
        apiLabel: 'MacAppStore.rateApp(appId, appName)',
        buttonLabel: 'Open rating',
        fields: const [
          ActionField(key: 'appId', label: 'App ID', defaultValue: '497799835'),
          ActionField(key: 'appName', label: 'App name', defaultValue: 'xcode'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              MacAppStore.rateApp(appId: v.value('appId'), appName: v.value('appName')),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'microsoft_store',
    name: 'Microsoft Store',
    assetName: 'assets/microsoft.png',
    category: CatalogCategory.stores,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open store',
        apiLabel: 'MicrosoftStore.open()',
        buttonLabel: 'Open Microsoft Store',
        runner: OpenAppRunner(({required final fallbackToStore}) => MicrosoftStore.open()),
      ),
      ActionSpec(
        icon: Icons.apps_rounded,
        title: 'Open app page',
        apiLabel: 'MicrosoftStore.openAppPage(productId)',
        buttonLabel: 'Open listing',
        fields: const [ActionField(key: 'productId', label: 'Product ID', defaultValue: '9WZDNCRFHVJL')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => MicrosoftStore.openAppPage(productId: v.value('productId')),
        ),
      ),
      ActionSpec(
        icon: Icons.star_rate_rounded,
        title: 'Rate app',
        apiLabel: 'MicrosoftStore.rateApp(productId)',
        buttonLabel: 'Open rating',
        fields: const [ActionField(key: 'productId', label: 'Product ID', defaultValue: '9WZDNCRFHVJL')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => MicrosoftStore.rateApp(productId: v.value('productId')),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'huawei_app_gallery',
    name: 'AppGallery',
    assetName: 'assets/huawei.png',
    category: CatalogCategory.stores,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open store',
        apiLabel: 'HuaweiAppGalleryStore.open()',
        buttonLabel: 'Open AppGallery',
        runner: OpenAppRunner(({required final fallbackToStore}) => HuaweiAppGalleryStore.open()),
      ),
      ActionSpec(
        icon: Icons.apps_rounded,
        title: 'Open app page',
        apiLabel: 'HuaweiAppGalleryStore.openAppPage(packageName, appId, referrer)',
        buttonLabel: 'Open listing',
        fields: const [
          ActionField(key: 'packageName', label: 'Package name', defaultValue: 'org.telegram.messenger'),
          ActionField(key: 'appId', label: 'App ID', defaultValue: 'C101184875'),
          ActionField(key: 'referrer', label: 'Referrer (optional)', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => HuaweiAppGalleryStore.openAppPage(
            packageName: v.value('packageName'),
            appId: v.value('appId'),
            referrer: v.optionalValue('referrer'),
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'cafe_bazaar',
    name: 'Cafe Bazaar',
    assetName: 'assets/cafe_bazaar.png',
    category: CatalogCategory.stores,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open store',
        apiLabel: 'CafeBazaarStore.open()',
        buttonLabel: 'Open Cafe Bazaar',
        runner: OpenAppRunner(({required final fallbackToStore}) => CafeBazaarStore.open()),
      ),
      ActionSpec(
        icon: Icons.apps_rounded,
        title: 'Open app page',
        apiLabel: 'CafeBazaarStore.openAppPage(packageName)',
        buttonLabel: 'Open listing',
        fields: const [ActionField(key: 'packageName', label: 'Package name', defaultValue: 'org.telegram.messenger')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              CafeBazaarStore.openAppPage(packageName: v.value('packageName')),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'myket',
    name: 'Myket',
    assetName: 'assets/myket.png',
    category: CatalogCategory.stores,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open store',
        apiLabel: 'MyketStore.open()',
        buttonLabel: 'Open Myket',
        runner: OpenAppRunner(({required final fallbackToStore}) => MyketStore.open()),
      ),
      ActionSpec(
        icon: Icons.apps_rounded,
        title: 'Open app page',
        apiLabel: 'MyketStore.openAppPage(packageName)',
        buttonLabel: 'Open listing',
        fields: const [ActionField(key: 'packageName', label: 'Package name', defaultValue: 'org.telegram.messenger')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => MyketStore.openAppPage(packageName: v.value('packageName')),
        ),
      ),
      ActionSpec(
        icon: Icons.star_rate_rounded,
        title: 'Rate app',
        apiLabel: 'MyketStore.rateApp(packageName)',
        buttonLabel: 'Open review',
        fields: const [ActionField(key: 'packageName', label: 'Package name', defaultValue: 'org.telegram.messenger')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => MyketStore.rateApp(packageName: v.value('packageName')),
        ),
      ),
    ],
  ),
];

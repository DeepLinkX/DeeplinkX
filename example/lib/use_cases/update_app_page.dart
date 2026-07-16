import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:flutter/material.dart';

/// Demonstrates automatic and manual store selection for an app update flow.
class UpdateAppPage extends StatefulWidget {
  /// Creates the update-app use case.
  const UpdateAppPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<UpdateAppPage> createState() => _UpdateAppPageState();
}

class _UpdateAppPageState extends State<UpdateAppPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  late final List<LaunchOption<StoreOpenAppPageAction>> _options = Telegram().storeActions
      .map(_storeOption)
      .toList(growable: false);

  LaunchOption<StoreOpenAppPageAction> _storeOption(final StoreOpenAppPageAction action) {
    if (action is PlayStoreOpenAppPageAction) {
      return LaunchOption(
        id: 'play-store',
        title: 'Google Play Store',
        app: action,
        fallbackLabel: 'Browser listing',
        assetName: 'assets/google_play.png',
      );
    }
    if (action is HuaweiAppGalleryStoreOpenAppPageAction) {
      return LaunchOption(
        id: 'huawei-appgallery',
        title: 'Huawei AppGallery',
        app: action,
        fallbackLabel: 'Browser listing',
        assetName: 'assets/huawei.png',
      );
    }
    if (action is IOSAppStoreOpenAppPageAction) {
      return LaunchOption(
        id: 'ios-app-store',
        title: 'iOS App Store',
        app: action,
        fallbackLabel: 'Browser listing',
        assetName: 'assets/apple.png',
      );
    }
    if (action is MicrosoftStoreOpenAppPageAction) {
      return LaunchOption(
        id: 'microsoft-store',
        title: 'Microsoft Store',
        app: action,
        fallbackLabel: 'Browser listing',
        assetName: 'assets/microsoft.png',
      );
    }
    return LaunchOption(
      id: 'mac-app-store',
      title: 'Mac App Store',
      app: action,
      fallbackLabel: 'Browser listing',
      assetName: 'assets/apple.png',
    );
  }

  Future<void> _showStores() async {
    await showLaunchSelector<StoreOpenAppPageAction>(
      context: context,
      title: 'Choose a store',
      automaticSubtitle: 'Open the first Telegram store listing that matches this platform.',
      deeplinkX: _deeplinkX,
      options: _options,
      onAutomatic: () => _deeplinkX.redirectToStore(storeActions: _options.map((final option) => option.app).toList()),
      onSelected: _deeplinkX.launchAction,
    );
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Update App')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const UseCaseLeading(assetName: 'assets/telegram.png', size: 52),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Telegram update available', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          const Text('Version 12.0 includes performance and reliability improvements.'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    key: const ValueKey('open-store-selector'),
                    onPressed: _showStores,
                    icon: const Icon(Icons.system_update),
                    label: const Text('Choose update store'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Automatic selection uses Telegram’s store metadata and the current platform. Manual options remain visible so their browser fallbacks can also be tested.',
        ),
      ],
    ),
  );
}

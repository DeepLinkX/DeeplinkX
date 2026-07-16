import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:flutter/material.dart';

/// Demonstrates platform-aware rating and review entry points.
class RateReviewPage extends StatefulWidget {
  /// Creates the rating use case.
  const RateReviewPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<RateReviewPage> createState() => _RateReviewPageState();
}

class _RateReviewPageState extends State<RateReviewPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  late final IOSAppStoreRateAppAction _iosAction = IOSAppStore.rateApp(
    appId: '686449807',
    appName: 'telegram-messenger',
  );
  late final MacAppStoreRateAppAction _macAction = MacAppStore.rateApp(appId: '747648890', appName: 'telegram');
  late final MicrosoftStoreRateAppAction _windowsAction = MicrosoftStore.rateApp(productId: '9nztwsqntd0s');
  late final PlayStoreOpenAppPageAction _playAction = PlayStore.openAppPage(packageName: 'org.telegram.messenger');
  late final HuaweiAppGalleryStoreOpenAppPageAction _huaweiAction = HuaweiAppGalleryStore.openAppPage(
    packageName: 'org.telegram.messenger',
    appId: 'C101184875',
  );

  late final List<LaunchOption<App>> _options = [
    LaunchOption(
      id: 'ios-rate',
      title: 'Rate in iOS App Store',
      app: _iosAction,
      fallbackLabel: 'No rating fallback',
      assetName: 'assets/apple.png',
    ),
    LaunchOption(
      id: 'mac-rate',
      title: 'Rate in Mac App Store',
      app: _macAction,
      fallbackLabel: 'No rating fallback',
      assetName: 'assets/apple.png',
    ),
    LaunchOption(
      id: 'microsoft-rate',
      title: 'Rate in Microsoft Store',
      app: _windowsAction,
      fallbackLabel: 'No rating fallback',
      assetName: 'assets/microsoft.png',
    ),
    LaunchOption(
      id: 'play-listing',
      title: 'Open Google Play listing',
      app: _playAction,
      fallbackLabel: 'Browser listing',
      assetName: 'assets/google_play.png',
    ),
    LaunchOption(
      id: 'huawei-listing',
      title: 'Open AppGallery listing',
      app: _huaweiAction,
      fallbackLabel: 'Browser listing',
      assetName: 'assets/huawei.png',
    ),
  ];

  Future<bool> _automatic() => switch (_deeplinkX.currentPlatform) {
    PlatformType.ios => _deeplinkX.launchAction(_iosAction),
    PlatformType.macos => _deeplinkX.launchAction(_macAction),
    PlatformType.windows => _deeplinkX.launchAction(_windowsAction),
    PlatformType.android => _deeplinkX.redirectToStore(storeActions: [_playAction, _huaweiAction]),
    PlatformType.web || PlatformType.linux => Future.value(false),
  };

  Future<bool> _launch(final App app) {
    if (app is AppAction) {
      return _deeplinkX.launchAction(app);
    }
    return Future.value(false);
  }

  Future<void> _showStores() async {
    await showLaunchSelector<App>(
      context: context,
      title: 'Rate Telegram',
      automaticSubtitle: 'Use a direct rating action when available, otherwise open an Android store listing.',
      deeplinkX: _deeplinkX,
      options: _options,
      onAutomatic: _automatic,
      onSelected: _launch,
    );
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Rate & Review')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const UseCaseLeading(assetName: 'assets/telegram.png', size: 64),
                const SizedBox(height: 16),
                Text('Enjoying Telegram?', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                const Text('This sample demonstrates direct rating links and store-listing alternatives.'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    key: const ValueKey('open-rating-selector'),
                    onPressed: _showStores,
                    icon: const Icon(Icons.star),
                    label: const Text('Rate or review'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

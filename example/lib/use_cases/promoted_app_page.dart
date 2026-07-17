import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/blocks.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
import 'package:flutter/material.dart';

/// Demonstrates a tracked promoted-app call to action.
class PromotedAppPage extends StatefulWidget {
  /// Creates the promoted-app use case.
  const PromotedAppPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<PromotedAppPage> createState() => _PromotedAppPageState();
}

class _PromotedAppPageState extends State<PromotedAppPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  late final List<StoreOpenAppPageAction> _actions = [
    PlayStore.openAppPage(
      packageName: 'com.instagram.android',
      referrer: 'utm_source=deeplink_x&utm_medium=example&utm_campaign=summer_launch',
    ),
    IOSAppStore.openAppPage(
      appId: '389801252',
      appName: 'instagram',
      campaignToken: 'deeplink_x_example',
      providerToken: 'example_provider',
      affiliateToken: 'example_affiliate',
      uniqueOrigin: 'use_cases',
    ),
  ];
  bool _launching = false;

  Future<void> _openPromotion() async {
    if (_launching) {
      return;
    }
    setState(() => _launching = true);
    final result = await _deeplinkX.redirectToStore(storeActions: _actions);
    if (!mounted) {
      return;
    }
    setState(() => _launching = false);
    showLaunchResult(context, succeeded: result);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const ScreenHeader(title: 'Promoted App CTA'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              children: [
                PromoCard(
                  assetName: 'assets/instagram.png',
                  title: 'Discover Instagram',
                  description: 'A tracked store CTA without platform branches in the widget.',
                  buttonIcon: Icons.campaign_rounded,
                  buttonLabel: 'View in store',
                  buttonKey: const ValueKey('open-promoted-app'),
                  onPressed: _openPromotion,
                ),
                const SizedBox(height: 12),
                const NoteText(
                  'Google Play receives a referrer; the iOS App Store receives campaign, provider, affiliate, and origin tokens.',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

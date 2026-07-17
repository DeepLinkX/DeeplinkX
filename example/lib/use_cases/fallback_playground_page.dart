import 'dart:async';

import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/blocks.dart';
import 'package:deeplink_x_example/widgets/buttons.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
import 'package:flutter/material.dart';

/// Preset actions available in the fallback playground.
enum FallbackPreset {
  /// Telegram public profile action.
  telegram('Telegram profile'),

  /// Instagram public profile action.
  instagram('Instagram profile'),

  /// Google Maps coordinate action.
  googleMaps('Google Maps location');

  const FallbackPreset(this.label);

  /// User-facing label.
  final String label;
}

/// Fallback policies demonstrated by the playground.
enum FallbackPolicy {
  /// Attempt only the native action.
  disabled('Disabled'),

  /// Fall back directly to the action's website.
  web('Web'),

  /// Try the store before the action's website.
  storeThenWeb('Store then web');

  const FallbackPolicy(this.label);

  /// User-facing label.
  final String label;
}

/// Demonstrates the observable effect of fallback configuration.
class FallbackPlaygroundPage extends StatefulWidget {
  /// Creates the fallback playground.
  const FallbackPlaygroundPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<FallbackPlaygroundPage> createState() => _FallbackPlaygroundPageState();
}

class _FallbackPlaygroundPageState extends State<FallbackPlaygroundPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  FallbackPreset _preset = FallbackPreset.telegram;
  FallbackPolicy _policy = FallbackPolicy.web;
  UseCaseAvailability _availability = UseCaseAvailability.loading;
  bool _launching = false;
  bool? _lastResult;

  @override
  void initState() {
    super.initState();
    unawaited(_checkAvailability());
  }

  _FallbackTarget _target() {
    final storeFallback = _policy == FallbackPolicy.storeThenWeb;
    switch (_preset) {
      case FallbackPreset.telegram:
        final action = Telegram.openProfile(username: 'durov', fallbackToStore: storeFallback);
        return _FallbackTarget(action, action);
      case FallbackPreset.instagram:
        final action = Instagram.openProfile(username: 'instagram', fallbackToStore: storeFallback);
        return _FallbackTarget(action, action);
      case FallbackPreset.googleMaps:
        final action = GoogleMaps.view(
          coordinate: const Coordinate(latitude: 35.6892, longitude: 51.3890),
          fallbackToStore: storeFallback,
        );
        return _FallbackTarget(action, action);
    }
  }

  Future<void> _checkAvailability() async {
    setState(() => _availability = UseCaseAvailability.loading);
    final target = _target();
    final availability =
        !target.app.supportedPlatforms.contains(_deeplinkX.currentPlatform)
            ? UseCaseAvailability.unsupported
            : await _deeplinkX.isAppInstalled(target.app)
            ? UseCaseAvailability.installed
            : UseCaseAvailability.notInstalled;
    if (!mounted) {
      return;
    }
    setState(() => _availability = availability);
  }

  Future<void> _launch() async {
    if (_launching) {
      return;
    }
    setState(() => _launching = true);
    final target = _target();
    final result = await _deeplinkX.launchAction(target.action, disableFallback: _policy == FallbackPolicy.disabled);
    if (!mounted) {
      return;
    }
    setState(() {
      _launching = false;
      _lastResult = result;
    });
    showLaunchResult(context, succeeded: result);
  }

  String get _availabilityLabel => switch (_availability) {
    UseCaseAvailability.loading => 'Checking…',
    UseCaseAvailability.installed => 'Installed',
    UseCaseAvailability.notInstalled => 'Not installed',
    UseCaseAvailability.unsupported => 'Not native on this platform',
  };

  String get _policyDescription => switch (_policy) {
    FallbackPolicy.disabled => 'Only the native action is attempted.',
    FallbackPolicy.web => 'The action’s web URL is used when native launch fails.',
    FallbackPolicy.storeThenWeb => 'The matching store is tried before the action’s web URL.',
  };

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    final lastResult = _lastResult;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ScreenHeader(title: 'Fallback Playground'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                children: [
                  SelectCard(
                    label: 'Action preset',
                    child: DropdownButtonFormField<FallbackPreset>(
                      key: const ValueKey('fallback-preset'),
                      initialValue: _preset,
                      decoration: const InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 4),
                      ),
                      style: TextStyle(fontSize: 14.5, color: palette.text, fontFamily: 'InstrumentSans'),
                      dropdownColor: palette.card,
                      items: [
                        for (final preset in FallbackPreset.values)
                          DropdownMenuItem(value: preset, child: Text(preset.label)),
                      ],
                      onChanged:
                          _launching
                              ? null
                              : (final preset) {
                                if (preset == null) {
                                  return;
                                }
                                setState(() {
                                  _preset = preset;
                                  _lastResult = null;
                                });
                                unawaited(_checkAvailability());
                              },
                    ),
                  ),
                  const SizedBox(height: 12),
                  const LabelText('Fallback policy'),
                  const SizedBox(height: 8),
                  SegmentedPills(
                    key: const ValueKey('fallback-policy'),
                    options: [
                      for (final policy in FallbackPolicy.values)
                        SegmentedPillOption(
                          icon: _policyIcon(policy),
                          label: policy.label,
                          selected: policy == _policy,
                          onTap:
                              _launching
                                  ? () {}
                                  : () => setState(() {
                                    _policy = policy;
                                    _lastResult = null;
                                  }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  StatusCard(
                    items: [
                      StatusItem(label: 'Platform', value: _deeplinkX.currentPlatform.value),
                      StatusItem(
                        label: 'Native status',
                        value: _availabilityLabel,
                        valueColor: switch (_availability) {
                          UseCaseAvailability.installed => AppPalette.statusInstalled,
                          UseCaseAvailability.unsupported => AppPalette.statusUnsupported,
                          UseCaseAvailability.loading || UseCaseAvailability.notInstalled => palette.faint,
                        },
                      ),
                      StatusItem(label: 'Configured policy', value: _policy.label),
                      StatusItem(
                        label: 'Last result',
                        value:
                            lastResult == null
                                ? 'Not launched'
                                : lastResult
                                ? 'Success'
                                : 'Failure',
                        valueColor: (lastResult ?? false) ? AppPalette.statusInstalled : palette.faint,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  NoteText(_policyDescription),
                  const SizedBox(height: 12),
                  AccentButton(
                    key: const ValueKey('launch-fallback-preset'),
                    label: 'Launch configured action',
                    icon: Icons.rocket_launch_rounded,
                    onPressed: _launch,
                  ),
                  const SizedBox(height: 12),
                  const NoteText(
                    'DeeplinkX returns a final boolean; this page does not infer which internal launch stage succeeded.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _policyIcon(final FallbackPolicy policy) => switch (policy) {
    FallbackPolicy.disabled => Icons.block_rounded,
    FallbackPolicy.web => Icons.language_rounded,
    FallbackPolicy.storeThenWeb => Icons.storefront_rounded,
  };
}

class _FallbackTarget {
  const _FallbackTarget(this.app, this.action);

  final App app;
  final AppAction action;
}

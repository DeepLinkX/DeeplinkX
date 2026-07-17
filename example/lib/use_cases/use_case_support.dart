import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/widgets/blocks.dart';
import 'package:deeplink_x_example/widgets/icon_box.dart';
import 'package:deeplink_x_example/widgets/list_row.dart';
import 'package:flutter/material.dart';

/// Describes an app-backed option displayed in a use-case selector.
class LaunchOption<T extends App> {
  /// Creates a launch option.
  const LaunchOption({
    required this.id,
    required this.title,
    required this.app,
    required this.fallbackLabel,
    this.assetName,
    this.icon,
  }) : assert(assetName != null || icon != null, 'An asset or icon is required.');

  /// Stable identifier used by tests and widget keys.
  final String id;

  /// User-facing option title.
  final String title;

  /// App or app action represented by this option.
  final T app;

  /// Description of what happens when the native app is unavailable.
  final String fallbackLabel;

  /// Optional bundled image asset.
  final String? assetName;

  /// Optional Material icon used when no asset is supplied.
  final IconData? icon;
}

/// Availability state shown beside a launch option.
enum UseCaseAvailability {
  /// Installation status is still loading.
  loading,

  /// The native app is installed.
  installed,

  /// The native app is supported but is not installed.
  notInstalled,

  /// The native app does not support the current platform.
  unsupported,
}

/// Shows a reusable app selector and reports its launch result.
Future<bool?> showLaunchSelector<T extends App>({
  required final BuildContext context,
  required final String title,
  required final String automaticSubtitle,
  required final DeeplinkX deeplinkX,
  required final List<LaunchOption<T>> options,
  required final Future<bool> Function() onAutomatic,
  required final Future<bool> Function(T app) onSelected,
  final String pickLabel = 'Or pick an option',
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder:
        (final context) => SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.85,
          child: LaunchSelectorSheet<T>(
            title: title,
            automaticSubtitle: automaticSubtitle,
            deeplinkX: deeplinkX,
            options: options,
            onAutomatic: onAutomatic,
            onSelected: onSelected,
            pickLabel: pickLabel,
          ),
        ),
  );

  if (result != null && context.mounted) {
    showLaunchResult(context, succeeded: result);
  }
  return result;
}

/// Bottom-sheet content used by store and map selectors.
class LaunchSelectorSheet<T extends App> extends StatefulWidget {
  /// Creates selector sheet content.
  const LaunchSelectorSheet({
    required this.title,
    required this.automaticSubtitle,
    required this.deeplinkX,
    required this.options,
    required this.onAutomatic,
    required this.onSelected,
    this.pickLabel = 'Or pick an option',
    super.key,
  });

  /// Heading displayed above the options.
  final String title;

  /// Explanation displayed under the Automatic option.
  final String automaticSubtitle;

  /// DeeplinkX instance used for installation checks.
  final DeeplinkX deeplinkX;

  /// Provider or store options.
  final List<LaunchOption<T>> options;

  /// Callback used by Automatic.
  final Future<bool> Function() onAutomatic;

  /// Callback used by a manually selected option.
  final Future<bool> Function(T app) onSelected;

  /// Uppercase label separating Automatic from the manual options.
  final String pickLabel;

  @override
  State<LaunchSelectorSheet<T>> createState() => _LaunchSelectorSheetState<T>();
}

class _LaunchSelectorSheetState<T extends App> extends State<LaunchSelectorSheet<T>> {
  late List<UseCaseAvailability> _availability;
  bool _launching = false;

  @override
  void initState() {
    super.initState();
    _availability = List.filled(widget.options.length, UseCaseAvailability.loading);
    _loadAvailability();
  }

  Future<void> _loadAvailability() async {
    final availability = await Future.wait(
      widget.options.map((final option) async {
        if (!option.app.supportedPlatforms.contains(widget.deeplinkX.currentPlatform)) {
          return UseCaseAvailability.unsupported;
        }
        final installed = await widget.deeplinkX.isAppInstalled(option.app);
        return installed ? UseCaseAvailability.installed : UseCaseAvailability.notInstalled;
      }),
    );
    if (!mounted) {
      return;
    }
    setState(() => _availability = availability);
  }

  Future<void> _launch(final Future<bool> Function() callback) async {
    if (_launching) {
      return;
    }
    setState(() => _launching = true);
    final result = await callback();
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(color: palette.chev, borderRadius: BorderRadius.circular(2)),
              child: const SizedBox(width: 36, height: 4),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    color: palette.text,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Close',
                onPressed: _launching ? null : () => Navigator.of(context).pop(),
                icon: Icon(Icons.close_rounded, size: 19, color: palette.faint),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            children: [
              Material(
                color: palette.accentSoft,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  key: const ValueKey('selector-automatic'),
                  borderRadius: BorderRadius.circular(14),
                  onTap: _launching ? null : () => _launch(widget.onAutomatic),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      children: [
                        IconBox(
                          size: 38,
                          radius: 11,
                          color: palette.accent,
                          child: const Icon(Icons.auto_awesome_rounded, size: 20, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Automatic',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: palette.text),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                widget.automaticSubtitle,
                                style: TextStyle(fontSize: 11.5, color: palette.sub, height: 1.35),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (_launching)
                          const _SmallProgressIndicator()
                        else
                          Icon(Icons.chevron_right_rounded, size: 18, color: palette.accentFg),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              LabelText(widget.pickLabel),
              const SizedBox(height: 4),
              if (widget.options.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No manual options are configured for this use case.', textAlign: TextAlign.center),
                ),
              for (var index = 0; index < widget.options.length; index++)
                _OptionRowFor<T>(
                  key: ValueKey('selector-${widget.options[index].id}'),
                  option: widget.options[index],
                  availability: _availability[index],
                  enabled: !_launching,
                  showDivider: index < widget.options.length - 1,
                  onTap: () => _launch(() => widget.onSelected(widget.options[index].app)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OptionRowFor<T extends App> extends StatelessWidget {
  const _OptionRowFor({
    required this.option,
    required this.availability,
    required this.enabled,
    required this.showDivider,
    required this.onTap,
    super.key,
  });

  final LaunchOption<T> option;
  final UseCaseAvailability availability;
  final bool enabled;
  final bool showDivider;
  final VoidCallback onTap;

  String get _status => switch (availability) {
    UseCaseAvailability.loading => 'Checking availability…',
    UseCaseAvailability.installed => 'Installed',
    UseCaseAvailability.notInstalled => 'Not installed • ${option.fallbackLabel}',
    UseCaseAvailability.unsupported => 'Not native on this platform • ${option.fallbackLabel}',
  };

  Color? get _dotColor => switch (availability) {
    UseCaseAvailability.loading => null,
    UseCaseAvailability.installed => AppPalette.statusInstalled,
    UseCaseAvailability.notInstalled => AppPalette.statusMissing,
    UseCaseAvailability.unsupported => AppPalette.statusUnsupported,
  };

  @override
  Widget build(final BuildContext context) => OptionRow(
    title: option.title,
    assetName: option.assetName,
    icon: option.icon,
    statusText: _status,
    statusDotColor: _dotColor,
    enabled: enabled,
    showDivider: showDivider,
    trailing: availability == UseCaseAvailability.loading ? const _SmallProgressIndicator() : null,
    onTap: onTap,
  );
}

/// Leading icon that supports either an asset or a Material icon.
class UseCaseLeading extends StatelessWidget {
  /// Creates a leading icon.
  const UseCaseLeading({this.assetName, this.icon, this.size = 40, super.key})
    : assert(assetName != null || icon != null, 'An asset or icon is required.');

  /// Optional asset path.
  final String? assetName;

  /// Optional Material icon.
  final IconData? icon;

  /// Width and height of the leading visual.
  final double size;

  @override
  Widget build(final BuildContext context) {
    final assetName = this.assetName;
    if (assetName != null) {
      return AssetLogo(assetName: assetName, size: size);
    }
    return Icon(icon, size: size);
  }
}

class _SmallProgressIndicator extends StatelessWidget {
  const _SmallProgressIndicator();

  @override
  Widget build(final BuildContext context) =>
      const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2));
}

/// Displays a standardized launch success or failure message.
void showLaunchResult(final BuildContext context, {required final bool succeeded}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(succeeded ? 'Launch request succeeded.' : 'Nothing could be launched.')));
}

/// Displays a standardized input validation message.
void showInputError(final BuildContext context, final String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

/// Displays a launch result for a detail-screen action, including the exact
/// API label and whether store fallback was disabled for the attempt.
void showActionResult(
  final BuildContext context, {
  required final bool succeeded,
  required final String apiLabel,
  required final bool fallbackEnabled,
}) {
  final prefix = succeeded ? 'Launch request succeeded' : 'Nothing could be launched';
  final suffix = fallbackEnabled ? '' : ' · fallback disabled';
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$prefix · $apiLabel$suffix')));
}

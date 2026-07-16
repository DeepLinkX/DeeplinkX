import 'package:deeplink_x/deeplink_x.dart';
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
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
        child: Row(
          children: [
            Expanded(child: Text(widget.title, style: Theme.of(context).textTheme.titleLarge)),
            IconButton(
              tooltip: 'Close',
              onPressed: _launching ? null : () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
      const Divider(height: 1),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            ListTile(
              key: const ValueKey('selector-automatic'),
              enabled: !_launching,
              leading: const CircleAvatar(child: Icon(Icons.auto_awesome)),
              title: const Text('Automatic'),
              subtitle: Text(widget.automaticSubtitle),
              trailing: _launching ? const _SmallProgressIndicator() : const Icon(Icons.chevron_right),
              onTap: () => _launch(widget.onAutomatic),
            ),
            const Divider(),
            if (widget.options.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text('No manual options are configured for this use case.', textAlign: TextAlign.center),
              ),
            for (var index = 0; index < widget.options.length; index++)
              _OptionTile<T>(
                key: ValueKey('selector-${widget.options[index].id}'),
                option: widget.options[index],
                availability: _availability[index],
                enabled: !_launching,
                onTap: () => _launch(() => widget.onSelected(widget.options[index].app)),
              ),
          ],
        ),
      ),
    ],
  );
}

class _OptionTile<T extends App> extends StatelessWidget {
  const _OptionTile({
    required this.option,
    required this.availability,
    required this.enabled,
    required this.onTap,
    super.key,
  });

  final LaunchOption<T> option;
  final UseCaseAvailability availability;
  final bool enabled;
  final VoidCallback onTap;

  String get _status => switch (availability) {
    UseCaseAvailability.loading => 'Checking availability…',
    UseCaseAvailability.installed => 'Installed',
    UseCaseAvailability.notInstalled => 'Not installed • ${option.fallbackLabel}',
    UseCaseAvailability.unsupported => 'Not native on this platform • ${option.fallbackLabel}',
  };

  @override
  Widget build(final BuildContext context) => ListTile(
    enabled: enabled,
    leading: UseCaseLeading(assetName: option.assetName, icon: option.icon),
    title: Text(option.title),
    subtitle: Text(_status),
    trailing:
        availability == UseCaseAvailability.loading ? const _SmallProgressIndicator() : const Icon(Icons.chevron_right),
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
      return Image.asset(
        assetName,
        height: size,
        width: size,
        errorBuilder: (final context, final error, final stackTrace) => Icon(Icons.broken_image, size: size),
      );
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

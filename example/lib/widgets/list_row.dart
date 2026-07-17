import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/widgets/icon_box.dart';
import 'package:flutter/material.dart';

/// Small colored availability dot.
class StatusDot extends StatelessWidget {
  /// Creates a status dot of [color].
  const StatusDot({required this.color, this.size = 6, super.key});

  /// Dot color.
  final Color color;

  /// Dot diameter.
  final double size;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: SizedBox.square(dimension: size),
  );
}

/// Tappable list row with a logo box, title, status line, and trailing icon,
/// used by the use-case row cards and the launch selector sheet.
class OptionRow extends StatelessWidget {
  /// Creates an option row.
  const OptionRow({
    required this.title,
    required this.onTap,
    this.assetName,
    this.icon,
    this.statusText,
    this.statusDotColor,
    this.trailingIcon = Icons.chevron_right_rounded,
    this.trailing,
    this.enabled = true,
    this.showDivider = true,
    super.key,
  });

  /// Row title.
  final String title;

  /// Tap handler.
  final VoidCallback onTap;

  /// Bundled logo asset path (takes precedence over [icon]).
  final String? assetName;

  /// Material icon shown when no asset is supplied.
  final IconData? icon;

  /// Optional status line under the title.
  final String? statusText;

  /// Optional status-dot color shown before [statusText].
  final Color? statusDotColor;

  /// Trailing icon; defaults to a chevron.
  final IconData trailingIcon;

  /// Overrides the trailing icon entirely (e.g. with a progress indicator).
  final Widget? trailing;

  /// Whether the row responds to taps.
  final bool enabled;

  /// Whether to draw the bottom hairline divider.
  final bool showDivider;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    final statusText = this.statusText;
    return InkWell(
      onTap: enabled ? onTap : null,
      child: DecoratedBox(
        decoration: BoxDecoration(border: showDivider ? Border(bottom: BorderSide(color: palette.line)) : null),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              IconBox(
                size: 34,
                radius: 9,
                color: palette.well,
                child:
                    assetName != null
                        ? AssetLogo(assetName: assetName!, size: 21)
                        : Icon(icon, size: 19, color: palette.sub),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: palette.text),
                    ),
                    if (statusText != null) ...[
                      const SizedBox(height: 1),
                      Row(
                        children: [
                          if (statusDotColor != null) ...[StatusDot(color: statusDotColor!), const SizedBox(width: 5)],
                          Expanded(
                            child: Text(
                              statusText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11, color: palette.faint),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              trailing ?? Icon(trailingIcon, size: 17, color: palette.chev),
            ],
          ),
        ),
      ),
    );
  }
}

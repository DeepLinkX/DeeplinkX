import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Square rounded icon button used in headers (back, close, theme toggle).
class HeaderIconButton extends StatelessWidget {
  /// Creates a header icon button.
  const HeaderIconButton({required this.icon, required this.onPressed, this.tooltip, this.color, super.key});

  /// Icon to display.
  final IconData icon;

  /// Tap handler; the button is disabled when null.
  final VoidCallback? onPressed;

  /// Optional tooltip.
  final String? tooltip;

  /// Icon color; defaults to the palette's primary text color.
  final Color? color;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    Widget button = Material(
      color: palette.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox.square(dimension: 38, child: Icon(icon, size: 20, color: color ?? palette.text)),
      ),
    );
    final tooltip = this.tooltip;
    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }
    return button;
  }
}

/// Screen header with a back button, title, and optional trailing widget.
class ScreenHeader extends StatelessWidget {
  /// Creates a screen header.
  const ScreenHeader({required this.title, this.trailing, super.key});

  /// Screen title.
  final String title;

  /// Optional trailing widget (e.g. the store-fallback pill).
  final Widget? trailing;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Row(
        children: [
          HeaderIconButton(
            icon: Icons.arrow_back_rounded,
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: palette.text),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

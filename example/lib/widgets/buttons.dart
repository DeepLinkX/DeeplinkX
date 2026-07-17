import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Accent action button used across detail and use-case screens.
///
/// Renders filled (accent background, white text) or outlined (1.5px accent
/// border, accent text) per the design file.
class AccentButton extends StatelessWidget {
  /// Creates an accent button.
  const AccentButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = true,
    this.dense = false,
    super.key,
  });

  /// Button caption.
  final String label;

  /// Tap handler.
  final VoidCallback onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Whether the button is filled with the accent color (true) or outlined.
  final bool filled;

  /// Uses the slightly tighter metrics of detail-screen action buttons.
  final bool dense;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    final foreground = filled ? Colors.white : palette.accentFg;
    final radius = BorderRadius.circular(dense ? 11 : 12);
    return Material(
      color: filled ? palette.accent : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: filled ? BorderSide.none : BorderSide(color: palette.accentFg, width: 1.5),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: dense ? 11 : 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[Icon(icon, size: dense ? 18 : 19, color: foreground), const SizedBox(width: 8)],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: dense ? 13.5 : 14, fontWeight: FontWeight.w600, color: foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

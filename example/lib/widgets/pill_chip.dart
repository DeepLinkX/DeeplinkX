import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Rounded filter chip used on the home screen.
class PillChip extends StatelessWidget {
  /// Creates a filter chip.
  const PillChip({required this.label, required this.selected, required this.onTap, super.key});

  /// Chip caption.
  final String label;

  /// Whether the chip's filter is active.
  final bool selected;

  /// Tap handler.
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return Material(
      color: selected ? palette.accent : palette.card,
      borderRadius: BorderRadius.circular(99),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: selected ? Colors.white : palette.sub),
          ),
        ),
      ),
    );
  }
}

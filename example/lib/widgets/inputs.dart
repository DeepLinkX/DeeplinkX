import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Inset text field with a small uppercase label, per the design file.
class LabeledField extends StatelessWidget {
  /// Creates a labeled field.
  const LabeledField({
    required this.label,
    required this.controller,
    this.placeholder,
    this.fillColor,
    this.keyboardType,
    this.fieldKey,
    super.key,
  });

  /// Field label, rendered uppercase.
  final String label;

  /// Backing controller for the field.
  final TextEditingController controller;

  /// Optional hint shown while the field is empty.
  final String? placeholder;

  /// Background color; defaults to the palette's well color.
  final Color? fillColor;

  /// Optional keyboard type (e.g. numeric for coordinates).
  final TextInputType? keyboardType;

  /// Key applied to the inner [TextField] so tests can enter text.
  final Key? fieldKey;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(color: fillColor ?? palette.well, borderRadius: BorderRadius.circular(11)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 8, 13, 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, letterSpacing: 0.7, color: palette.faint),
            ),
            TextField(
              key: fieldKey,
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(fontSize: 14, color: palette.text),
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: TextStyle(fontSize: 14, color: palette.chev),
                contentPadding: const EdgeInsets.only(top: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

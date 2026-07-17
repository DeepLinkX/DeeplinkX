import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// "Store fallback" pill with a compact 34×20 animated toggle, per the design
/// file. Flutter's [Switch] cannot shrink to these metrics, so the knob is a
/// custom [AnimatedContainer].
class FallbackPill extends StatelessWidget {
  /// Creates the store-fallback pill.
  const FallbackPill({required this.value, required this.onChanged, super.key});

  /// Whether store fallback is enabled.
  final bool value;

  /// Called with the toggled value when the switch is tapped.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(color: palette.card, borderRadius: BorderRadius.circular(99)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 8, 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Store fallback', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: palette.sub)),
            const SizedBox(width: 7),
            Semantics(
              label: 'Store fallback',
              toggled: value,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(!value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 34,
                  height: 20,
                  decoration: BoxDecoration(
                    color: value ? palette.accent : palette.chev,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 150),
                    alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 2, offset: Offset(0, 1))],
                        ),
                        child: const SizedBox.square(dimension: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

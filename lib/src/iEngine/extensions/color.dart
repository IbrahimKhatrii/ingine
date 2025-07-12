import 'package:flutter/material.dart';

/// ColorUtils
extension ColorUtils on Color {
  /// adjust brightness between 0-1 and 0.5 or 1/2 is original value
  Color brightness(double amount) {
    final hsl = HSLColor.fromColor(this);
    final double delta = (amount.clamp(0.0, 1.0) - .5) * 2;
    final adj = (hsl.lightness + delta).clamp(0.0, 1.0);
    return hsl.withLightness(adj).toColor();
  }
}

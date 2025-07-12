import 'package:flutter/material.dart';

/// Extension on [Color] to provide brightness adjustment utilities.
extension ColorUtils on Color {
  /// Returns a new [Color] with its brightness adjusted.
  ///
  /// The [amount] must be between `0.0` and `1.0`:
  /// - `0.5` (or `1/2`) leaves the brightness unchanged.
  /// - Less than `0.5` makes the color darker.
  /// - Greater than `0.5` makes the color brighter.
  ///
  /// Example:
  /// ```dart
  /// color.brightness(0.2); // Darker
  /// color.brightness(0.8); // Brighter
  /// ```
  Color brightness(double amount) {
    final hsl = HSLColor.fromColor(this);
    final double delta = (amount.clamp(0.0, 1.0) - 0.5) * 2;
    final double adjustedLightness = (hsl.lightness + delta).clamp(0.0, 1.0);
    return hsl.withLightness(adjustedLightness).toColor();
  }
}

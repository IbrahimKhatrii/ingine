part of '../../engine.dart';

extension ColorUtils on Color {
  Color brightness(double amount) {
    final hsl = HSLColor.fromColor(this);
    final double delta = (amount.clamp(0.0, 1.0) - .5) * 2;
    final adj = (hsl.lightness + delta).clamp(0.0, 1.0);
    return hsl.withLightness(adj).toColor();
  }
}

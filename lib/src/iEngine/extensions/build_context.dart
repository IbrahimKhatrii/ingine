part of '../../engine.dart';

extension ContextExtensions on BuildContext {
  Size get display => MediaQuery.of(this).size;

  // Platform (Size)
  bool get isMobile => display.width < 600;
  bool get isTablet => display.width > 600 && display.width <= 800;

  bool get isDesktop => display.width > 1024;

  // Orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isPortrait => !isLandscape;
}

part of '../../engine.dart';

extension ContextExtensions on BuildContext {
  Size get display => MediaQuery.of(this).size;

  // Platform (Size)
  bool get isMobile => display.width < 600;
  bool get isTablet => display.width > 600 && display.width <= 800;

  bool get isDesktop => display.width > 1024;

  // Platform type
  bool get isWeb => kIsWeb;

  // Only valid if not web
  // Because dart:io's Platform throws a runtime error on the web — so this avoids that.
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isLinux => !kIsWeb && Platform.isLinux;
  bool get isMacOS => !kIsWeb && Platform.isMacOS;

  // Orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isPortrait => !isLandscape;
}

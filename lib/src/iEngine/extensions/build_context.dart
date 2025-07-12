// part of '../../../engine.dart';

import 'package:flutter/material.dart';

/// Extension on [BuildContext] to provide responsive layout helpers
/// based on screen size and orientation.
extension ContextExtensions on BuildContext {
  /// The size of the current screen (logical pixels).
  ///
  /// Equivalent to `MediaQuery.of(context).size`.
  Size get display => MediaQuery.of(this).size;

  // --------------------------
  // Platform Size Categories
  // --------------------------

  /// Returns `true` if the screen width is less than 600 pixels.
  ///
  /// Typically used to determine if the device is a mobile phone.
  bool get isMobile => display.width < 600;

  /// Returns `true` if the screen width is between 600 and 800 pixels.
  ///
  /// This is a common heuristic for tablets and small form factors.
  bool get isTablet => display.width > 600 && display.width <= 800;

  /// Returns `true` if the screen width is greater than 1024 pixels.
  ///
  /// Indicates a desktop or large tablet layout.
  bool get isDesktop => display.width > 1024;

  // --------------------------
  // Orientation
  // --------------------------

  /// Returns `true` if the device is in landscape orientation.
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Returns `true` if the device is in portrait orientation.
  bool get isPortrait => !isLandscape;
}

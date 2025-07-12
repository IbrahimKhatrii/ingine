import 'package:flutter/material.dart';

/// Extension on [Path] to provide smooth curve utilities.
extension PathExtension on Path {
  /// Adds a smooth quadratic Bézier curve through the given list of [points].
  ///
  /// This method constructs a visually smooth curve by drawing a series
  /// of quadratic Bézier segments between midpoints of each adjacent pair
  /// of points.
  ///
  /// The original path is updated, and the same [Path] is returned to allow chaining.
  ///
  /// Example:
  /// ```dart
  /// final path = Path().addSmoothCurve([
  ///   Offset(0, 100),
  ///   Offset(50, 0),
  ///   Offset(100, 100),
  /// ]);
  /// ```
  ///
  /// Requirements:
  /// - Must provide at least 2 points; otherwise, the path remains unchanged.
  Path addSmoothCurve(List<Offset> points) {
    if (points.length < 2) return this;

    // Move to the first point
    moveTo(points[0].dx, points[0].dy);

    // Iterate through the points and draw quadratic Bézier curves
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      // Calculate midpoint between p1 and p2
      final mid = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);

      // Add a quadratic curve from p1 to midpoint using p1 as the control point
      quadraticBezierTo(p1.dx, p1.dy, mid.dx, mid.dy);
    }

    // Draw a line to the last point to complete the path
    final last = points.last;
    lineTo(last.dx, last.dy);

    return this;
  }
}

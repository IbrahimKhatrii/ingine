part of '../../engine.dart';

extension PathExtension on Path {
  Path addSmoothCurve(List<Offset> points) {
    if (points.length < 2) return this;

    moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      final mid = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);

      quadraticBezierTo(p1.dx, p1.dy, mid.dx, mid.dy);
    }

    final last = points.last;
    lineTo(last.dx, last.dy);

    return this;
  }
}

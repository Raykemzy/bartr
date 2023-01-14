import 'package:flutter/material.dart';
import 'dart:math' as math show sqrt;

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);
  final Color color;
  final Animation<double> _animation;
  void circle(Canvas canvas, Rect rect, double value, int index) {
    final double opacity = (0.9 - (value / 4.0)).clamp(0.0, 1.0);
    final double size = rect.width / 1.7;
    final double area = size * (size);
    final double radius =
        math.sqrt(area * (index == 1 ? (value - 0.55) : value - 0.3));
    final Paint paint = Paint()
      ..color = index == 1 ? color : color.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(rect.center, radius, paint);
    // canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 2; wave >= 1; wave--) {
      circle(canvas, rect, wave + _animation.value, wave);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}

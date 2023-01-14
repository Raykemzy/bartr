import 'package:bartr/core/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math show sqrt;

class BartrLoader extends StatefulWidget {
  const BartrLoader({
    Key? key,
    this.color,
    this.size = 35,
  }) : super(key: key);
  final Color? color;
  final double size;

  @override
  State<BartrLoader> createState() => _BartrLoaderState();
}

class _BartrLoaderState extends State<BartrLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: widget.color ?? BartrColors.white,
        animating: true,
      ),
    );
  }
}

class LoadPainter extends CustomPainter {
  LoadPainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);
  final Color color;
  final Animation<double> _animation;
  void circle(Canvas canvas, Rect rect, double value, int index) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color newcolor =
        index.isOdd ? BartrColors.grey : color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);
    final Paint paint = Paint()..color = newcolor;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value, wave);
    }
  }

  @override
  bool shouldRepaint(LoadPainter oldDelegate) => true;
}

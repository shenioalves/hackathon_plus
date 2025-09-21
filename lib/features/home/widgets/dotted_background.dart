import 'package:flutter/material.dart';

class DottedBackground extends StatelessWidget {
  final double dotSpacing;
  final double dotSize;
  final Color dotColor;

  const DottedBackground({
    this.dotSpacing = 50.0,
    this.dotSize = 10.0,
    this.dotColor = const Color(0xFFE0F0FF),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _DottedPainter(dotSpacing, dotSize, dotColor),
    );
  }
}

class _DottedPainter extends CustomPainter {
  final double dotSpacing;
  final double dotSize;
  final Color dotColor;

  _DottedPainter(this.dotSpacing, this.dotSize, this.dotColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = dotColor;
    for (double x = 0; x < size.width; x += dotSpacing) {
      for (double y = 0; y < size.height; y += dotSpacing) {
        canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    this.color = Colors.black,
    this.strokeWidth = 2.0,
    this.dashWidth = 10.0,
    this.dashSpace = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DashedLine({Key? key, this.height = 2, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(color: color, strokeWidth: height),
      size: const Size(double.infinity, 1),
    );
  }
}

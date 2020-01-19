import 'package:flutter/material.dart';

class DrawnBezierCurve extends StatelessWidget {
  const DrawnBezierCurve(
      {@required this.controlPointCount,
      @required this.controlPointHeight,
      @required this.startPointHeight,
      @required this.color})
      : assert(controlPointHeight > 0),
        assert(controlPointHeight < 1.0),
        assert(startPointHeight > 0),
        assert(startPointHeight < 1.0),
        assert(controlPointCount > 0),
        assert(color != null);

  final Color color;
  final int controlPointCount;
  final double controlPointHeight;
  final double startPointHeight;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _BezierPainter(
              color: color,
              controlPointCount: controlPointCount,
              controlPointHeight: controlPointHeight,
              startPointHeight: startPointHeight),
        ),
      ),
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter(
      {@required this.controlPointCount,
      @required this.controlPointHeight,
      @required this.startPointHeight,
      @required this.color})
      : assert(controlPointHeight > 0),
        assert(controlPointHeight < 1.0),
        assert(startPointHeight > 0),
        assert(startPointHeight < 1.0),
        assert(controlPointCount > 0),
        assert(color != null);

  final Color color;
  final int controlPointCount;
  final double controlPointHeight;
  final double startPointHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0;

    final path = Path();

    final height3 = 0.75;
    path.moveTo(-5, size.height * height3);
    path.quadraticBezierTo(size.width * 0.125, size.height * (height3 - 0.1),
        size.width * 0.25, size.height * height3);
    path.quadraticBezierTo(size.width * 0.375, size.height * (height3 + 0.1),
        size.width * 0.5, size.height * height3);
    path.quadraticBezierTo(size.width * 0.625, size.height * (height3 - 0.1),
        size.width * 0.75, size.height * height3);
    path.quadraticBezierTo(size.width * 0.825, size.height * (height3 + 0.1),
        size.width + 5, size.height * height3);
    canvas.drawPath(path, linePaint);

    final linePaint1 = Paint()
      ..color = Color(0xFFe8e413)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0;

    final path2 = Path();
    final height = 0.8;

    path2.moveTo(-5, size.height * height);
    path2.quadraticBezierTo(size.width * 0.125, size.height * (height - 0.5),
        size.width * 0.25, size.height * height);
    path2.quadraticBezierTo(size.width * 0.375, size.height * (height + 0.5),
        size.width * 0.5, size.height * height);
    path2.quadraticBezierTo(size.width * 0.625, size.height * (height - 0.5),
        size.width * 0.75, size.height * height);
    path2.quadraticBezierTo(size.width * 0.825, size.height * (height + 0.5),
        size.width + 5, size.height * height);
    canvas.drawPath(path2, linePaint1);

    final linePaint3 = Paint()
      ..color = Color(0xFF67e3c1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0;

    final path3 = Path();
    final height1 = 0.65;

    path3.moveTo(-5, size.height * height1);
    path3.quadraticBezierTo(size.width * 0.125, size.height * (height1 + 0.5),
        size.width * 0.25, size.height * height1);
    path3.quadraticBezierTo(size.width * 0.375, size.height * (height1 - 0.5),
        size.width * 0.5, size.height * height1);
    path3.quadraticBezierTo(size.width * 0.625, size.height * (height1 + 0.5),
        size.width * 0.75, size.height * height1);
    path3.quadraticBezierTo(size.width * 0.825, size.height * (height1 - 0.5),
        size.width + 5, size.height * height1);
    canvas.drawPath(path3, linePaint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

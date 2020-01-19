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

   var bezierColors = Theme.of(context).brightness == Brightness.light
    ? {
        1 : Color(0xFFBBDEFB),
        2 : Color(0xFF68E3C1),
        3 : Color(0xFFE8E413),
    } :{
        1 : Color(0xFFC99DA2),
        2 : Color(0xFF656680),
        3 : Color(0xFFA38D6F),
    } ;

    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _BezierPainter(
              color: color,
              controlPointCount: controlPointCount,
              controlPointHeight: controlPointHeight,
              startPointHeight: startPointHeight,
              bezierColors: bezierColors),
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
      @required this.color,
      @required this.bezierColors})
      : assert(controlPointHeight > 0),
        assert(controlPointHeight < 1.0),
        assert(startPointHeight > 0),
        assert(startPointHeight < 1.0),
        assert(controlPointCount > 0),
        assert(bezierColors != null),
        assert(color != null);

  final Color color;
  final int controlPointCount;
  final double controlPointHeight;
  final double startPointHeight;

  final Map<int, Color> bezierColors;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = bezierColors[1]
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
      ..color = bezierColors[2]
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
      ..color = bezierColors[3]
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

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
            1: Color(0xFFBBDEFB),
            2: Color(0xFF68E3C1),
            3: Color(0xFFE8E413),
          }
        : {
            1: Color(0xFFC99DA2),
            2: Color(0xFF656680),
            3: Color(0xFFA38D6F),
          };

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
    final smallOffcet = 0.1;
    final middleOffcet = 0.5;
    final strokeWidth = 14.0;

    final firstLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = bezierColors[1]
      ..strokeWidth = strokeWidth;

    final firstLinePath = Path();
    final firstLineHeight = 0.75;

    firstLinePath.moveTo(-5, size.height * firstLineHeight);
    firstLinePath.quadraticBezierTo(
        size.width * 0.125,
        size.height * (firstLineHeight - smallOffcet),
        size.width * 0.25,
        size.height * firstLineHeight);
    firstLinePath.quadraticBezierTo(
        size.width * 0.375,
        size.height * (firstLineHeight + smallOffcet),
        size.width * 0.5,
        size.height * firstLineHeight);
    firstLinePath.quadraticBezierTo(
        size.width * 0.625,
        size.height * (firstLineHeight - smallOffcet),
        size.width * 0.75,
        size.height * firstLineHeight);
    firstLinePath.quadraticBezierTo(
        size.width * 0.825,
        size.height * (firstLineHeight + smallOffcet),
        size.width + 5,
        size.height * firstLineHeight);
    canvas.drawPath(firstLinePath, firstLinePaint);

    final secondLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = bezierColors[2]
      ..strokeWidth = strokeWidth;

    final secondLinePath = Path();
    final secondLineHeight = 0.8;

    secondLinePath.moveTo(-5, size.height * secondLineHeight);
    secondLinePath.quadraticBezierTo(
        size.width * 0.125,
        size.height * (secondLineHeight - middleOffcet) * 1.2,
        size.width * 0.25,
        size.height * secondLineHeight);
    secondLinePath.quadraticBezierTo(
        size.width * 0.375,
        size.height * (secondLineHeight + middleOffcet),
        size.width * 0.5,
        size.height * secondLineHeight);
    secondLinePath.quadraticBezierTo(
        size.width * 0.625,
        size.height * (secondLineHeight - middleOffcet),
        size.width * 0.75,
        size.height * secondLineHeight);
    secondLinePath.quadraticBezierTo(
        size.width * 0.825,
        size.height * (secondLineHeight + middleOffcet),
        size.width + 5,
        size.height * secondLineHeight);
    canvas.drawPath(secondLinePath, secondLinePaint);

    final thirdLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = bezierColors[3]
      ..strokeWidth = strokeWidth;

    final thirdLinePath = Path();
    final thirdLineHeight = 0.65;

    thirdLinePath.moveTo(-5, size.height * thirdLineHeight);
    thirdLinePath.quadraticBezierTo(
        size.width * 0.125,
        size.height * (thirdLineHeight + middleOffcet),
        size.width * 0.25,
        size.height * thirdLineHeight);
    thirdLinePath.quadraticBezierTo(
        size.width * 0.375,
        size.height * (thirdLineHeight - middleOffcet),
        size.width * 0.5,
        size.height * thirdLineHeight);
    thirdLinePath.quadraticBezierTo(
        size.width * 0.625,
        size.height * (thirdLineHeight + middleOffcet),
        size.width * 0.75,
        size.height * thirdLineHeight);
    thirdLinePath.quadraticBezierTo(
        size.width * 0.825,
        size.height * (thirdLineHeight - middleOffcet),
        size.width + 5,
        size.height * thirdLineHeight);
    canvas.drawPath(thirdLinePath, thirdLinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

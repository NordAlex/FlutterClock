import 'package:flutter/material.dart';

import 'drawn_circle.dart';

class DrawnClockFace extends StatelessWidget {
  const DrawnClockFace({this.backgroundColor})
      : assert(backgroundColor != null);
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
              child: CustomPaint(
                  painter: _CircleShadowPainter(
                      color: Colors.black, circleSize: 0.95))),
          DrawnCircle(
            color: backgroundColor,
            circleSize: 0.95,
          ),
        ],
      ),
    );
  }
}

class _CircleShadowPainter extends CustomPainter {
  _CircleShadowPainter({@required this.circleSize, @required this.color})
      : assert(circleSize != null),
        assert(color != null);

  Color color;
  double circleSize;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = (size.shortestSide * circleSize) / 2;
    final center = (Offset.zero & size).center;
    final oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius + 1));

    canvas.drawShadow(oval, Colors.black, 4.0, true);
  }

  @override
  bool shouldRepaint(_CircleShadowPainter oldDelegate) {
    return oldDelegate.circleSize != circleSize || oldDelegate.color != color;
  }
}

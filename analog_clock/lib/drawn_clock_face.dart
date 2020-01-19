import 'package:flutter/material.dart';

import 'drawn_circle.dart';

class DrawnClockFace extends StatelessWidget {
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
            color: Colors.white,
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
    var center = (Offset.zero & size).center;

    final radius = (size.shortestSide * circleSize) / 2;

    Path oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius + 1));

    canvas.drawShadow(oval, color, 4.0, true);
  }

  @override
  bool shouldRepaint(_CircleShadowPainter oldDelegate) {
    return oldDelegate.circleSize != circleSize || oldDelegate.color != color;
  }
}

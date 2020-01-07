// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'hand.dart';

/// A clock hand that is drawn with [CustomPainter]
///
/// The hand's length scales based on the clock's size.
/// This hand is used to build the second and minute hands, and demonstrates
/// building a custom hand.
class DrawnHand extends Hand {
  /// Create a const clock [Hand].
  ///
  /// All of the parameters are required and must not be null.
  const DrawnHand({
    @required Color color,
    @required this.thickness,
    @required double size,
    @required double angleRadians,
  })  : assert(color != null),
        assert(thickness != null),
        assert(size != null),
        assert(angleRadians != null),
        super(
          color: color,
          size: size,
          angleRadians: angleRadians,
        );

  /// How thick the hand should be drawn, in logical pixels.
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _HandPainter(
            handSize: size,
            lineWidth: thickness,
            angleRadians: angleRadians,
            color: color,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _HandPainter extends CustomPainter {
  _HandPainter({
    @required this.handSize,
    @required this.lineWidth,
    @required this.angleRadians,
    @required this.color,
  })  : assert(handSize != null),
        assert(lineWidth != null),
        assert(angleRadians != null),
        assert(color != null),
        assert(handSize >= 0.0),
        assert(handSize <= 1.0);

  double handSize;
  double lineWidth;
  double angleRadians;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var center = (Offset.zero & size).center;

    // We want to start at the top, not at the x-axis, so add pi/2.
    final angle = angleRadians - math.pi / 2.0;
    final length = size.shortestSide * 0.5 * handSize;

    final angle2 = angle + math.pi;

    // final position2 = center + Offset(math.cos(angle2), math.sin(angle2)) * (length * 0.05);
    final position2 = center + Offset(math.cos(angle2), math.sin(angle2)) * 20;


    final position = center + Offset(math.cos(angle), math.sin(angle)) * length;
    // final linePaint = Paint()
      // ..color = color
      // ..strokeWidth = lineWidth
      // ..strokeCap = StrokeCap.square;

 Paint linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    Path path = Path();
    path.moveTo(position2.dx, position2.dy);
    path.lineTo(position.dx, position.dy);
    // Draws a line from left top corner to right bottom
    //path.lineTo(size.width, size.height);

    canvas.drawPath(path, linePaint);

    final offcet = lineWidth * 0.86;
    final shadowPath = Path();
    shadowPath.moveTo(position2.dx-offcet, position2.dy-offcet);

    shadowPath.lineTo(position.dx, position.dy);
    shadowPath.lineTo(position.dx+offcet, position.dy+offcet);


    shadowPath.lineTo(position2.dx+offcet, position2.dy+offcet);
    // path.moveTo(0, 0);
    // path.lineTo(150, 150);
    // path.lineTo(100, 150);

   
    canvas.drawShadow(shadowPath, Colors.black, 4.0, true);
  }

  @override
  bool shouldRepaint(_HandPainter oldDelegate) {
    return oldDelegate.handSize != handSize ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.angleRadians != angleRadians ||
        oldDelegate.color != color;
  }
}

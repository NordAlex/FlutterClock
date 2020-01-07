// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

class DrawnCircle extends StatelessWidget{

  const DrawnCircle({
    @required this.color,
    @required this.radius
  })  : assert(color != null),
        assert(radius != null);


  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _CirclePainter(
            color: color,
            radius: radius,

          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _CirclePainter extends CustomPainter {
  _CirclePainter({
    @required this.color,
    @required this.radius,
  })  : assert(radius != null),
        assert(color != null);

  Color color;
  double radius;

  @override
  void paint(Canvas canvas, Size size) {
    var center = (Offset.zero & size).center;

    final linePaint = Paint()
      ..color = color;

    canvas.drawCircle(center, radius, linePaint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return 
        oldDelegate.radius != radius ||
        oldDelegate.color != color;
  }
}

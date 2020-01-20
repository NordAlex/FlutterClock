// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class DrawnCircle extends StatelessWidget{

  const DrawnCircle({
    @required this.color,
    @required this.circleSize
  })  : assert(color != null),
        assert(circleSize >= 0.0),
        assert(circleSize <= 1.0);


  final double circleSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _CirclePainter(
            color: color,
            circleSize: circleSize,
          ),
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter({
    @required this.color,
    @required this.circleSize,
  })  : assert(circleSize != null),
        assert(color != null);

  Color color;
  double circleSize;

  @override
  void paint(Canvas canvas, Size size) {

    final radius = (size.shortestSide * circleSize) / 2;
    final center = (Offset.zero & size).center;
       
    final linePaint = Paint()
      ..color = color;
    
    canvas.drawCircle(center, radius, linePaint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return 
        oldDelegate.circleSize != circleSize ||
        oldDelegate.color != color;
  }
}

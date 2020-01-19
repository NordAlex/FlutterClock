// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:analog_clock/drawn_circle.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'drawn_bezier_curve.dart';
import 'drawn_clock_face.dart';
import 'drawn_hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  var _temperature = '';
  var _condition = '';
  var _location = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();

    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            primaryColor: Color(0xFFFFFFFF),
            backgroundColor: Color(0xFFE8E8E8),
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.black, displayColor: Colors.black))
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFFCDCDCD),
            backgroundColor: Color(0xFF3C4043),
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.grey, displayColor: Colors.grey));

    final time = DateFormat.Hms().format(DateTime.now());
    final weatherInfo = DefaultTextStyle(
      style: customTheme.textTheme.display4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _location,
          ),
          Text(
            _temperature,
          ),
          Text(
            _condition,
          ),
        ],
      ),
    );

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.5, 1],
                colors: [customTheme.backgroundColor, customTheme.primaryColor])),
        child: Stack(children: [
          DrawnBezierCurve(
            startPointHeight: 0.9,
            controlPointCount: 4,
            controlPointHeight: 0.1,
            color: Colors.red,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: weatherInfo,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: Container(
                        child: Stack(
                          children: [
                            DrawnClockFace(
                              backgroundColor: customTheme.primaryColor,
                            ),
                            DrawnCircle(
                              color: customTheme.primaryColor,
                              circleSize: 0.06,
                            ),
                            DrawnCircle(
                              color: Colors.black,
                              circleSize: 0.05,
                            ),
                            DrawnCircle(
                              color: customTheme.primaryColor,
                              circleSize: 0.04,
                            ),
                            DrawnHand(
                              color: customTheme.highlightColor,
                              thickness: 16,
                              size: 0.9,
                              angleRadians: _now.minute * radiansPerTick,
                            ),
                            DrawnHand(
                              color: customTheme.highlightColor,
                              thickness: 16,
                              size: 0.5,
                              angleRadians: _now.hour * radiansPerHour +
                                  (_now.minute / 60) * radiansPerHour,
                            ),
                            DrawnCircle(
                              color: customTheme.primaryColor,
                              circleSize: 0.039,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

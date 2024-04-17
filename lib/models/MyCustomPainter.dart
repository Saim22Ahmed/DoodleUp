import 'package:doodle_up/models/touch_points.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.pointsList});

  List<TouchPoints> pointsList;
  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

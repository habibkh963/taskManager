import 'dart:ui';

import 'package:flutter/material.dart';

class Paint5 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = Colors.indigoAccent
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.quadraticBezierTo(size.width * 0.0018750, size.height * 0.6266667,
        size.width * 0.0025000, size.height * 0.5000000);
    path_0.quadraticBezierTo(size.width * 0.3775000, size.height * 0.8400000,
        size.width * 1.0025000, size.height);

    canvas.drawPath(path_0, paint_fill_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

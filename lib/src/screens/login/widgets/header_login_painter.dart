import 'package:asiscumbre/src/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderLoginPainter extends CustomPainter {
  void paint(Canvas canvas, Size size){
    final paint = new Paint();
    paint.color = Colors.deepOrange[100];
    paint.style = PaintingStyle.fill;

    final path = new Path();
    path.lineTo(0, size.height * 1.0);
    path.lineTo( size.width * 0.2, size.height * 0.8);
    path.lineTo( size.width, size.height * 1.0);
    path.lineTo( size.width, 0);

    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}
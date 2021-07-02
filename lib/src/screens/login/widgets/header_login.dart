import 'package:asiscumbre/src/screens/login/widgets/header_login_painter.dart';
import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: double.infinity,
      child: CustomPaint(painter: HeaderLoginPainter(),),
    );
  }
}
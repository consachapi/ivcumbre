import 'package:asiscumbre/src/utils/images.dart';
import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 55.0),
      child: Column(
        children: [
          Image.asset(LOGO_PRINCIPAL, width: 240.0,),
          SizedBox(height: 15.0, width: double.infinity,)
        ],
      ),
    );
  }
}
import 'package:asiscumbre/src/preferences/config_preferences.dart';
import 'package:flutter/material.dart';

class TextOrganizacion extends StatelessWidget {

  const TextOrganizacion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = new ConfigPreferences();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      alignment: Alignment.center,
      child: Text('\u00a9${prefs.anio}, ${prefs.organizacion}.', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),),
    );
  }
}
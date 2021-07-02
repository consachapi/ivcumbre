import 'package:asiscumbre/src/screens/condition/page/condicion_page.dart';
import 'package:flutter/material.dart';

class ButtonCondicion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CondicionPage())), 
      child: Text('Términos y condiciones de uso.', style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.bold)),
    );
  }
}
import 'package:asiscumbre/src/utils/colors.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Aviso', style: TextStyle(color: colorPrimary, fontSize: 15.0, fontWeight: FontWeight.bold)),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Aceptar', 
              style: TextStyle(color: colorPrimary, fontSize: 15.0, fontWeight: FontWeight.bold)
            )
          )
        ],
      );
    }
  );
}
import 'package:asiscumbre/src/providers/provider.dart';
import 'package:asiscumbre/src/screens/home/page/home_page.dart';
import 'package:asiscumbre/src/screens/login/page/login_page.dart';
import 'package:asiscumbre/src/utils/colors.dart';
import 'package:flutter/material.dart';

class AppIVCumbre extends StatelessWidget {
  const AppIVCumbre({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: colorPrimary
        ),
        title: 'Registro de Actividades de Proyectos y Obras',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}
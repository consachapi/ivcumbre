import 'package:asiscumbre/src/blocs/login_blocs.dart';
import 'package:asiscumbre/src/providers/auth_provider.dart';
import 'package:asiscumbre/src/providers/provider.dart';
import 'package:asiscumbre/src/screens/login/widgets/button_condicion.dart';
import 'package:asiscumbre/src/screens/login/widgets/header_login.dart';
import 'package:asiscumbre/src/screens/login/widgets/header_logo.dart';
import 'package:asiscumbre/src/screens/login/widgets/text_organizacion.dart';
import 'package:asiscumbre/src/utils/colors.dart';
import 'package:asiscumbre/src/utils/utils.dart';
import 'package:asiscumbre/src/utils/widgets/loagind_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authProvider = AuthProvider();
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HeaderLogin(),
          HeaderLogo(),
          _loginForm(context)
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context){
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(child: Container(height: 220.0,)),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 4.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                SizedBox(height: 30.0),
                _textUsuario(bloc),
                SizedBox(height: 30.0,),
                _textPassword(bloc),
                SizedBox(height: 30.0,),
                _crearButton(bloc),
              ],
            ),
          ),
          ButtonCondicion(),
          SizedBox(height: 10.0,),
          TextOrganizacion(),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }

  Widget _textUsuario(LoginBlocs bloc){
    return StreamBuilder(
      stream: bloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0)
              ),
              prefixIcon: Icon(Icons.person, color: Colors.red,),
              labelText: 'Usuario',
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            onChanged: bloc.changeUsuario,
          ),
        );
      }
    );
  }

  Widget _textPassword(LoginBlocs bloc){
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              prefixIcon: Icon(Icons.vpn_key, color: Colors.red,),
              labelText: 'Contraseña',
              errorText: snapshot.error,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off
                ),
                onPressed: (){
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearButton(LoginBlocs bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 104.0, vertical: 17.0),
              child: Text('Ingresar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)
            ),
            elevation: 0.0,
            color: colorPrimary,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? (){
              LoadingPage loadingPage = new LoadingPage(context);
              _login(bloc, context, loadingPage);
            } : null,
          )
        );
      }
    );
  }

  _login(LoginBlocs bloc,  BuildContext context, LoadingPage loadingPage) async {
      loadingPage.show();
      Map resp = await authProvider.login(bloc.usuario, bloc.password);
      if(resp['success']){
        loadingPage.close();
        print(resp);
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        loadingPage.close();
        showAlertDialog(context, 'El usuario o contraseña es incorrecta');
      }
  }


}
import 'package:asiscumbre/src/blocs/login_blocs.dart';
import 'package:flutter/cupertino.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;
  final loginBlocs = LoginBlocs();

  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      return Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child}): super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static LoginBlocs of (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBlocs;
  }
  
}
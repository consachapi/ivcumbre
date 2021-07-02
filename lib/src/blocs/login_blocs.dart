import 'package:asiscumbre/src/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBlocs extends LoginValidators {
  final _usuarioController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get usuarioStream => _usuarioController.stream.transform(validarUsuario);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<bool> get formValidStream => Observable.combineLatest2(usuarioStream, passwordStream, (e, p) => true );

  Function(String) get changeUsuario => _usuarioController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get usuario => _usuarioController.value;
  String get password => _passwordController.value;

  dispose(){
    _usuarioController?.close();
    _passwordController?.close();
  }
  
}
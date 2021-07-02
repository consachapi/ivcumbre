import 'dart:async';

abstract class LoginValidators {
  final validarUsuario = StreamTransformer<String, String>.fromHandlers(
    handleData: (usuario, sink){
      if(usuario.length >= 3){
        sink.add(usuario.trim());
      } else {
        sink.addError('Ingrese usuario.');
      }
    }
  );
    
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length >= 4){
        sink.add(password.trim());
      } else {
        sink.addError('El mínimo de caracteres es 4.');
      }
    }
  );
}
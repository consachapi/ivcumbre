import 'package:shared_preferences/shared_preferences.dart';

class ConfigPreferences {
  final String _name = 'IVCumbre';
  final String _version = '1.0.0';
  final String _autor = 'consachapi@gmail.com';
  final String _organizacion = 'Gobierno Regional de Cusco';
  final String _anio = '2021';
  final String _ejec = '789';
  final bool _politica = false;
  final String _oauth = 'http://oauth.regioncusco.gob.pe/auth/realms/sipac/protocol/openid-connect/token';
  final String _api = 'http://sipac.regioncusco.gob.pe/api/ivcumbre';

  static final ConfigPreferences _instancia = new ConfigPreferences._internal();

  SharedPreferences _prefs;

  factory ConfigPreferences(){
    return _instancia;
  }

  ConfigPreferences._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
    this._prefs.setString('__name__', _name);
    this._prefs.setString('__version__', _version);
    this._prefs.setString('__autor__', _autor);
    this._prefs.setString('__organizacion__', _organizacion);
    this._prefs.setString('__anio__', _anio);
    this._prefs.setString('__ejec__', _ejec);
    this._prefs.setBool('__politica__', _politica);
    this._prefs.setString('__oauth__', _oauth);
    this._prefs.setString('__api__', _api);
  }

  get name {
    return _prefs.getString('__name__');
  }

  get organizacion {
    return _prefs.getString('__organizacion__');
  }

  get anio {
    return _prefs.getString('__anio__');
  }
  
  get ejecutor {
    return _prefs.getString('__ejec__');
  }

  get politica {
    return _prefs.getBool('__politica__');
  }

  set politica(bool value){
    _prefs.setBool('__politica__', value);
  }

  get oauth {
    return _prefs.getString('__oauth__');
  }

  get api {
    return _prefs.getString('__api__');
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value){
    _prefs.setString('token', value);
  }
}
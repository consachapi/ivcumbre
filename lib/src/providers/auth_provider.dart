import 'package:asiscumbre/src/preferences/config_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider {
  final prefs = ConfigPreferences();
  Future<Map<String, dynamic>> login(String usuario, String password) async {
    final authData = {
      'username': usuario,
      'password': password,
      'grant_type': 'password',
      'client_id': 'sipac_mobil'
    };
    final resp = await http.post(
      prefs.oauth,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      encoding: Encoding.getByName("utf-8"),
      body: authData
    );

    Map<String, dynamic> decodeResponse = json.decode(resp.body);
    bool verify = false;
    if(decodeResponse.containsKey('access_token')){
      prefs.token = decodeResponse['access_token'];
      return {'success': true, 'verify': verify};
    }
    return {'success': false, 'mensaje': 'error'};
  }
}
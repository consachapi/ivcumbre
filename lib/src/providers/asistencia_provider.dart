import 'package:asiscumbre/src/models/asistencia_model.dart';
import 'package:asiscumbre/src/preferences/config_preferences.dart';
import 'package:asiscumbre/src/utils/api_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class AsistenciaProvider {
  final prefs = ConfigPreferences();

  Future<ApiResponse<AsistenciaModel>> registrarAsistencia(String ndocumento) async {
    try{
      final resp = await http.post(
        '${prefs.api}/asistencia/registrar/' + ndocumento,
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ prefs.token }',
        },
      );
      if(resp.statusCode == 201){
        final decodeResponse = json.decode(resp.body);
        if(decodeResponse['success']){
          return ApiResponse<AsistenciaModel>(
            true,
            AsistenciaModel.fromJsonMap(decodeResponse['data'][0]),
            message: "",
            status: resp.statusCode
          );
        }
        return ApiResponse<AsistenciaModel>(
          false,
          null,
          message: decodeResponse['msg'],
          status: resp.statusCode
        );
      } else {
        ApiResponse<AsistenciaModel>(
          false,
          null,
          message: 'Error al registrar asistencia. Intente mas tarde.',
          status: resp.statusCode
        );
      }
    } on SocketException {
      return ApiResponse<AsistenciaModel>(
        false,
        null,
        message: "No se puede conectar a Internet. Inténtelo de nuevo en un momento.",
      );
    }
  }
}
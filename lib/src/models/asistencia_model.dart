import 'package:asiscumbre/src/models/participante_model.dart';

class AsistenciaModel {
  int id;
  ParticipanteModel participante;
  String fechaRegistro;

  AsistenciaModel({this.id, this.participante, this.fechaRegistro});

  AsistenciaModel.fromJsonMap(Map<String, dynamic> json){
    id = json['id'];
    participante = ParticipanteModel.fromJsonMap(json['participante']);
    fechaRegistro = json['fechaRegistro'];
  }
}
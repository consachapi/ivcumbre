class ParticipanteModel {
  String ndocumento;
  String nombres;
  String cargo;
  String ciudad;

  ParticipanteModel({
    this.ndocumento,
    this.nombres,
    this.cargo,
    this.ciudad
  });

  ParticipanteModel.fromJsonMap(Map<String, dynamic> json){
    ndocumento = json['ndocumento'];
    nombres = json['nombres'];
    cargo = json['cargo'];
    ciudad = json['ciudad'];
  }

}
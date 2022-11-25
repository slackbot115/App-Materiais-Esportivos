class ReservaModel {
  int? id;
  String? dia;
  String? horaInicio;
  String? horaTermino;

  ReservaModel(
      {this.id,
      this.dia,
      this.horaInicio,
      this.horaTermino});

  ReservaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dia = json['data'];
    horaInicio = json['horaInicio'];
    horaTermino = json['horaTermino'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['data'] = dia;
    data['horaInicio'] = horaInicio;
    data['horaTermino'] = horaTermino;
    return data;
  }
}

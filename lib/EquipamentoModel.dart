class EquipamentoModel {
  int? id;
  String? nome;
  String? tipo;
  int? quantidadeTotal;
  int? quantidadeDisponivel;

  EquipamentoModel(
      {this.id,
      this.nome,
      this.tipo,
      this.quantidadeTotal,
      this.quantidadeDisponivel});

  EquipamentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    tipo = json['tipo'];
    quantidadeTotal = json['quantidadeTotal'];
    quantidadeDisponivel = json['quantidadeDisponivel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nome'] = nome;
    data['tipo'] = tipo;
    data['quantidadeTotal'] = quantidadeTotal;
    data['quantidadeDisponivel'] = quantidadeDisponivel;
    return data;
  }
}

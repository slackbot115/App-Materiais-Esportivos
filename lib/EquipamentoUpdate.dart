import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:materiais_esportivos_app/EquipamentoModel.dart';

Future<EquipamentoModel> updateEquipamento(
    EquipamentoModel equipamentoModel, int? valorQuantidade) async {
  final response = await http.put(
    Uri.parse(
        'https://apiequipamentos.herokuapp.com/equipamento/${equipamentoModel.id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, dynamic>{
        "nome": equipamentoModel.nome,
        "tipo": equipamentoModel.tipo,
        "quantidadeTotal": equipamentoModel.quantidadeTotal,
        "quantidadeDisponivel":
            (equipamentoModel.quantidadeDisponivel! + valorQuantidade!)
      },
    ),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EquipamentoModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

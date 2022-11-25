import 'dart:convert';
import 'package:http/http.dart' as http;

import 'EquipamentoModel.dart';

Future<List<EquipamentoModel>> fetchEquipamentoList() async {
  final response = await http.get(
    Uri.parse('https://apiequipamentos.herokuapp.com/equipamento'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => EquipamentoModel.fromJson(data)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Praga');
  }
}

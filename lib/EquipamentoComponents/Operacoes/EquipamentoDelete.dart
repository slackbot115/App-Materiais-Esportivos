import 'package:http/http.dart' as http;
import 'dart:async';

Future<http.Response> deleteEquipamento(int? id) async {
  final response = await http.delete(
    Uri.parse('https://apiequipamentos.herokuapp.com/equipamento/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 204) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

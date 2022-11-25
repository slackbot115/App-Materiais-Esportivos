import 'dart:convert';
import 'package:http/http.dart' as http;

import 'ReservaModel.dart';

Future<List<ReservaModel>> fetchReservaList() async {
  final response = await http.get(
    Uri.parse('https://api-quadra-ifsc.herokuapp.com/reserva'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => ReservaModel.fromJson(data)).toList();
  } else {
    // If the server did not r  eturn a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Praga');
  }
}

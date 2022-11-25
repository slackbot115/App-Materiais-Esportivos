import 'package:flutter/material.dart';
import '../main.dart';
import 'Weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Weather> fetchWeather() async {
  final response = await http.get(Uri.parse(
      'https://weather.contrateumdev.com.br/api/weather/city/?city=Lages'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather');
  }
}

class ClimaTela extends StatefulWidget {
  const ClimaTela({Key? key}) : super(key: key);

  @override
  _ClimaTelaState createState() => _ClimaTelaState();
}

class _ClimaTelaState extends State<ClimaTela> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exibir Clima',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          actions: [],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            ),
          ),
          title: const Text('Clima atual de Lages'),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: FutureBuilder<Weather>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!.name,
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: SizedBox(
                            width: 400,
                            height: 200,
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Text(
                                      snapshot.data!.weatherElement[0]
                                          .weatherDescription
                                          .toUpperCase(),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: Colors.grey,
                                        width: 80,
                                        height: 80,
                                        child: Image.network(
                                          'https://openweathermap.org/img/wn/${snapshot.data!.weatherElement[0].weatherIcon}@2x.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${snapshot.data!.weatherTemperature.mainTemp} °C',
                                          ),
                                          Text(
                                            'max: ${snapshot.data!.weatherTemperature.tempMax} °C',
                                          ),
                                          Text(
                                            'min: ${snapshot.data!.weatherTemperature.tempMin} °C',
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Humidade: ${snapshot.data!.weatherTemperature.humidity}',
                                          ),
                                          Text(
                                            'Vento: ${snapshot.data!.wind.speed} KM/h',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

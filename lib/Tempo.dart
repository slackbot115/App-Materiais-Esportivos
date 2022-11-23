import 'package:flutter/material.dart';

import 'WeatherComponents/Weather.dart';
// import 'package:google_fonts/google_fonts.dart';

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

class Tempo extends StatefulWidget {
  const Tempo({Key? key}) : super(key: key);

  @override
  _TempoState createState() => _TempoState();
}

class _TempoState extends State<Tempo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
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
                        // style: FlutterFlowTheme.of(context).title1,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Text(
                                    snapshot.data!.weatherElement[0]
                                        .weatherDescription,
                                    // style:
                                    //     FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
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
                                          // style: FlutterFlowTheme.of(context)
                                          //     .bodyText1,
                                        ),
                                        Text(
                                          'max: ${snapshot.data!.weatherTemperature.tempMax} °C',
                                          // style: FlutterFlowTheme.of(context)
                                          //     .bodyText1,
                                        ),
                                        Text(
                                          'min: ${snapshot.data!.weatherTemperature.tempMin} °C',
                                          // style: FlutterFlowTheme.of(context)
                                          //     .bodyText1,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Humidade: ${snapshot.data!.weatherTemperature.humidity}',
                                          // style: FlutterFlowTheme.of(context)
                                          //     .bodyText1,
                                        ),
                                        Text(
                                          'Vento: ${snapshot.data!.wind.speed} KM/h',
                                          // style: FlutterFlowTheme.of(context)
                                          //     .bodyText1,
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
    );
  }
}

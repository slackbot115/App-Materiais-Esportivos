import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class Weather {
  final int id;
  final String name;
  final List<WeatherElement> weatherElement;
  final Wind wind;
  final WeatherTemperature weatherTemperature;

  const Weather(
      {required this.id,
      required this.name,
      required this.weatherElement,
      required this.wind,
      required this.weatherTemperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      name: json['name'],
      weatherElement: List<WeatherElement>.from(
          json["weather"].map((x) => WeatherElement.fromJson(x))),
      wind: Wind.fromJson(json["wind"]),
      weatherTemperature: WeatherTemperature.fromJson(json["main"]),
    );
  }
}

class WeatherElement {
  WeatherElement(
      {required this.mainWeather,
      required this.weatherDescription,
      required this.weatherIcon});

  String mainWeather;
  String weatherDescription;
  String weatherIcon;

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
      mainWeather: json["main"],
      weatherDescription: json["description"],
      weatherIcon: json["icon"]);

  Map<String, dynamic> toJson() => {
        "main": mainWeather,
        "description": weatherDescription,
        "icon": weatherIcon
      };
}

class Wind {
  Wind({
    required this.speed,
  });

  double speed;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
      };
}

class WeatherTemperature {
  WeatherTemperature({
    required this.mainTemp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  double mainTemp;
  double tempMin;
  double tempMax;
  int humidity;

  factory WeatherTemperature.fromJson(Map<String, dynamic> json) =>
      WeatherTemperature(
        mainTemp: json["temp"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": mainTemp,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "humidity": humidity,
      };
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Weather>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: SizedBox(
                    width: 700,
                    height: 300,
                    child: Center(
                        child: Column(
                      children: [
                        Text("Cidade: ${snapshot.data!.name}"),
                        Text(
                            "Clima: ${snapshot.data!.weatherElement[0].mainWeather}"),
                        Text(
                            "Descrição: ${snapshot.data!.weatherElement[0].weatherDescription}"),
                        Text(
                            "Temperatura atual: ${snapshot.data!.weatherTemperature.mainTemp} °C"),
                        Text(
                            "Temperatura mínima: ${snapshot.data!.weatherTemperature.tempMin} °C"),
                        Text(
                            "Temperatura máxima: ${snapshot.data!.weatherTemperature.tempMax} °C"),
                        Text(
                            "Humidade: ${snapshot.data!.weatherTemperature.humidity}"),
                        Text("Vento: ${snapshot.data!.wind.speed} KM/h"),
                        FutureBuilder(
                            future: futureWeather,
                            builder: (context, snapshot) {
                              return Image.network(
                                  "https://openweathermap.org/img/wn/${snapshot.data!.weatherElement[0].weatherIcon}.png");
                            })
                      ],
                    )),
                  ),
                );
                // return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

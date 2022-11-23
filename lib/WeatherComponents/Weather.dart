import 'package:flutter/material.dart';

import 'WeatherElements.dart';
import 'WeatherTemperature.dart';
import 'Wind.dart';

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

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    Key? key,
    required this.futureWeather,
  }) : super(key: key);

  final Future<Weather> futureWeather;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureWeather,
        builder: (context, snapshot) {
          return Image.network(
              "https://openweathermap.org/img/wn/${snapshot.data!.weatherElement[0].weatherIcon}.png");
        });
  }
}

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

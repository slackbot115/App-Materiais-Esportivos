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

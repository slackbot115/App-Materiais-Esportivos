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

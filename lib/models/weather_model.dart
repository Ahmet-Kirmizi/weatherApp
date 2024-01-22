class Weather {
  final String cityName;
  final int temperature;
  final double humidity;
  final String mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.humidity,
      required this.mainCondition});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'] ?? "N/A",
        temperature: (json['main']['temp'] as double?)?.toInt() ?? 0,
        humidity: json['main']['humidity'].toDouble() ?? 0.0,
        mainCondition: json['weather'][0]['main']);
  }
}

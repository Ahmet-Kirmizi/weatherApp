import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weathercyp/models/weather_model.dart';
import 'package:weathercyp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  final _weatherService = WeatherService('4722cf98df244fd69cb180229255a46e');
  Weather? _weather;

  Future<Weather?> _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      return weather;
    } catch (e) {
      print(e);
      return null;
    }
  }
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()){
      case 'clouds':
        return "assets/cloudy.json";
      case 'mist':
        return 'assets/fog.json';
      case 'smoke':
        return 'assets/fog.json';
      case 'haze':
        return 'assets/fog.json';
      case 'fog':
        return 'assets/fog.json';
      case 'rain':
        return "assets/rainy.json";
      case 'drizzle':
        return "assets/rainy.json";
      case 'shower rain':
        return "assets/rainy.json";
      case 'thunder':
        return "assets/thunder.json";
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }
  String getWeatherCondition(String? mainCondition){
    if(mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()){
      case 'clouds':
        return "Cloudy";
      case 'mist':
        return 'Mist';
      case 'smoke':
        return 'Smoke';
      case 'haze':
        return 'Haze';
      case 'fog':
        return 'Fogy';
      case 'rain':
        return "Rainy";
      case 'drizzle':
        return "Drizzle";
      case 'shower rain':
        return "Shower Rain";
      case 'thunder':
        return "Thunder";
      case 'clear':
        return 'Clear';
      default:
        return 'Clear';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _fetchWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final weather = snapshot.data as Weather?;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(weather?.cityName ?? "loading city",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                  Lottie.asset(getWeatherAnimation(weather?.mainCondition.toLowerCase())),
                  Text(getWeatherCondition(weather?.mainCondition.toLowerCase() ?? "Loading Weather Condition"),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  Text('${weather?.temperature.toString()}°C',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),


                ],
              );
            }
          },
        ),
      ),
    );
  }
}

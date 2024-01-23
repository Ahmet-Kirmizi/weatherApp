import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weathercyp/models/weather_model.dart';
import 'package:weathercyp/services/weather_service.dart';

class SearchBar extends StatelessWidget {
  final MaterialStateProperty<Color?>? shadowColor;

  const SearchBar({Key? key, this.shadowColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color:
                shadowColor?.resolve(<MaterialState>{}) ?? Colors.transparent,
            blurRadius: 10,
          ),
        ],
      ),
      child: TextField(
          // Your TextField properties
          ),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  final _weatherService = WeatherService('4722cf98df244fd69cb180229255a46e');

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

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
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

  String getWeatherCondition(String? mainCondition) {
    if (mainCondition == null) return 'Clear';

    switch (mainCondition.toLowerCase()) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade100,
        // Set background color to transparent
        onPressed: () {
          // Add your action when the button is pressed
          print('Floating Action Button Pressed!');
        },
        child: Icon(
            Icons.search), // You can change the icon based on your requirements
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100,
              Colors.blue.shade200,
              Colors.blue.shade300,
              Colors.blue.shade500,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: Center(
          child: FutureBuilder(
            future: _fetchWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final weather = snapshot.data as Weather?;
                return Padding(
                  padding: EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: Column(
                    children: [
                      // SearchBar(
                      //   shadowColor: MaterialStateProperty.resolveWith(
                      //     (states) {
                      //       if (states.contains(MaterialState.pressed)) {
                      //         return Colors
                      //             .blue.shade800; // Change color when pressed
                      //       } else {
                      //         return Colors.transparent; // Default color
                      //       }
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${weather?.temperature.toString()}°',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 80.0),
                          ),
                          SizedBox(height: 10),
                          Text(
                            weather?.cityName ?? "loading city",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30.0),
                          ),
                          Lottie.asset(getWeatherAnimation(
                              weather?.mainCondition.toLowerCase())),
                          Text(
                            getWeatherCondition(
                                weather?.mainCondition.toLowerCase() ??
                                    "Loading Weather Condition"),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

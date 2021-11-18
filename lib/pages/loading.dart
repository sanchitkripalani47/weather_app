import 'package:flutter/material.dart';

// Import spinkit package for loading animation
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Import helper class to fetch data
import 'package:weather_app/services/get_location.dart';

// Import to get the weather data
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/pages/home.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Location location = Location();

  Future<void> getLocationData() async {
    location = Location();
    await location.determinePosition();

    if (location.latitude == 181 || location.longitude == 181){
    }
  }

  Future<void> getWeather() async {
    await getLocationData();

    Weather weather = Weather(locationData: location);
    await weather.getTemperature();
    await weather.setWeatherUI();

    Navigator.pushReplacement(context,
      MaterialPageRoute(
          builder: (context) {
            return Home(weatherData: weather);
          }
      )
    );

  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(136, 224, 239, 1),

      body: Center(
        child: SpinKitRipple(
          color: Color.fromRGBO(22, 30, 84, 1),
          size: 100.0,
          duration: Duration(milliseconds: 1500),
        ),
      ),
    );
  }
}



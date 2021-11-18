import 'package:flutter/material.dart';
import 'package:weather_app/services/get_location.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:weather_app/constants.dart';

const apiKey = "********************************";


class WeatherUi {
  Icon weatherIcon;
  AssetImage bgImage;
  Color bgColor;

  WeatherUi ({required this.weatherIcon, required this.bgImage, required this.bgColor});
}

class Weather {

  Location locationData;
  double temp = 100;
  int currentCondition = 0;
  String cityName = '';

  WeatherUi currentUi = WeatherUi(weatherIcon: sun, bgImage: SunnyImage, bgColor: Colors.cyan);

  Weather ( { required this.locationData } );

  Future<void> getTemperature() async {

    http.Response response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      var currentTemp = jsonDecode(response.body);

      try {
        temp = currentTemp['main']['temp'];
        currentCondition = currentTemp['weather'][0]['id'];
        cityName = currentTemp['name'];
      }
      catch (e) {
          Fluttertoast.showToast(
              msg: "Error!",
              toastLength: Toast.LENGTH_SHORT
          );
      }
    }
    else {
        Fluttertoast.showToast(
            msg: "Could not fetch the data",
            toastLength: Toast.LENGTH_SHORT
        );
    }
  }


  Future<void> setWeatherUI() async {

    await getTemperature();

    Icon currentIcon;
    AssetImage currentImage = SunnyImage;
    Color currentColor;

    if (currentCondition < 600) {
      currentIcon = cloudyRain;
      currentImage = CloudImage;
      currentColor = const Color.fromRGBO(31, 95, 195, 1);
    }
    else if (currentCondition < 700) {
      currentIcon = snowflake;
      currentColor = Colors.white70;
    }
    else if (currentCondition == 800) {
      currentIcon = sun;
      currentImage = SunnyImage;
      currentColor = Colors.cyan;
    }
    else {
      currentIcon = cloud;
      currentImage = CloudImage;
      currentColor = const Color.fromRGBO(31, 95, 195, 1);
    }

    var time = DateTime.now().toLocal();

    print(time.hour);

    if (time.hour < 6 || time.hour > 20) {
      currentImage = NightImage;
      currentIcon = moon;
      currentColor = Colors.deepPurpleAccent;
    }
    else if (currentCondition >= 630 && currentCondition < 700) {
      currentImage = SnowImage;
      currentColor = Colors.white70;
    }

    currentUi = WeatherUi(weatherIcon: currentIcon, bgImage: currentImage, bgColor: currentColor);

  }

}

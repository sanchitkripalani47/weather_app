import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/weather.dart';

class Home extends StatefulWidget {
  final Weather weatherData;

  Home({required this.weatherData});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int temperature = 100;
  Icon weatherIcon = Icon(FontAwesomeIcons.sun);
  AssetImage bgImage = AssetImage('assets/sunny.png');
  String cityName = '';
  Color bgColor = Colors.cyan;

  void updateTempData (Weather weather) {
    setState(() {
      temperature = weather.temp.round();
      cityName = weather.cityName;
      weather.setWeatherUI();

      bgImage = weather.currentUi.bgImage;
      weatherIcon = weather.currentUi.weatherIcon;
      bgColor = weather.currentUi.bgColor;
    });
  }

  @override
  void initState() {
    super.initState();
    updateTempData(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: bgColor,

      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: bgImage,
              fit: BoxFit.cover
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),

              weatherIcon,

              const SizedBox(height: 5),

              Text(
                  cityName,
                  style: GoogleFonts.catamaran(
                      textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
              ),

              // const SizedBox(height: 10),

              Text(
                '$temperature\u00B0C',
                style: GoogleFonts.righteous(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

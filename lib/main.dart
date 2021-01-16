import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';
import 'weather_forecast/daily_forecast/daily_forecast_screen.dart';
import 'weather_forecast/hourly_forecast/hourly_forecast_screen.dart';
import 'weather_forecast/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),

      blocs: [
        Bloc((i) => WeatherDisplayModeTitleBloc()),
        Bloc((i) => WeatherDisplayModeScreenBloc()),
        Bloc((i) => HourlyWeatherBloc()),
        Bloc((i) => DailyWeatherBloc()),
      ],
    );
  }
}
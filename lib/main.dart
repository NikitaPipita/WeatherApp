import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'blocs/main_screen_blocs/app_bar_title_bloc.dart';
import 'blocs/main_screen_blocs/daily_weather_bloc.dart';
import 'blocs/main_screen_blocs/hourly_weather_bloc.dart';
import 'blocs/main_screen_blocs/weather_display_mode_bloc.dart';
import 'screens/splash_screen/splash_screen.dart';

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
        Bloc((i) => AppBarTitleBloc()),
        Bloc((i) => WeatherDisplayModeBloc()),
        Bloc((i) => HourlyWeatherBloc()),
        Bloc((i) => DailyWeatherBloc()),
      ],
    );
  }
}
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'blocs/main_screen_blocs/app_bar_title_bloc.dart';
import 'blocs/main_screen_blocs/city_name_bloc.dart';
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

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ru', ''),
        ],
      ),

      blocs: [
        Bloc((i) => AppBarTitleBloc()),
        Bloc((i) => WeatherDisplayModeBloc()),
        Bloc((i) => CityNameBloc()),
        Bloc((i) => HourlyWeatherBloc()),
        Bloc((i) => DailyWeatherBloc()),
      ],
    );
  }
}
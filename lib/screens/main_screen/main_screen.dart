import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/city_name_widget.dart';
import 'components/weather_mode_dropdown_button_widget.dart';
import '../../blocs/main_screen_blocs/app_bar_title_bloc.dart';
import '../../blocs/main_screen_blocs/daily_weather_bloc.dart';
import '../../blocs/main_screen_blocs/hourly_weather_bloc.dart';
import '../../blocs/main_screen_blocs/weather_display_mode_bloc.dart';

class MainPage extends StatelessWidget {
  final _titleBloc = BlocProvider.getBloc<AppBarTitleBloc>();
  final _hourlyWeatherBloc = BlocProvider.getBloc<HourlyWeatherBloc>();
  final _dailyWeatherBloc = BlocProvider.getBloc<DailyWeatherBloc>();

  final _screenBloc = BlocProvider.getBloc<WeatherDisplayModeBloc>();

  @override
  Widget build(BuildContext context) {
    _titleBloc.createModes([
      AppLocalizations.of(context).showHourlyWeather,
      AppLocalizations.of(context).showDailyWeather
    ]);

    _hourlyWeatherBloc.fetchHourlyWeather(
      AppLocalizations.of(context).languageCode,
      AppLocalizations.of(context).languageAndCountryCode
    );

    _dailyWeatherBloc.fetchDailyWeather(
        AppLocalizations.of(context).languageCode,
    );

    return Scaffold(
      appBar: AppBar(
        title: MainPageTitle(),
      ),
      body: StreamBuilder(
        stream: _screenBloc.currentScreen,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          }
          return Container();
        },
      ),
    );
  }
}

class MainPageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WeatherDisplayModeDropdownButton(),
        SizedBox(
          width: 25.0,
        ),
        CityName(),
      ],
    );
  }
}
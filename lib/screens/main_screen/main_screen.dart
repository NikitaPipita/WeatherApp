import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/city_name_widget.dart';
import 'components/weather_mode_dropdown_button_widget.dart';
import '../../blocs/main_screen_blocs/weather_display_mode_bloc.dart';

class MainPage extends StatelessWidget {
  final _screenBloc = BlocProvider.getBloc<WeatherDisplayModeBloc>();

  @override
  Widget build(BuildContext context) {
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
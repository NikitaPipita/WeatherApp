import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../blocs/main_screen_blocs/app_bar_title_bloc.dart';
import '../../blocs/main_screen_blocs/weather_display_mode_bloc.dart';

class MainPage extends StatelessWidget {
  final _screenBloc = BlocProvider.getBloc<WeatherDisplayModeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WeatherDisplayModeDropdownButton(),
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

class WeatherDisplayModeDropdownButton extends StatelessWidget {
  final _titleBloc = BlocProvider.getBloc<AppBarTitleBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _titleBloc.getMode,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<String>(
            value: snapshot.data,
            items: _titleBloc.modes.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            onChanged: _titleBloc.setMode,
          );
        }
        return Container();
      },
    );
  }
}
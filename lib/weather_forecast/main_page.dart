import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'daily_forecast_screen.dart';
import 'hourly_forecast/hourly_forecast_screen.dart';

class MainPage extends StatelessWidget {
  final _screenBloc = BlocProvider.getBloc<WeatherDisplayModeScreenBloc>();

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

class WeatherDisplayModeScreenBloc extends BlocBase{
  final _stateBloc = BlocProvider.getBloc<WeatherDisplayModeTitleBloc>();
  StreamSubscription _stateBlocSubscription;

  var forecastScreens = [HourlyForecastScreen(), DailyForecastScreen()];

  Stream<Widget> currentScreen;
  final _setScreen = BehaviorSubject<Widget>();

  WeatherDisplayModeScreenBloc() {
    currentScreen = Rx.merge([
      _setScreen,
    ]).startWith(forecastScreens[0])
        .asBroadcastStream();

    _stateBlocSubscription = _stateBloc.currentMode.listen((event) {
      var selectedScreen = _stateBloc.modes.indexOf(event);
      _setScreen.sink.add(forecastScreens[selectedScreen]);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stateBlocSubscription.cancel();
    _setScreen.close();
  }
}


class WeatherDisplayModeDropdownButton extends StatelessWidget {
  final _titleBloc = BlocProvider.getBloc<WeatherDisplayModeTitleBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _titleBloc.currentMode,
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

class WeatherDisplayModeTitleBloc extends BlocBase{

  var modes = ['Show hourly weather', 'Show daily weather'];

  Stream<String> currentMode;
  final _setMode = BehaviorSubject<String>();

  Function(String) get setMode => _setMode.sink.add;

  WeatherDisplayModeTitleBloc() {
    currentMode = Rx.merge([
      _setMode,
    ]).startWith(modes[0])
        .asBroadcastStream();
  }

  @override
  void dispose() {
    super.dispose();
    _setMode.close();
  }
}
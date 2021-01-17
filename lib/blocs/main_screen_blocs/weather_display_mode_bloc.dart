import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'app_bar_title_bloc.dart';
import '../../screens/main_screen/components/daily_forecast_list_widget.dart';
import '../../screens/main_screen/components/hourly_forecast_list_widget.dart';

class WeatherDisplayModeBloc extends BlocBase{
  final _stateBloc = BlocProvider.getBloc<AppBarTitleBloc>();
  StreamSubscription _stateBlocSubscription;

  var forecastScreens = [HourlyForecastScreen(), DailyForecastScreen()];

  final _currentScreen = BehaviorSubject<Widget>();

  Stream<Widget> get currentScreen => _currentScreen.stream;

  WeatherDisplayModeBloc() {
    _currentScreen.sink.add(forecastScreens.first);

    _stateBlocSubscription = _stateBloc.getMode.listen((event) {
      var selectedScreen = _stateBloc.modes.indexOf(event);
      _currentScreen.sink.add(forecastScreens[selectedScreen]);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stateBlocSubscription.cancel();
    _currentScreen.close();
  }
}
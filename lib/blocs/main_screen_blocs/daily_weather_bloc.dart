import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/shared_preferences_keys.dart' as sharedPreferencesKeys;
import '../../models/open_weather_models/data_models.dart';
import '../../services/weather_api/open_weather_requests.dart';

class DailyWeatherBloc extends BlocBase {
  final _weatherFetcher = BehaviorSubject<List<DayWeather>>();

  Stream<List<DayWeather>> get weather => _weatherFetcher.stream;

  DailyWeatherBloc() {
    fetchDailyWeather();
  }

  fetchDailyWeather() async {
    List<DayWeather> fetchedWeather = await _fetchDailyWeather();
    _weatherFetcher.sink.add(fetchedWeather);
  }

  Future<List<DayWeather>> _fetchDailyWeather() async {
    var internetConnectivity = await Connectivity().checkConnectivity();
    var preferences = await SharedPreferences.getInstance();
    String jsonData;

    if (internetConnectivity == ConnectivityResult.none) {
      jsonData =
          preferences.getString(sharedPreferencesKeys.lastDailyForecast) ?? '';
      if (jsonData.isEmpty) return List<DayWeather>();
    } else {
      jsonData = await getSevenDaysDailyForecast(50.4547, 30.5238, 'ru');
      await preferences.setString(
          sharedPreferencesKeys.lastDailyForecast, jsonData);
    }

    var data = jsonDecode(jsonData);
    var dailyForecastData = data['daily'] as List<dynamic>;
    return dailyForecastData.map((e) => DayWeather.fromJson(e)).toList();
  }

  dispose() {
    super.dispose();
    _weatherFetcher.close();
  }
}
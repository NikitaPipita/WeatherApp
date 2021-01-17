import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/shared_preferences_keys.dart' as sharedPreferencesKeys;
import '../../models/open_weather_models/data_models.dart';
import '../../services/weather_api/open_weather_requests.dart';

class HourlyWeatherBloc extends BlocBase {
  final _weatherFetcher = BehaviorSubject<List<HourWeather>>();

  Stream<List<HourWeather>> get weather => _weatherFetcher.stream;

  HourlyWeatherBloc() {
    fetchHourlyWeather();
  }

  fetchHourlyWeather() async {
    List<HourWeather> fetchedWeather = await _fetchHourlyWeather();
    _weatherFetcher.sink.add(fetchedWeather);
  }

  Future<List<HourWeather>> _fetchHourlyWeather() async {
    var internetConnectivity = await Connectivity().checkConnectivity();
    var preferences = await SharedPreferences.getInstance();
    String jsonData;

    if (internetConnectivity == ConnectivityResult.none) {
      jsonData =
          preferences.getString(sharedPreferencesKeys.lastHourlyForecast) ?? '';
      if (jsonData.isEmpty) return List<HourWeather>();
    } else {
      jsonData = await getTwoDaysHourlyForecast(50.4547, 30.5238, 'ru');
      await preferences.setString(
          sharedPreferencesKeys.lastHourlyForecast, jsonData);
    }

    var data = jsonDecode(jsonData);
    var hourlyForecastData = data['hourly'] as List<dynamic>;
    return hourlyForecastData.map((e) => HourWeather.fromJson(e)).toList();
  }

  dispose() {
    super.dispose();
    _weatherFetcher.close();
  }
}
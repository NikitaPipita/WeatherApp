import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'city_name_bloc.dart';
import '../../constants/shared_preferences_keys.dart' as sharedPreferencesKeys;
import '../../models/open_weather_models/data_models.dart';
import '../../services/geolocation/determine_position.dart';
import '../../services/weather_api/open_weather_requests.dart';

class HourlyWeatherBloc extends BlocBase {
  final _weatherFetcher = BehaviorSubject<List<HourWeather>>();

  Stream<List<HourWeather>> get weather => _weatherFetcher.stream;

  fetchHourlyWeather(String languageCode, String languageAndCountryCode) async {
    List<HourWeather> fetchedWeather =
        await _fetchHourlyWeather(languageCode, languageAndCountryCode);
    _weatherFetcher.sink.add(fetchedWeather);
  }

  Future<List<HourWeather>> _fetchHourlyWeather(
      String languageCode, String languageAndCountryCode) async {
    var internetConnectivity = await Connectivity().checkConnectivity();
    var preferences = await SharedPreferences.getInstance();
    String jsonData;

    if (internetConnectivity == ConnectivityResult.none) {
      jsonData =
          preferences.getString(sharedPreferencesKeys.lastHourlyForecast) ?? '';
      if (jsonData.isEmpty) return List<HourWeather>();
    } else {

      final _cityNameBloc = BlocProvider.getBloc<CityNameBloc>();
      var cityPosition = await determineCurrentPosition();
      var cityName = await determineCityByCoordinates(cityPosition.latitude,
          cityPosition.longitude, languageAndCountryCode);
      _cityNameBloc.setCity(cityName);

      jsonData = await getTwoDaysHourlyForecast(
          cityPosition.latitude, cityPosition.longitude, languageCode);
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
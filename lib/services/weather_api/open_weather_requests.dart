import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../constants/assets_paths.dart' as assets;
import '../../constants/weather_api_paths.dart' as weatherApi;
import '../../models/open_weather_models/data_models.dart';

Future<List<HourWeather>> getTwoDaysHourlyForecast(
    double latitude, double longitude, String language) async {
  final exclude = 'current,minutely,daily,alerts';
  final measurementUnits = 'metric';
  final weatherApiKeysJson =
      await rootBundle.loadString(assets.weatherApiKeysPath);
  final weatherApiKeys = jsonDecode(weatherApiKeysJson);

  final response = await http.get(
    '${weatherApi.openWeatherOneCallPath}'
    '?'
    'lat=$latitude&'
    'lon=$longitude&'
    'exclude=$exclude&'
    'appid=${weatherApiKeys['default_key']}&'
    'units=$measurementUnits&'
    'lang=$language',
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var hourlyForecastData = data['hourly'] as List<dynamic>;
    return hourlyForecastData.map((e) => HourWeather.fromJson(e)).toList();
  } else {
    throw Exception(
        'Failed to load hourly forecast. Check your Internet connection.');
  }
}

Future<List<DayWeather>> getSevenDaysDailyForecast(
    double latitude, double longitude, String language) async {
  final exclude = 'current,minutely,hourly,alerts';
  final measurementUnits = 'metric';
  final weatherApiKeysJson =
      await rootBundle.loadString(assets.weatherApiKeysPath);
  final weatherApiKeys = jsonDecode(weatherApiKeysJson);

  final response = await http.get(
    '${weatherApi.openWeatherOneCallPath}'
    '?'
    'lat=$latitude&'
    'lon=$longitude&'
    'exclude=$exclude&'
    'appid=${weatherApiKeys['default_key']}&'
    'units=$measurementUnits&'
    'lang=$language',
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var dailyForecastData = data['daily'] as List<dynamic>;
    return dailyForecastData.map((e) => DayWeather.fromJson(e)).toList();
  } else {
    throw Exception(
        'Failed to load daily forecast. Check your Internet connection.');
  }
}

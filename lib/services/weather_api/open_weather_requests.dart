import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../constants/assets_paths.dart' as assets;
import '../../constants/weather_api_paths.dart' as weatherApi;

Future<String> getTwoDaysHourlyForecast(
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
    return response.body;
  } else {
    throw Exception(
        'Failed to load hourly forecast. Check your Internet connection.');
  }
}

Future<String> getSevenDaysDailyForecast(
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
    return response.body;
  } else {
    throw Exception(
        'Failed to load daily forecast. Check your Internet connection.');
  }
}

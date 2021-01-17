import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/open_weather_models/data_models.dart';
import '../../services/weather_api/open_weather_requests.dart';

class HourlyWeatherBloc extends BlocBase {
  Future<List<HourWeather>> _fetchHourlyWeather() =>
      getTwoDaysHourlyForecast(50.4547, 30.5238, 'ru');

  final _weatherFetcher = BehaviorSubject<List<HourWeather>>();

  Stream<List<HourWeather>> get weather => _weatherFetcher.stream;

  HourlyWeatherBloc() {
    fetchHourlyWeather();
  }

  fetchHourlyWeather() async {
    List<HourWeather> fetchedWeather = await _fetchHourlyWeather();
    _weatherFetcher.sink.add(fetchedWeather);
  }

  dispose() {
    super.dispose();
    _weatherFetcher.close();
  }
}
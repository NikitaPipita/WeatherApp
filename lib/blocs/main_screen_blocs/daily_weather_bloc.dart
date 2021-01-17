import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/open_weather_models/data_models.dart';
import '../../services/weather_api/open_weather_requests.dart';

class DailyWeatherBloc extends BlocBase {
  Future<List<DayWeather>> _fetchDailyWeather() =>
      getSevenDaysDailyForecast(50.4547, 30.5238, 'ru');

  final _weatherFetcher = BehaviorSubject<List<DayWeather>>();

  Stream<List<DayWeather>> get weather => _weatherFetcher.stream;

  DailyWeatherBloc() {
    fetchDailyWeather();
  }

  fetchDailyWeather() async {
    List<DayWeather> fetchedWeather = await _fetchDailyWeather();
    _weatherFetcher.sink.add(fetchedWeather);
  }

  dispose() {
    super.dispose();
    _weatherFetcher.close();
  }
}
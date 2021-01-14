import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../weather_api/data_models.dart';
import '../weather_api/open_weather_requests.dart';

class HourlyForecastScreen extends StatelessWidget {
  final _hourlyWeatherBloc = BlocProvider.getBloc<HourlyWeatherBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _hourlyWeatherBloc.weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildHourlyForecastListView(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildHourlyForecastListView(List<HourWeather> forecast) {
    return ListView.builder(
      itemCount: forecast.length,
      itemBuilder: (BuildContext context, int index) {
        HourWeather item = forecast[index];
        var generalWeatherInfo = item.generalInfo.first;
        return ListTile(
          title: Text(
            generalWeatherInfo.weatherCondition +
                ' ' + generalWeatherInfo.description,
          ),
          subtitle: Text(
            item.temperature.toString(),
          ),
        );
      },
    );
  }

}

class HourlyWeatherBloc extends BlocBase{
  Future<List<HourWeather>> _fetchHourlyWeather() =>
      getFourDaysHourlyForecast(50.4547, 30.5238, 'ru');

  final _weatherFetcher = BehaviorSubject<List<HourWeather>>();

  Stream<List<HourWeather>> get weather {
    return _weatherFetcher.stream;
  }

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
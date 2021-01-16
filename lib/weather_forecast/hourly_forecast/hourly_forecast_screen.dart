import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rxdart/rxdart.dart';

import '../weather_detail_info_widget.dart';
import '../weather_main_info_widget.dart';
import '../../weather_api/data_models.dart';
import '../../weather_api/open_weather_requests.dart';

extension StringExtension on String {
  String capitalizeFirstSymbol() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

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
        HourWeather hourForecast = forecast[index];

        final forecastTimeBloc = TimeFormatBloc(hourForecast.unixDateTime);

        final hourTemperature = hourForecast.temperature.toString() + '°';
        final iconUrl = 'https://openweathermap.org/img/wn/' +
            hourForecast.generalInfo.first.weatherIcon + '@4x.png';
        final hourPrecipitationProbability =
            hourForecast.precipitationProbability.toString() + '%';

        final weatherDescription = hourForecast.generalInfo.first
            .description.capitalizeFirstSymbol();
        final hourWeatherDetails = [
          DetailInfoGridTile(
            icon: FontAwesome.thermometer_empty,
            title: 'Feels like',
            info: hourForecast.temperatureFeels.toString() + '°',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.wind,
            title: 'Wind',
            info: hourForecast.windSpeed.toString() + ' km/h',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: WeatherIcons.wi_humidity,
            title: 'Humidity',
            info: hourForecast.humidity.toString() + '%',
            underlined: false,
          ),
          DetailInfoGridTile(
            icon: Feather.sun,
            title: 'UV index',
            info: hourForecast.ultravioletIndex.toString() + ' out of 10',
            underlined: false,
          ),
        ];

        return ExpansionTile(
          leading: StreamBuilder(
            stream: forecastTimeBloc.time,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data),
                  ],
                );
              }
              return Text('');
            },
          ),
          title: WeatherMainInfoWidget(
            temperature: hourTemperature,
            iconUrl: iconUrl,
            precipitationProbability: hourPrecipitationProbability,
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 4.0, 40.0, 16.0),
              child: WeatherDetailInfoWidget(
                description: weatherDescription,
                gridTiles: hourWeatherDetails,
              ),
            ),
          ],
        );
      },
    );
  }
}

class HourlyWeatherBloc extends BlocBase {
  Future<List<HourWeather>> _fetchHourlyWeather() =>
      getFourDaysHourlyForecast(50.4547, 30.5238, 'ru');

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

class TimeFormatBloc extends BlocBase {
  final _humanTime = BehaviorSubject<String>();

  Stream<String> get time => _humanTime.stream;

  TimeFormatBloc(int unixDateTime) {
    var date = DateTime.fromMillisecondsSinceEpoch(unixDateTime * 1000);
    var hour = date.hour > 9
        ? date.hour.toString()
        : '0' + date.hour.toString();
    var minute = '0' + date.minute.toString();
    _humanTime.sink.add(hour + ':' + minute);
  }

  dispose() {
    super.dispose();
    _humanTime.close();
  }
}
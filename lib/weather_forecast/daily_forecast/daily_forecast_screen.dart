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

class DailyForecastScreen extends StatelessWidget {
  final _dailyWeatherBloc = BlocProvider.getBloc<DailyWeatherBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _dailyWeatherBloc.weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildDailyForecastListView(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildDailyForecastListView(List<DayWeather> forecast) {
    return ListView.builder(
      itemCount: forecast.length,
      itemBuilder: (BuildContext context, int index) {
        DayWeather dayForecast = forecast[index];

        final forecastTimeBloc =
            WeekDayAndDayNumberTimeFormatBloc(dayForecast.unixDateTime);

        final dayTemperature = dayForecast.dayTemperature.toString() + '°';
        final nightTemperature = dayForecast.nightTemperature.toString() + '°';
        final dayAndNightTemperature = dayTemperature +
            ' / ' + nightTemperature;
        final iconUrl = 'https://openweathermap.org/img/wn/' +
            dayForecast.generalInfo.first.weatherIcon + '@4x.png';
        final hourPrecipitationProbability =
            dayForecast.precipitationProbability.toString() + '%';

        final weatherDescription = dayForecast.generalInfo.first
            .description.capitalizeFirstSymbol();

        final sunriseTimeBloc =
            HourMinuteTimeFormatBloc(dayForecast.sunriseUnixDateTime);
        final sunsetTimeBloc =
            HourMinuteTimeFormatBloc(dayForecast.sunsetUnixDateTime);

        final hourWeatherDetails = [
          DetailInfoGridTile(
            icon: FontAwesome.thermometer_full,
            title: 'Day feels like',
            info: dayForecast.dayTemperatureFeels.toString() + '°',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: FontAwesome.thermometer_empty,
            title: 'Nigh feels like',
            info: dayForecast.nightTemperatureFeels.toString() + '°',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.cloud,
            title: 'Cloudiness',
            info: dayForecast.cloudiness.toString() + ' %',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.wind,
            title: 'Wind',
            info: dayForecast.windSpeed.toString() + ' km/h',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: WeatherIcons.wi_humidity,
            title: 'Humidity',
            info: dayForecast.humidity.toString() + '%',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.sun,
            title: 'UV index',
            info: dayForecast.ultravioletIndex.toString() + ' out of 10',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.sunrise,
            title: 'Sunrise',
            info: sunriseTimeBloc.time,
            underlined: false,
          ),
          DetailInfoGridTile(
            icon: Feather.sunset,
            title: 'Sunset',
            info: sunsetTimeBloc.time,
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
            temperature: dayAndNightTemperature,
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

final weekDays = <int, String>{
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun',
};

class WeekDayAndDayNumberTimeFormatBloc extends BlocBase {
  final _humanTime = BehaviorSubject<String>();

  Stream<String> get time => _humanTime.stream;

  WeekDayAndDayNumberTimeFormatBloc(int unixDateTime) {
    var date = DateTime.fromMillisecondsSinceEpoch(unixDateTime * 1000);
    var weekDay = weekDays[date.weekday];
    var dayNumber = date.day.toString();
    _humanTime.sink.add(weekDay + ' ' + dayNumber);
  }

  dispose() {
    super.dispose();
    _humanTime.close();
  }
}

class HourMinuteTimeFormatBloc extends BlocBase {
  final _humanTime = BehaviorSubject<String>();

  Stream<String> get time => _humanTime.stream;

  HourMinuteTimeFormatBloc(int unixDateTime) {
    var date = DateTime.fromMillisecondsSinceEpoch(unixDateTime * 1000);
    var hour = date.hour > 9
        ? date.hour.toString()
        : '0' + date.hour.toString();
    var minute = date.minute > 9
        ? date.minute.toString()
        : '0' + date.minute.toString();
    _humanTime.sink.add(hour + ':' + minute);
  }

  dispose() {
    super.dispose();
    _humanTime.close();
  }
}
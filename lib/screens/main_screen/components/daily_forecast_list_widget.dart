import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../blocs/main_screen_blocs/daily_weather_bloc.dart';
import '../../../components/detail_info_grid_tile_widget.dart';
import '../../../components/weather_detail_info_widget.dart';
import '../../../components/weather_main_info_widget.dart';
import '../../../constants/weather_api_paths.dart' as weatherApi;
import '../../../models/open_weather_models/data_models.dart';
import '../../../utils/extensions/int_extensions.dart';
import '../../../utils/extensions/string_extensions.dart';

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

        final forecastDay = dayForecast.unixDateTime
            .weekDayAndDayNumberTimeFormatBloc();

        final dayTemperature = dayForecast.dayTemperature.toString() + '°';
        final nightTemperature = dayForecast.nightTemperature.toString() + '°';
        final dayAndNightTemperature = dayTemperature +
            ' / ' + nightTemperature;
        final iconUrl = weatherApi.openWeatherImagePath +
            dayForecast.generalInfo.first.weatherIcon + '@4x.png';
        final hourPrecipitationProbability =
            dayForecast.precipitationProbability.toString() + '%';

        final weatherDescription = dayForecast.generalInfo.first
            .description.capitalizeFirstSymbol();

        final sunriseTime = dayForecast.sunriseUnixDateTime
            .hourMinuteTimeFormat();
        final sunsetTime = dayForecast.sunsetUnixDateTime
            .hourMinuteTimeFormat();

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
            info: dayForecast.cloudiness.toString() + '%',
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
            info: sunriseTime,
            underlined: false,
          ),
          DetailInfoGridTile(
            icon: Feather.sunset,
            title: 'Sunset',
            info: sunsetTime,
            underlined: false,
          ),
        ];

        return ExpansionTile(
          leading: Text(forecastDay),
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
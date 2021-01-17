import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            .weekDayAndDayNumberTimeFormatBloc(context);

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
            title: AppLocalizations.of(context).dayFeelsLike,
            info: dayForecast.dayTemperatureFeels.toString() + '°',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: FontAwesome.thermometer_empty,
            title: AppLocalizations.of(context).nightFeelsLike,
            info: dayForecast.nightTemperatureFeels.toString() + '°',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.cloud,
            title: AppLocalizations.of(context).cloudiness,
            info: dayForecast.cloudiness.toString() + '%',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.wind,
            title: AppLocalizations.of(context).wind,
            info: dayForecast.windSpeed.toString() +
                ' ' +
                AppLocalizations.of(context).kmPerHour,
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: WeatherIcons.wi_humidity,
            title: AppLocalizations.of(context).humidity,
            info: dayForecast.humidity.toString() + '%',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.sun,
            title: AppLocalizations.of(context).uvIndex,
            info: dayForecast.ultravioletIndex.toString() +
                ' ' +
                AppLocalizations.of(context).outOfTen,
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.sunrise,
            title: AppLocalizations.of(context).sunrise,
            info: sunriseTime,
            underlined: false,
          ),
          DetailInfoGridTile(
            icon: Feather.sunset,
            title: AppLocalizations.of(context).sunset,
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
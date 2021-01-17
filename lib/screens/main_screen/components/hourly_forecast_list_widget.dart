import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../blocs/main_screen_blocs/hourly_weather_bloc.dart';
import '../../../components/detail_info_grid_tile_widget.dart';
import '../../../components/weather_detail_info_widget.dart';
import '../../../components/weather_main_info_widget.dart';
import '../../../constants/weather_api_paths.dart' as weatherApi;
import '../../../models/open_weather_models/data_models.dart';
import '../../../utils/extensions/int_extensions.dart';
import '../../../utils/extensions/string_extensions.dart';

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

        final forecastTime = hourForecast.unixDateTime.hourMinuteTimeFormat();

        final hourTemperature = hourForecast.temperature.toString() + '°';
        final iconUrl = weatherApi.openWeatherImagePath +
            hourForecast.generalInfo.first.weatherIcon +
            '@4x.png';
        final hourPrecipitationProbability =
            hourForecast.precipitationProbability.toString() + '%';

        final weatherDescription =
            hourForecast.generalInfo.first.description.capitalizeFirstSymbol();
        final hourWeatherDetails = [
          DetailInfoGridTile(
            icon: FontAwesome.thermometer_empty,
            title: AppLocalizations.of(context).feelsLike,
            info: hourForecast.temperatureFeels.toString() + '°',
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: Feather.wind,
            title: AppLocalizations.of(context).wind,
            info: hourForecast.windSpeed.toString() +
                ' ' +
                AppLocalizations.of(context).kmPerHour,
            underlined: true,
          ),
          DetailInfoGridTile(
            icon: WeatherIcons.wi_humidity,
            title: AppLocalizations.of(context).humidity,
            info: hourForecast.humidity.toString() + '%',
            underlined: false,
          ),
          DetailInfoGridTile(
            icon: Feather.sun,
            title: AppLocalizations.of(context).uvIndex,
            info: hourForecast.ultravioletIndex.toString() +
                ' ' +
                AppLocalizations.of(context).outOfTen,
            underlined: false,
          ),
        ];

        return ExpansionTile(
          leading: Text(forecastTime),
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

class HourWeather {
  final int unixDateTime;
  final int temperature;
  final int temperatureFeels;
  final int humidity;
  final int ultravioletIndex;
  final int windSpeed;
  final int precipitationProbability;

  final List<GeneralWeatherInfo> generalInfo;

  HourWeather({
    this.unixDateTime,
    this.temperature,
    this.temperatureFeels,
    this.humidity,
    this.ultravioletIndex,
    this.windSpeed,
    this.precipitationProbability,
    this.generalInfo,
  });

  factory HourWeather.fromJson(Map<String, dynamic> json) {
    var generalWeatherInfo = json['weather'] as List<dynamic>;

    return HourWeather(
      unixDateTime: json['dt'],
      temperature: json['temp'].toInt(),
      temperatureFeels: json['feels_like'].toInt(),
      humidity: json['humidity'].toInt(),
      ultravioletIndex: json['uvi'].toInt(),
      windSpeed: json['wind_speed'].toInt(),
      precipitationProbability: json['pop'].toInt(),
      generalInfo: generalWeatherInfo.map((e) =>
          GeneralWeatherInfo.fromJson(e)).toList(),
    );
  }
}

class GeneralWeatherInfo {
  final String weatherCondition;
  final String description;
  final String weatherIcon;

  GeneralWeatherInfo({
    this.weatherCondition,
    this.description,
    this.weatherIcon,
  });

  factory GeneralWeatherInfo.fromJson(Map<String, dynamic> json) =>
      GeneralWeatherInfo(
        weatherCondition: json['main'],
        description: json['description'],
        weatherIcon: json['icon'],
      );
}
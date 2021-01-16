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

class DayWeather {
  final int unixDateTime;
  final int sunriseUnixDateTime;
  final int sunsetUnixDateTime;

  final int dayTemperature;
  final int nightTemperature;
  final int dayTemperatureFeels;
  final int nightTemperatureFeels;

  final int humidity;
  final int windSpeed;
  final int precipitationProbability;
  final int cloudiness;
  final int ultravioletIndex;

  final List<GeneralWeatherInfo> generalInfo;

  DayWeather({
    this.unixDateTime,
    this.sunriseUnixDateTime,
    this.sunsetUnixDateTime,

    this.dayTemperature,
    this.nightTemperature,
    this.dayTemperatureFeels,
    this.nightTemperatureFeels,

    this.humidity,
    this.windSpeed,
    this.precipitationProbability,
    this.cloudiness,
    this.ultravioletIndex,

    this.generalInfo,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    var temperatureInfo = json['temp'];
    var temperatureFeelsInfo = json['feels_like'];
    var generalWeatherInfo = json['weather'] as List<dynamic>;

    return DayWeather(
      unixDateTime: json['dt'],
      sunriseUnixDateTime: json['sunrise'],
      sunsetUnixDateTime: json['sunset'],

      dayTemperature: temperatureInfo['day'].toInt(),
      nightTemperature: temperatureInfo['night'].toInt(),
      dayTemperatureFeels: temperatureFeelsInfo['day'].toInt(),
      nightTemperatureFeels: temperatureFeelsInfo['night'].toInt(),

      humidity: json['humidity'].toInt(),
      windSpeed: json['wind_speed'].toInt(),
      precipitationProbability: json['pop'].toInt(),
      cloudiness: json['clouds'].toInt(),
      ultravioletIndex: json['uvi'].toInt(),

      generalInfo: generalWeatherInfo.map((e) =>
          GeneralWeatherInfo.fromJson(e)).toList(),
    );
  }
}
class HourWeather {
  final int unixDateTime;
  final int temperature;
  final int temperatureFeels;
  final int atmospherePressure;
  final int humidity;
  final int cloudiness;
  final int windSpeed;
  final int precipitationProbability;

  final List<GeneralWeatherInfo> generalInfo;

  HourWeather({
    this.unixDateTime,
    this.temperature,
    this.temperatureFeels,
    this.atmospherePressure,
    this.humidity,
    this.cloudiness,
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
      atmospherePressure: json['pressure'].toInt(),
      humidity: json['humidity'].toInt(),
      cloudiness: json['clouds'].toInt(),
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

  GeneralWeatherInfo({
    this.weatherCondition,
    this.description,
  });

  factory GeneralWeatherInfo.fromJson(Map<String, dynamic> json) =>
      GeneralWeatherInfo(
        weatherCondition: json['main'],
        description: json['description'],
      );
}
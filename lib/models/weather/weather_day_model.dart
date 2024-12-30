import 'package:kisanapp/models/weather/weather_condition_model.dart';

class DayWeather {
  final num maxTempC;
  final num minTempC;
  // final double avgTempC;
  // final double maxWindKph;
  // final double totalPrecipMm;
  // final double totalSnowCm;
  // final double avgVisKm;
  // final int avgHumidity;
  // final int dailyChanceOfRain;
  // final int dailyChanceOfSnow;
  // final WeatherCondition condition;
  // final double uv;

  DayWeather({
    required this.maxTempC,
    required this.minTempC,
    // required this.avgTempC,
    // required this.maxWindKph,
    // required this.totalPrecipMm,
    // required this.totalSnowCm,
    // required this.avgVisKm,
    // required this.avgHumidity,
    // required this.dailyChanceOfRain,
    // required this.dailyChanceOfSnow,
    // required this.condition,
    // required this.uv,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    return DayWeather(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      // avgTempC: json['avgtemp_c'].toDouble(),
      // maxWindKph: json['maxwind_kph'].toDouble(),
      // totalPrecipMm: json['totalprecip_mm'].toDouble(),
      // totalSnowCm: json['totalsnow_cm'].toDouble(),
      // avgVisKm: json['avgvis_km'].toDouble(),
      // avgHumidity: json['avghumidity'],
      // dailyChanceOfRain: json['daily_chance_of_rain'],
      // dailyChanceOfSnow: json['daily_chance_of_snow'],
      // condition: WeatherCondition.fromJson(json['condition']),
      // uv: json['uv'].toDouble(),
    );
  }
}

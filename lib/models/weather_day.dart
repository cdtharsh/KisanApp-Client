import 'package:kisanapp/models/weather_condition_model.dart';

class DayWeather {
  final double maxTempC;
  final double minTempC;
  final WeatherCondition condition;
  final double uv;

  DayWeather({
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
    required this.uv,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    return DayWeather(
      maxTempC: json['maxtemp_c'].toDouble(),
      minTempC: json['mintemp_c'].toDouble(),
      condition: WeatherCondition.fromJson(json['condition']),
      uv: json['uv'].toDouble(),
    );
  }
}

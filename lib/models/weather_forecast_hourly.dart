import 'package:kisanapp/models/weather_condition_model.dart';

class HourWeather {
  final String time;
  final double tempC;
  final int isDay;
  final WeatherCondition condition;

  HourWeather({
    required this.time,
    required this.tempC,
    required this.isDay,
    required this.condition,
  });

  factory HourWeather.fromJson(Map<String, dynamic> json) {
    return HourWeather(
      time: json['time'],
      tempC: json['temp_c'].toDouble(),
      isDay: json['is_day'],
      condition: WeatherCondition.fromJson(json['condition']),
    );
  }
}

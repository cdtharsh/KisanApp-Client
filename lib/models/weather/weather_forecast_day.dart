import 'package:kisanapp/models/weather/weather_astro_model.dart';
import 'package:kisanapp/models/weather/weather_day_model.dart';
import 'package:kisanapp/models/weather/weather_forecast_hourly.dart';

class ForecastDay {
  // final String date;
  final DayWeather dayWeather;
  // final Astro astro;
  // final List<HourWeather> hourlyWeather;

  ForecastDay({
    // required this.date,
    required this.dayWeather,
    // required this.astro,
    // required this.hourlyWeather,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      // date: json['date'],
      dayWeather: DayWeather.fromJson(json['day']),
      // astro: Astro.fromJson(json['astro']),
      // hourlyWeather: (json['hour'] as List)
      //     .map((hour) => HourWeather.fromJson(hour))
      //     .toList(),
    );
  }
}

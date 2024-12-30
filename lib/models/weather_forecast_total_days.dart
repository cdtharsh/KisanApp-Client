import 'package:kisanapp/models/weather_forecast_day.dart';

class Forecast {
  final List<ForecastDay> forecastDays;

  Forecast({required this.forecastDays});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastDays: (json['forecastday'] as List)
          .map((day) => ForecastDay.fromJson(day))
          .toList(),
    );
  }
}

import 'package:kisanapp/models/weather/weather_current_model.dart';
import 'package:kisanapp/models/weather/weather_forecast_total_days.dart';
import 'package:kisanapp/models/weather/weather_location_model.dart';

class WeatherResponse {
  final Location location;
  final CurrentWeather current;
  final Forecast forecast;

  WeatherResponse({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: Location.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

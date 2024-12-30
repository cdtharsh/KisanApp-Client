import 'weather_condition_model.dart';

class CurrentWeather {
  final String lastUpdated;
  final double tempC;
  final int isDay;
  final WeatherCondition condition;
  final double windSpeed; // Wind speed in km/h
  final double windDegree; // Wind direction in degrees
  final double pressureMb; // Atmospheric pressure in mb
  final double humidity; // Humidity percentage
  final int cloudCoverage; // Cloud coverage percentage
  final double feelsLikeC; // Feels like temperature in Celsius
  final double windChillC; // Wind chill temperature in Celsius
  final double heatIndexC; // Heat index temperature in Celsius
  final double dewPointC; // Dew point temperature in Celsius
  final double visibilityKm; // Visibility in kilometers
  final double uvIndex; // UV index
  final double gustSpeed; // Gust speed in km/h

  CurrentWeather({
    required this.lastUpdated,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windSpeed,
    required this.windDegree,
    required this.pressureMb,
    required this.humidity,
    required this.cloudCoverage,
    required this.feelsLikeC,
    required this.windChillC,
    required this.heatIndexC,
    required this.dewPointC,
    required this.visibilityKm,
    required this.uvIndex,
    required this.gustSpeed,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      lastUpdated: json['last_updated'],
      tempC: json['temp_c'].toDouble(),
      isDay: json['is_day'],
      condition: WeatherCondition.fromJson(json['condition']),
      windSpeed: json['wind_kph'], // Wind speed in km/h
      windDegree: json['wind_degree'].toDouble(), // Wind direction in degrees
      pressureMb: json['pressure_mb'].toDouble(), // Atmospheric pressure in mb
      humidity: json['humidity'].toDouble(), // Humidity percentage
      cloudCoverage: json['cloud'].toInt(), // Cloud coverage percentage
      feelsLikeC:
          json['feelslike_c'].toDouble(), // Feels like temperature in Celsius
      windChillC:
          json['windchill_c'].toDouble(), // Wind chill temperature in Celsius
      heatIndexC:
          json['heatindex_c'].toDouble(), // Heat index temperature in Celsius
      dewPointC:
          json['dewpoint_c'].toDouble(), // Dew point temperature in Celsius
      visibilityKm: json['vis_km'].toDouble(), // Visibility in kilometers
      uvIndex: json['uv'].toDouble(), // UV index
      gustSpeed: json['gust_kph'], // Gust speed in km/h
    );
  }
}

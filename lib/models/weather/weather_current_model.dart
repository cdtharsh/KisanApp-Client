import 'weather_condition_model.dart';

class CurrentWeather {
  // final String lastUpdated;
  final num tempC;
  // final int isDay;
  final WeatherCondition condition;
  // final double windSpeed; // Wind speed in km/h
  // final int windDegree; // Wind direction in degrees, must be int
  // final String windDir; // Wind direction as string
  // final double pressureMb; // Atmospheric pressure in mb
  // final int humidity; // Humidity percentage
  // final int cloudCoverage; // Cloud coverage percentage
  // final double feelsLikeC; // Feels like temperature in Celsius
  // final double windChillC; // Wind chill temperature in Celsius
  // final double heatIndexC; // Heat index temperature in Celsius
  // final double dewPointC; // Dew point temperature in Celsius
  // final double visibilityKm; // Visibility in kilometers
  // final double uvIndex; // UV index
  // final double gustSpeed; // Gust speed in km/h
  // final double precip; // Precipitation in mm

  CurrentWeather({
    // required this.lastUpdated,
    required this.tempC,
    // required this.isDay,
    required this.condition,
    // required this.windSpeed,
    // required this.windDegree,
    // required this.windDir,
    // required this.pressureMb,
    // required this.humidity,
    // required this.cloudCoverage,
    // required this.feelsLikeC,
    // required this.windChillC,
    // required this.heatIndexC,
    // required this.dewPointC,
    // required this.visibilityKm,
    // required this.uvIndex,
    // required this.gustSpeed,
    // required this.precip,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      // lastUpdated: json['last_updated'],
      tempC: json['temp_c'],
      // isDay: json['is_day'],
      condition: WeatherCondition.fromJson(json['condition']),
      // windSpeed: json['wind_kph'].toDouble(),
      // windDegree: json['wind_degree'], // No need to convert to double
      // windDir: json['wind_dir'],
      // pressureMb: json['pressure_mb'].toDouble(),
      // humidity: json['humidity'], // Corrected to int
      // cloudCoverage: json['cloud'],
      // feelsLikeC: json['feelslike_c'].toDouble(),
      // windChillC: json['windchill_c'].toDouble(),
      // heatIndexC: json['heatindex_c'].toDouble(),
      // dewPointC: json['dewpoint_c'].toDouble(),
      // visibilityKm: json['vis_km'].toDouble(),
      // uvIndex: json['uv'].toDouble(),
      // gustSpeed: json['gust_kph'].toDouble(),
      // precip: json['precip_mm'].toDouble(),
    );
  }
}

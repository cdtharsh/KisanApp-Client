import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kisanapp/services/location/location_service.dart';

import '../weather_api_service.dart';

class WeatherService {
  final WeatherApiService weatherApiService = WeatherApiService();
  final GetStorage box = GetStorage();

  Future<Map<String, dynamic>?> fetchWeatherData(String token) async {
    // Check for cached data
    final cachedData = box.read('weatherData');
    final cachedTimestamp = box.read('weatherTimestamp');

    if (cachedData != null && cachedTimestamp != null) {
      final DateTime timestamp = DateTime.parse(cachedTimestamp);
      final DateTime currentTime = DateTime.now();
      final Duration difference = currentTime.difference(timestamp);

      // Use cached data if it's less than 1 hour old
      if (difference.inMicroseconds < 1) {
        return cachedData;
      }
    }

    // Fetch new weather data
    try {
      final locationService = LocationService();
      Position position = await locationService.getCurrentLocation();
      String lat = position.latitude.toStringAsFixed(2);
      String lon = position.longitude.toStringAsFixed(2);

      final weather =
          await weatherApiService.getWeather(lat, lon, token: token);

      // Cache the weather data and timestamp
      box.write('weatherData', weather);
      box.write('weatherTimestamp', DateTime.now().toIso8601String());

      return weather;
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}

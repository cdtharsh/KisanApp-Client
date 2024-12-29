import 'package:kisanapp/services/api_service_base.dart';

class WeatherApiService extends ApiServiceBase {
  WeatherApiService() : super(baseUrl: 'https://api.kisanwale.in');

  Future<Map<String, dynamic>> getWeather(String lat, String lon,
      {String? token}) async {
    // Construct the endpoint URL
    final endpoint = 'weather?lat=$lat&lon=$lon';

    // Call the 'get' method from ApiServiceBase, passing the token if provided
    return await get(endpoint, token: token);
  }
}

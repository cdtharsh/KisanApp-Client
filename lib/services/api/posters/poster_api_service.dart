import 'package:kisanapp/services/api/http_services.dart';

class PosterApiService extends ApiServiceBase {
  PosterApiService() : super(baseUrl: 'https://api.kisanwale.in');

  Future<Map<String, dynamic>> getPosters() async {
    // Construct the endpoint URL
    final endpoint = 'posters';

    // Call the 'get' method from ApiServiceBase, passing the token if provided
    return await get(endpoint);
  }
}

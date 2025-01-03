import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiErrorParser {
  /// Parse error from `http.Response` or `Exception`
  static String parseError(dynamic error) {
    if (error is http.Response) {
      try {
        final Map<String, dynamic> body = json.decode(error.body);
        return body['error'] ?? 'Unknown error occurred.';
      } catch (_) {
        return 'Server Error: ${error.statusCode}';
      }
    } else if (error is Exception) {
      return error.toString();
    } else {
      return 'An unknown error occurred.';
    }
  }
}

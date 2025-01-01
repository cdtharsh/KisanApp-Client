import 'dart:io';
import 'dart:convert';
import 'package:kisanapp/services/api_service_base.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart'; // For MIME type detection
import 'package:http_parser/http_parser.dart'; // For MediaType

class PredictionApiService extends ApiServiceBase {
  PredictionApiService() : super(baseUrl: 'https://api.kisanwale.in');

  Future<Map<String, dynamic>> predictDisease({
    required File imageFile,
  }) async {
    // Read the image file as bytes
    var imageBytes = await imageFile.readAsBytes();

    // Detect the MIME type based on the file extension
    var mimeType = lookupMimeType(imageFile.path) ??
        'image/jpeg'; // Default to 'image/jpeg' if MIME type can't be detected

    // Prepare the multipart request
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/predict'));

    // Add the file to the request without using MediaType
    var multipartFile = http.MultipartFile.fromBytes(
      'file', imageBytes,
      filename: imageFile.uri.pathSegments.last,
      contentType:
          MediaType.parse(mimeType), // Convert MIME type string to MediaType
    );

    request.files.add(multipartFile);

    // Send the multipart request and await the response
    var response = await request.send();

    // Check for success status code
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      throw Exception(
          'Failed to predict disease. Status Code: ${response.statusCode}');
    }
  }
}

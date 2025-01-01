import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:kisanapp/services/prediction_api_service.dart'; // Your API service

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  PreviewPageState createState() => PreviewPageState();
}

class PreviewPageState extends State<PreviewPage> {
  late img.Image _image;
  String _predictionResult = '';
  double _confidence = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final imageFile = File(widget.imagePath);

    // Read the image file and decode it
    _image = img.decodeImage(imageFile.readAsBytesSync())!;

    // Resize the image to 224x224 immediately
    _image = img.copyResize(_image, width: 224, height: 224);
  }

  // Method to handle prediction
  Future<void> _predictDisease() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Call your Prediction API service to make a prediction
      PredictionApiService apiService = PredictionApiService();

      // Create a File object to send to the server
      File imageFile = File(widget.imagePath);

      // Send the image file to the server and get the prediction
      var response = await apiService.predictDisease(imageFile: imageFile);

      setState(() {
        _isLoading = false;
        if (response['predicted_confidence'] < 99.0) {
          _predictionResult = response['message'] ?? 'Prediction failed';
        } else {
          _predictionResult = response['predicted_class'];
          _confidence = response['predicted_confidence'];
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _predictionResult = 'Error: Unable to make prediction';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Disease Prediction'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Stack(
        children: [
          // Background container for image
          Positioned.fill(
            child: Container(
              color: Colors.green.shade50,
              child: Center(
                child: Image.memory(
                  Uint8List.fromList(
                      img.encodeJpg(_image)), // Display resized image
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Prediction button (round button)
          Positioned(
            bottom: 30.0,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: _predictDisease, // Trigger the prediction onPress
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green.shade300,
                child: Icon(Icons.check, color: Colors.white, size: 30),
              ),
            ),
          ),

          // Loading indicator
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),

          // Prediction results
          Positioned(
            bottom: 100.0,
            left: 20.0,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_predictionResult.isNotEmpty)
                    Text(
                      'Prediction: $_predictionResult',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  if (_confidence > 0.0)
                    Text(
                      'Confidence: ${_confidence.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade600,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

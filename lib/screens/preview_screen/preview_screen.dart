import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kisanapp/screens/disease_screen/disease_details_page.dart';

import 'package:kisanapp/services/api/prediction/prediction_api_service.dart';

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  PreviewPageState createState() => PreviewPageState();
}

class PreviewPageState extends State<PreviewPage> {
  bool _isLoading = false;

  Future<void> _predictDisease() async {
    setState(() => _isLoading = true);

    try {
      PredictionApiService apiService = PredictionApiService();
      File imageFile = File(widget.imagePath);

      final response = await apiService.predictDisease(imageFile: imageFile);
      debugPrint('API Response: $response');

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DiseaseDetailsPage(
              predictionData: response,
              imagePath: widget.imagePath,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Prediction Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get prediction')),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Image'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 40.0,
            left: screenWidth / 2 - 35,
            child: GestureDetector(
              onTap: _predictDisease,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.green.shade400,
                child: const Icon(Icons.check, color: Colors.white, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

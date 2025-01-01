import 'dart:io';
import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.file(File(imagePath)),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter, // Centers the floating action button
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Optional padding
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green, // Button color (green for tick)
            shape: CircleBorder(),
            child: const Icon(
              Icons.check, // Right tick icon
              size: 30,
            ), // Ensures the button is circular
          ),
        ),
      ),
    );
  }
}

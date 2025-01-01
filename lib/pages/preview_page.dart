import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  PreviewPageState createState() => PreviewPageState();
}

class PreviewPageState extends State<PreviewPage> {
  late img.Image _image;

  @override
  void initState() {
    super.initState();
    final _imageFile = File(widget.imagePath);

    // Read the image file and decode it
    _image = img.decodeImage(_imageFile.readAsBytesSync())!;

    // Resize the image to 224x224 immediately
    _image = img.copyResize(_image, width: 224, height: 224);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.memory(
              Uint8List.fromList(
                  img.encodeJpg(_image)), // Display resized image
              width: double.infinity, // Display the image in 224x224 size
              height: double.infinity, // Display the image in 224x224 size
              fit: BoxFit
                  .fill, // Adjust the image to fit within the box without cropping
            ),
          ),
          Positioned(
            bottom: 20.0, // Adjust this value to move the button up or down
            left: MediaQuery.of(context).size.width / 2 -
                28, // Center button horizontally
            child: Container(
              height: 56.0, // Height of the circular button
              width: 56.0, // Width of the circular button
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Ensure the container is circular
                color: Colors.green.shade300, // Background color of the button
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.check, color: Colors.white), // Icon color
              ),
              // Add some space between the button and the image
            ),
          ),
        ],
      ),
    );
  }
}

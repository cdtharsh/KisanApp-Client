import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initializeControllerFuture = initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first; // Use the first camera
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
    );
    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Capture an image function
  Future<void> takePicture() async {
    try {
      final image = await _controller.takePicture();
      print('Picture saved to ${image.path}');
      // Navigate to preview page with the captured image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(imagePath: image.path),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  // Open gallery function
  Future<void> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Navigate to preview page with the selected image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(imagePath: pickedImage.path),
        ),
      );
    }
  }

  // Show help popup
  void showHelpPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help'),
          content: const Text('This is a help popup.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size to adjust circle sizes
    final screenSize = MediaQuery.of(context).size;
    final double iconSize = screenSize.width * 0.12; // 12% of screen width

    return Scaffold(
      body: FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                // Full-screen camera preview
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit
                        .cover, // Ensures the camera preview fits the screen properly
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
                // Center guiding square
                Center(
                  child: Container(
                    width: screenSize.width * 0.6, // 60% of screen width
                    height: screenSize.height * 0.3, // 30% of screen height
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 3.0, // Border thickness
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // Bottom container with circular icons
                Positioned(
                  bottom: 0, // Position the container at the bottom
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100, // Fixed height for the container
                    color: Colors.black
                        .withOpacity(0.5), // Optional background color
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround, // Space between icons
                      children: [
                        // Left icon (Gallery button)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: openGallery, // Open gallery
                            child: CircleAvatar(
                              backgroundColor: Colors.black87.withOpacity(0.2),
                              radius: iconSize / 3, // Dynamically set size
                              child: const Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        // Middle icon (Camera button to take a picture)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: takePicture, // Trigger picture capture
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: iconSize *
                                  1.1, // Adjust size for the middle icon
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        // Right icon (Help button)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: showHelpPopup, // Show help popup
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: iconSize / 3, // Dynamically set size
                              child: const Icon(
                                Icons.help_outline,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error initializing camera: ${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

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

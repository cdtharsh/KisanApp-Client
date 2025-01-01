import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisanapp/constants/text_strings.dart';
import 'package:kisanapp/pages/preview_page.dart';
import 'package:kisanapp/utils/notification/custome_snackbar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> initializeControllerFuture;
  late CameraDescription camera;

  @override
  void initState() {
    super.initState();
    initializeControllerFuture = initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Initialize camera
  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    camera = cameras.first; // Use the first camera
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
    );

    await _controller.initialize();

    if (mounted) {
      // Check if the widget is still mounted
      // Set the camera orientation to auto adjust based on device position
      _controller.setFlashMode(FlashMode.off);
      setState(() {});
    }
  }

  // Capture an image function
  Future<void> takePicture() async {
    try {
      final image = await _controller.takePicture();
      if (mounted) {
        Get.to(PreviewPage(imagePath: image.path));
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.show(title: kError, message: e.toString());
      }
    }
  }

  // Open gallery function
  Future<void> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null && mounted) {
      // Navigate to preview page with the selected image only if the widget is still mounted
      Get.to(PreviewPage(imagePath: pickedImage.path));
    }
  }

  // Show help popup
  void showHelpPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help'),
          content: const Text(
              'This is a help popup. Please capture the image within the box that is 224x224 in size.'),
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
    final screenSize = MediaQuery.of(context).size;
    final double iconSize = screenSize.width * 0.12;

    return Scaffold(
      body: FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: screenSize.width,
                      height: screenSize.height,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
                // Static Box around the camera preview
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 224, // Fixed size for the image capture guide
                    height: 224, // Fixed size for the image capture guide
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 5.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    color: Colors.black.withOpacity(0.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: openGallery,
                            child: CircleAvatar(
                              backgroundColor: Colors.black87.withOpacity(0.2),
                              radius: iconSize / 3,
                              child: const Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: takePicture,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: iconSize * 1.1,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: showHelpPopup,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: iconSize / 3,
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

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisanapp/utils/constants/text_strings.dart';
import 'package:kisanapp/screens/preview_screen/preview_screen.dart';
import 'package:kisanapp/widgets/layouts/custome_snackbar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription _camera;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _camera = cameras.first;

      _controller = CameraController(_camera, ResolutionPreset.high);
      await _controller.initialize();
      await _controller.setFlashMode(FlashMode.off);

      if (mounted) setState(() {});
    } catch (e) {
      CustomSnackbar.show(title: kError, message: e.toString());
    }
  }

  Future<void> _takePicture() async {
    try {
      final image = await _controller.takePicture();
      if (mounted) {
        Get.to(() => PreviewPage(imagePath: image.path));
      }
    } catch (e) {
      CustomSnackbar.show(title: kError, message: e.toString());
    }
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      Get.to(() => PreviewPage(imagePath: image.path));
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help'),
        content: const Text(
          'Capture the image within the box (224x224). Ensure the image is well-lit and focused for accurate diagnosis.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                // Capture guide
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 224,
                    height: 224,
                    decoration: BoxDecoration(
                      border: Border.all(
                        // color: Colors.black,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            // color: Colors.white60,
                            color: Colors.transparent
                            // blurRadius: 10,
                            // spreadRadius: 2,
                            ),
                      ],
                    ),
                  ),
                ),
                // Bottom action buttons
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildActionIcon(
                          icon: Icons.image,
                          color: Colors.white,
                          onTap: _openGallery,
                          tooltip: 'Open Gallery',
                        ),
                        GestureDetector(
                          onTap: _takePicture,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _buildActionIcon(
                          icon: Icons.help_outline,
                          color: Colors.white,
                          onTap: _showHelpDialog,
                          tooltip: 'Help',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error initializing camera:\n${snapshot.error}',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    String? tooltip,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip ?? '',
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white.withOpacity(0.1),
          child: Icon(icon, color: color, size: 30),
        ),
      ),
    );
  }
}

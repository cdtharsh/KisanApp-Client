import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position> getCurrentLocation(BuildContext context) async {
    // Step 1: Check if location permissions are granted using permission_handler
    if (await Permission.location.isDenied ||
        await Permission.location.isPermanentlyDenied) {
      // Request location permission
      final status = await Permission.location.request();

      if (status.isDenied || status.isPermanentlyDenied) {
        throw Exception('Location permission is denied or permanently denied');
      }
    }

    // Step 2: Check if location services are enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      // Step 3: Show a custom dialog to the user to turn on location services
      if (context.mounted) {
        await _showLocationServiceDialog(context);
      }
    }

    // Step 4: Check location permissions with Geolocator as a fallback
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission is permanently denied');
      }
    }

    // Step 5: Get the current position
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }

  Future<void> _showLocationServiceDialog(BuildContext context) async {
    // Show a dialog to ask the user to turn on location services
    if (context.mounted) {
      // Added mounted check here too
      return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Location Services Disabled'),
            content: Text('Please enable location services to continue.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the dialog and throw an exception (indicating no location was fetched)
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                  throw Exception('Location services are disabled.');
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  // Open the location settings screen to turn on location services
                  await Geolocator.openLocationSettings();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Enable Location'),
              ),
            ],
          );
        },
      );
    }
  }
}

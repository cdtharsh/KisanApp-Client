import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Rounded corners
            border: Border.all(
              color:
                  Theme.of(context).primaryColor, // Use theme's primary color
            ),
          ),
        ),
      ),
    );
  }
}

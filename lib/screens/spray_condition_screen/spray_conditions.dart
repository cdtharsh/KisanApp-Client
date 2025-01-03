import 'package:flutter/material.dart';

class SprayConditionsScreen extends StatelessWidget {
  const SprayConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Text(
              "Pune, 30 Dec",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "21°C\n30°C / 19°C\nSunset 18:08",
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),

            // Spraying Time Section
            const Text(
              "Spraying time",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Best time to spray crops based on weather conditions",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeSlot("7 am", Icons.check_circle, Colors.green),
                _buildTimeSlot("8 am", Icons.check_circle, Colors.green),
                _buildTimeSlot("9 am", Icons.check_circle, Colors.green),
                _buildTimeSlot("10 am", Icons.warning, Colors.orange),
                _buildTimeSlot("12 pm", Icons.cancel, Colors.red),
              ],
            ),
            const SizedBox(height: 32),

            // Weather Forecast Section
            const Text(
              "Next 6 days",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("No rain is forecast this week."),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildForecastTile("Tue", "30°C", Icons.wb_sunny),
                _buildForecastTile("Wed", "31°C", Icons.wb_sunny),
                _buildForecastTile("Thu", "31°C", Icons.wb_sunny),
                _buildForecastTile("Fri", "30°C", Icons.wb_sunny),
                _buildForecastTile("Sat", "30°C", Icons.wb_sunny),
                _buildForecastTile("Sun", "31°C", Icons.wb_sunny),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 8),
        Text(time, style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _buildForecastTile(String day, String temp, IconData icon) {
    return Column(
      children: [
        Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Icon(icon, color: Colors.orange),
        const SizedBox(height: 8),
        Text(temp),
      ],
    );
  }
}

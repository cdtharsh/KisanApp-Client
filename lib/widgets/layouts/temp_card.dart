import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/constants/colors.dart';
import 'package:kisanapp/router/routes.dart'; // Ensure AppRoutes is imported

class TemperatureCard extends StatelessWidget {
  final String? location;
  final String? condition;
  final String? iconUrl;
  final double? temperature;
  final double? windChill;
  final double? heatIndex;
  final bool isDark;
  final VoidCallback? onTap;

  const TemperatureCard({
    super.key,
    this.location,
    this.condition,
    this.iconUrl,
    this.temperature,
    this.windChill,
    this.heatIndex,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else {
            Get.toNamed(
              AppRoutes.sprayCondition,
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isDark ? kDarkCard : kLightCard,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$location',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$condition • $windChill°C / $heatIndex°C',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Image.network(iconUrl ?? '', width: 50, height: 50),
                ],
              ),
              Column(
                children: [
                  Text(
                    '$temperature°C',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

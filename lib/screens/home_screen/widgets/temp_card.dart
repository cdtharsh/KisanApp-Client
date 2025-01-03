import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisanapp/utils/constants/colors.dart';
import 'package:kisanapp/router/routes.dart'; // Ensure AppRoutes is imported

class TemperatureCard extends StatelessWidget {
  final String? location;
  final String? condition;
  final String? iconUrl;
  final num? temperature;
  final num? maxTemp;
  final num? minTemp;
  final bool isDark;
  final VoidCallback? onTap;

  const TemperatureCard({
    super.key,
    this.location,
    this.condition,
    this.iconUrl,
    this.temperature,
    this.maxTemp,
    this.minTemp,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else {
            Get.toNamed(AppRoutes.sprayCondition);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isDark ? kDarkCard : kLightCard,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
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
                  const SizedBox(height: 4),
                  Text(
                    '$condition • $minTemp°C / $maxTemp°C',
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

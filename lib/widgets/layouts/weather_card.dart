import 'package:flutter/material.dart';
import 'package:kisanapp/constants/colors.dart'; // Make sure to include your color constants here
import 'package:shimmer/shimmer.dart'; // Import shimmer package

class WeatherCard extends StatelessWidget {
  final String? location;
  final String? region;
  final String? country;
  final double? latitude;
  final double? longitude;
  final String? timezone;
  final String? condition;
  final String? iconUrl;
  final double? temperature;
  final double? feelsLike;
  final double? windSpeed;
  final double? humidity;
  final double? pressure;
  final double? windChill;
  final double? heatIndex;
  final double? dewpoint;
  final double? visibility;
  final double? gustSpeed;
  final int? uvIndex;

  const WeatherCard({
    super.key,
    this.location,
    this.region,
    this.country,
    this.latitude,
    this.longitude,
    this.timezone,
    this.condition,
    this.iconUrl,
    this.temperature,
    this.feelsLike,
    this.windSpeed,
    this.humidity,
    this.pressure,
    this.windChill,
    this.heatIndex,
    this.dewpoint,
    this.visibility,
    this.gustSpeed,
    this.uvIndex,
  });

  @override
  Widget build(BuildContext context) {
    // If weather data is not available, show shimmer effect
    if (location == null) {
      return _ShimmerWeatherCard();
    }

    // If weather data is available, show actual data
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location and Region Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kDarkPurple, // Use your custom color here
                      ),
                    ),
                    Text(
                      '$region, $country',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      'Lat: $latitude, Lon: $longitude',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      'Timezone: $timezone',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.location_on,
                  color: kDarkPurple, // Match the color with your theme
                  size: 30,
                ),
              ],
            ),
            SizedBox(height: 20),

            // Weather Condition with Icon
            Row(
              children: [
                Image.network(
                  iconUrl!,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 10),
                Text(
                  condition!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kDarkPurple,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Temperature and Feels Like
            Row(
              children: [
                Text(
                  '$temperature°C',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kDarkPurple,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Feels like: $feelsLike°C',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            // Wind Speed, Humidity, and Pressure
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _WeatherDetail(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '$windSpeed km/h',
                ),
                _WeatherDetail(
                  icon: Icons.opacity,
                  label: 'Humidity',
                  value: '$humidity%',
                ),
                _WeatherDetail(
                  icon: Icons.speed,
                  label: 'Pressure',
                  value: '$pressure mb',
                ),
              ],
            ),
            SizedBox(height: 15),

            // Wind Chill, Heat Index, Dew Point, and Visibility
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _WeatherDetail(
                  icon: Icons.ac_unit,
                  label: 'Wind Chill',
                  value: '$windChill°C',
                ),
                _WeatherDetail(
                  icon: Icons.thermostat_outlined,
                  label: 'Heat Index',
                  value: '$heatIndex°C',
                ),
                _WeatherDetail(
                  icon: Icons.water_drop,
                  label: 'Dew Point',
                  value: '$dewpoint°C',
                ),
              ],
            ),
            SizedBox(height: 15),

            // Visibility and Gust Speed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _WeatherDetail(
                  icon: Icons.visibility,
                  label: 'Visibility',
                  value: '$visibility km',
                ),
                _WeatherDetail(
                  icon: Icons.gesture,
                  label: 'Gust Speed',
                  value: '$gustSpeed km/h',
                ),
              ],
            ),
            SizedBox(height: 15),

            // UV Index
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'UV Index: $uvIndex',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kDarkPurple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kDarkPurple,
          size: 30,
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: kDarkPurple,
          ),
        ),
      ],
    );
  }
}

// Shimmer Effect for Weather Card when data is loading
class _ShimmerWeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmering Location and Region Information
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 24,
                        width: 120,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 16,
                        width: 100,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Shimmering Weather Condition and Icon
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 80,
                    height: 18,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Shimmering Temperature and Feels Like
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 100,
                    height: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 15),

              // Shimmering Wind Speed, Humidity, and Pressure
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ShimmerDetail(),
                  _ShimmerDetail(),
                  _ShimmerDetail(),
                ],
              ),
              SizedBox(height: 15),

              // Shimmering Wind Chill, Heat Index, Dew Point, and Visibility
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ShimmerDetail(),
                  _ShimmerDetail(),
                  _ShimmerDetail(),
                ],
              ),
              SizedBox(height: 15),

              // Shimmering UV Index
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _ShimmerDetail(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Shimmer Effect for individual weather detail
class _ShimmerDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        Container(
          width: 40,
          height: 12,
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        Container(
          width: 40,
          height: 14,
          color: Colors.grey,
        ),
      ],
    );
  }
}

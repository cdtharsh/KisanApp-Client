import 'package:flutter/material.dart';
import 'package:kisanapp/constants/colors.dart';
import 'weather_detail_model.dart';

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
  final bool isDark;

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
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: isDark ? kDarkCard : kLightCard,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _locationInfo(),
            SizedBox(height: 20),
            _weatherCondition(),
            SizedBox(height: 20),
            _temperatureFeelsLike(),
            SizedBox(height: 15),
            _weatherDetailsRow(),
          ],
        ),
      ),
    );
  }

  Widget _locationInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location ?? 'Loading...',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? kLightPrimary : kDarkCharcoal),
            ),
            Text('$region, $country',
                style: TextStyle(fontSize: 16, color: kAccentCoolGray)),
            Text('Lat: $latitude, Lon: $longitude',
                style: TextStyle(fontSize: 14, color: kAccentCoolGray)),
            Text('Timezone: $timezone',
                style: TextStyle(fontSize: 14, color: kAccentCoolGray)),
          ],
        ),
        Icon(Icons.location_on,
            color: isDark ? kLightPrimary : Colors.redAccent, size: 30),
      ],
    );
  }

  Widget _weatherCondition() {
    return Row(
      children: [
        Image.network(iconUrl ?? 'https://via.placeholder.com/50',
            width: 50, height: 50),
        SizedBox(width: 10),
        Text(condition ?? 'Loading...',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isDark ? kLightPrimary : kDarkCharcoal)),
      ],
    );
  }

  Widget _temperatureFeelsLike() {
    return Row(
      children: [
        Text('$temperature°C',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: isDark ? kVividBlue : kVividBlue)),
        SizedBox(width: 10),
        Text('Feels like: $feelsLike°C',
            style: TextStyle(fontSize: 16, color: kAccentCoolGray)),
      ],
    );
  }

  Widget _weatherDetailsRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WeatherDetail(
                icon: Icons.air, label: 'Wind', value: '$windSpeed km/h'),
            WeatherDetail(
                icon: Icons.opacity, label: 'Humidity', value: '$humidity%'),
            WeatherDetail(
                icon: Icons.speed, label: 'Pressure', value: '$pressure mb'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WeatherDetail(
                icon: Icons.ac_unit,
                label: 'Wind Chill',
                value: '$windChill°C'),
            WeatherDetail(
                icon: Icons.thermostat_outlined,
                label: 'Heat Index',
                value: '$heatIndex°C'),
            WeatherDetail(
                icon: Icons.water_drop,
                label: 'Dew Point',
                value: '$dewpoint°C'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WeatherDetail(
                icon: Icons.visibility,
                label: 'Visibility',
                value: '$visibility km'),
            WeatherDetail(
                icon: Icons.warning, label: 'UV Index', value: '$uvIndex'),
            WeatherDetail(
                icon: Icons.gesture,
                label: 'Gust Speed',
                value: '$gustSpeed km/h'),
          ],
        ),
      ],
    );
  }
}

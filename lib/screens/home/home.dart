import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kisanapp/services/weather_api_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/constants/colors.dart';
import 'package:kisanapp/controller/authentication/logout_controller.dart';
import 'package:kisanapp/widgets/layouts/product_coursel.dart';
import 'package:geolocator/geolocator.dart'; // Import the geolocator package
import 'package:shimmer/shimmer.dart';

import '../../controller/data/user_data_controller.dart';
import '../../widgets/layouts/app_bar.dart';
import '../../widgets/layouts/drawer_left.dart';
import '../../widgets/layouts/information_section.dart';
import '../../widgets/layouts/picture_section.dart';
import '../../widgets/layouts/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController userController = Get.put(UserController());
  final LogoutController logoutController = Get.put(LogoutController());
  final WeatherApiService weatherApiService = WeatherApiService();

  Map<String, dynamic>? weatherData; // Store the weather data
  final List<Map<String, String>> products = [
    {
      'image': 'https://via.placeholder.com/150', // Dummy image URL
      'title': 'Product 1',
      'price': '₹20'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 2',
      'price': '₹30'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 3',
      'price': '₹40'
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 4',
      'price': '₹50'
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  // Method to fetch weather data
  Future<void> _fetchWeatherData() async {
    final box = GetStorage();
    String token = box.read('token');

    // Check if cached weather data exists and is still valid
    final cachedData = box.read('weatherData');
    final cachedTimestamp = box.read('weatherTimestamp');

    if (cachedData != null && cachedTimestamp != null) {
      final DateTime timestamp = DateTime.parse(cachedTimestamp);
      final DateTime currentTime = DateTime.now();
      final Duration difference = currentTime.difference(timestamp);

      // If the cached data is less than 1 hour old, use it
      if (difference.inMinutes < 60) {
        setState(() {
          weatherData = cachedData;
        });
        return; // Skip fetching new data
      }
    }

    try {
      // Get the current location
      Position position = await _getCurrentLocation();
      String lat = position.latitude.toStringAsFixed(2);
      String lon = position.longitude.toStringAsFixed(2);

      // Make the API request
      final weather =
          await weatherApiService.getWeather(lat, lon, token: token);

      setState(() {
        weatherData = weather;
      });

      // Cache the weather data and timestamp
      box.write('weatherData', weather);
      box.write('weatherTimestamp', DateTime.now().toIso8601String());
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String firstName = box.read('firstName') ?? 'Guest';
    String lastName = box.read('lastName') ?? '';
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark ? kDarkPurple : kLavender,
      drawer: CustomDrawer(logoutController: logoutController),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: KAppBar(
                  leadingIcon: Icons.menu,
                  leadingOnPressed: () {
                    _scaffoldKey.currentState
                        ?.openDrawer(); // Open the drawer using the GlobalKey
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'Welcome to the app!',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: kWhiteColor, fontSize: 10),
                      ),
                      // Displaying the user's name with proper capitalization
                      Text(
                        '${capitalize(firstName)} ${capitalize(lastName)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: logoutController.logout,
                      icon: Icon(Icons.logout, size: 30, color: Colors.white),
                    ),
                  ],
                  iconSize: 30.0,
                  titleFontSize: 26.0,
                  titleFontWeight: FontWeight.bold,
                  backgroundColor: Colors.transparent,
                  elevation: 10.0,
                  borderRadius: 25.0,
                  roundBottomLeft: true,
                  roundTopLeft: true,
                  roundBottomRight: true,
                  roundTopRight: true,
                ),
              ),
            ),
            // Weather Display Section in the header
            if (weatherData != null)
              WeatherCard(
                location: weatherData!['location']['name'],
                region: weatherData!['location']['region'],
                country: weatherData!['location']['country'],
                latitude: weatherData!['location']['lat'].toDouble(),
                longitude: weatherData!['location']['lon'].toDouble(),
                timezone: weatherData!['location']['tz_id'],
                condition: weatherData!['current']['condition']['text'],
                iconUrl:
                    'https:${weatherData!['current']['condition']['icon']}',
                temperature: weatherData!['current']['temp_c'].toDouble(),
                feelsLike: weatherData!['current']['feelslike_c'].toDouble(),
                windSpeed: weatherData!['current']['wind_kph'].toDouble(),
                humidity: weatherData!['current']['humidity'].toDouble(),
                pressure: weatherData!['current']['pressure_mb'].toDouble(),
                windChill: weatherData!['current']['windchill_c']?.toDouble() ??
                    0.0, // Using a fallback if null
                heatIndex: weatherData!['current']['heatindex_c']?.toDouble() ??
                    0.0, // Using a fallback if null
                dewpoint: weatherData!['current']['dewpoint_c']?.toDouble() ??
                    0.0, // Using a fallback if null
                visibility: weatherData!['current']['vis_km']?.toDouble() ??
                    0.0, // Using a fallback if null
                gustSpeed: weatherData!['current']['gust_kph']?.toDouble() ??
                    0.0, // Using a fallback if null
                uvIndex: weatherData!['current']['uv']?.toInt() ??
                    0, // Using a fallback if null
              )
            else
              // Show the shimmer effect while the weather data is loading
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 20,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 100,
                        height: 20,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 200,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 8),
            PictureSection(isDark: isDark),
            InformationSectionCard(),
            ProductCarousel(products: products), // Use the products list
            SizedBox(height: 60)
          ],
        ),
      ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // Method to get the current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception('Location permission is denied');
      }
    }

    // Get the current position using LocationSettings for accuracy
    LocationSettings locationSettings = LocationSettings(
      accuracy:
          LocationAccuracy.high, // You can set this to low, medium, or high
      distanceFilter:
          10, // Minimum distance (in meters) to get a new location update
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings, // Adding LocationSettings
    );
  }
}

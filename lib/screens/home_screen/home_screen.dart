import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/utils/constants/colors.dart';
import 'package:kisanapp/screens/login_screen/controller/logout_controller.dart';
import 'package:kisanapp/screens/weather_screen/weather_forcast.dart';
import 'package:kisanapp/widgets/bars/product_coursel.dart';
import 'package:kisanapp/screens/home_screen/widgets/temp_card.dart';
import '../login_screen/provider/user_data_controller.dart';
import '../../models/weather/weather_data_model.dart';
import '../../services/api/weather/helper/fetch_weather.dart';
import '../../widgets/bars/app_bar.dart';
import 'widgets/drawer_left.dart';
import 'widgets/information_section.dart';
import 'widgets/picture_section.dart';
import '../../widgets/animation/shimmer_effect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController userController = Get.put(UserController());
  final LogoutController logoutController = Get.put(LogoutController());
  final WeatherService weatherService = WeatherService();

  WeatherResponse? weatherResponse; // Updated type to WeatherResponse
  final List<Map<String, String>> products = [
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 1',
      'price': '₹20',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 2',
      'price': '₹30',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 3',
      'price': '₹40',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'title': 'Product 4',
      'price': '₹50',
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

    try {
      final weatherJson = await weatherService.fetchWeatherData(token, context);
      setState(() {
        weatherResponse = WeatherResponse.fromJson(weatherJson!);
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
                      const SizedBox(height: 5),
                      Text(
                        'Welcome to the app!',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: kWhiteColor, fontSize: 10),
                      ),
                      Text(
                        '${capitalize(firstName)} ${capitalize(lastName)}',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: logoutController.logout,
                      icon: const Icon(Icons.logout,
                          size: 30, color: Colors.white),
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
            if (weatherResponse != null)
              TemperatureCard(
                onTap: () {
                  Get.to(() => WeatherForcast());
                },
                location: weatherResponse!.location.name,
                temperature: weatherResponse!.current.tempC,
                condition: weatherResponse!.current.condition.text,
                iconUrl: 'https:${weatherResponse!.current.condition.icon}',
                maxTemp: weatherResponse!
                    .forecast.forecastDays[0].dayWeather.maxTempC,
                minTemp: weatherResponse!
                    .forecast.forecastDays[0].dayWeather.minTempC,
                isDark: isDark,
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShimmerWidget(
                  height: 100,
                  width: double.infinity,
                  isDark: isDark,
                ),
              ),
            const SizedBox(height: 8),
            PictureSection(isDark: isDark),
            InformationSectionCard(),
            ProductCarousel(products: products),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

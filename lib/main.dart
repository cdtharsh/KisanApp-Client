import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get_storage/get_storage.dart';
import 'package:kisanapp/controller/authentication/login_data_controller.dart';
import 'package:kisanapp/router/routes.dart';
import 'utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Ensures GetStorage is ready
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 480), // Set this to your design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: BindingsBuilder(() {
            Get.put(UserController());
          }),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
          theme: KAppTheme.lightTheme,
          darkTheme: KAppTheme.darkTheme,
          themeMode: ThemeMode.system,
          defaultTransition: Transition.leftToRightWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}

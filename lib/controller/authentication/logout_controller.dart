import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/startup/welcome_screen.dart';

final box = GetStorage();

void logout() {
  box.remove('token');
  Get.offAll(() => const WelcomeScreen());
}

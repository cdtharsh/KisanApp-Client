import 'package:get/get.dart';

class UserController extends GetxController {
  RxString message = ''.obs;
  RxString token = ''.obs;
  RxMap user = {}.obs;

  // Method to set login data
  void setLoginData(String msg, String token, Map<String, dynamic> user) {
    message.value = msg;
    this.token.value = token;
    this.user.value = user;
  }
}

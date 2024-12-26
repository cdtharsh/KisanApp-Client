import 'package:get/get.dart';

class UserController extends GetxController {
  RxString message = ''.obs;
  RxString token = ''.obs;
  RxMap<String, dynamic> user = <String, dynamic>{}.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString username = ''.obs;
  RxString lastLogin = ''.obs;
  RxString id = ''.obs;

  // Method to set login data
  void setLoginData(String msg, String token, Map<String, dynamic> user) {
    message.value = msg;
    this.token.value = token;

    // Storing user data
    this.user.value = user;
    firstName.value = user['firstName'] ?? '';
    lastName.value = user['lastName'] ?? '';
    email.value = user['email'] ?? '';
    username.value = user['username'] ?? '';
    lastLogin.value = user['lastLogin'] ?? '';
    id.value = user['_id'] ?? '';
  }
}

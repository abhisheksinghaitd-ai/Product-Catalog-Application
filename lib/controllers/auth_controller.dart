import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLoggedIn = false.obs;
  final isLoading = false.obs;

  void login(String email, String password) {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      if (email.isNotEmpty && password.length >= 6) {
        isLoggedIn.value = true;
        isLoading.value = false;
        Get.offAllNamed('/home');
      } else {
        isLoading.value = false;
        Get.snackbar('Login Failed', 'Invalid email or password');
      }
    });
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}

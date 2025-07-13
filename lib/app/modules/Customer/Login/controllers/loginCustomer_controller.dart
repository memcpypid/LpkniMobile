import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

class LogincustomerController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final box = GetStorage();

  var isPasswordHidden = true.obs;
  var rememberMe = false.obs;
  var isLoggedIn = false.obs;

  void onInit() {
    super.onInit();

    rememberMe.value = box.read('rememberMe') ?? false;

    if(rememberMe.value == true) {
      emailController.text = box.read('email');
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Kesalahan', 'Email dan password harus diisi',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    // Simulasi login
    if (email == 'user@mail.com' && password == 'user') {
      box.write('isLoggedIn', true);
      box.write('rememberMe', rememberMe.value);

      if(rememberMe.value == true) {
        box.write('email', email);
      }else{
        box.remove('email');
      }

      Get.snackbar('Success', 'Login berhasil',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      // Navigate to Home Page
      Get.offAllNamed(Routes.HOMECUSTOMER);
    } else {
      Get.snackbar('Kesalahan', 'Email atau password salah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}

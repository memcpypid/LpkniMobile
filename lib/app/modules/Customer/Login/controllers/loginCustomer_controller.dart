// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:lpkni/app/services/api_service.dart';
import 'package:lpkni/app/services/auth_service.dart';

class LogincustomerController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final box = GetStorage();
  // final AuthService auth = AuthService();
  final AuthService auth = Get.find<AuthService>();

  var isPasswordHidden = true.obs;
  var rememberMe = false.obs;
  var isLoggedIn = false.obs;

  var token = ''.obs;
  @override
  void onInit() {
    super.onInit();
    // authServiceFuture = AuthService.create();

    rememberMe.value = box.read('rememberMe') ?? false;

    if (rememberMe.value == true) {
      emailController.text = box.read('email');
    }
  }

  // void initAuth() async {
  //   auth = await AuthService.create();
  // }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // final auth = await AuthService;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Kesalahan', 'Email dan password harus diisi',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return; // 👉 hentikan eksekusi
    }

    try {
      final response = await auth.login(email, password);

      // print("Respon login: $response");

      if (response['status_code'] == 200) {
        // box.write('isLoggedIn', true);
        box.write('rememberMe', rememberMe.value);
        // box.write('data', response['data']);
        // box.write('token', response['token']);
        // box.write('token_refresh', response['token_refresh']);
        // box.write('cookies', response['cookies']);

        if (rememberMe.value == true) {
          box.write('email', email);
        } else {
          box.remove('email');
        }

        Get.snackbar('Success', 'Login berhasil',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        Get.offAllNamed(Routes.HOMECUSTOMER);
      } else {
        print("error login:");
        Get.snackbar('Kesalahan', response['message'] ?? 'Gagal login',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      // Type? poo = auth.pesanEror;
      print("Error during login: $e");
      Get.snackbar('Kesalahan', 'Gagal melakukan login: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}

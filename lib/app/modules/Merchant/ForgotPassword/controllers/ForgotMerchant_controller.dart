import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class ForgotmerchantController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  void sendResetEmail() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email harus diisi',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Simulasi pengiriman email reset password
    Get.snackbar(
      'Success',
      'Link reset password telah dikirim ke email Anda',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.toNamed(Routes.OTPPASSWORDCUSTOMER);
  }
}

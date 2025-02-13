import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class VerifotpcustomerController extends GetxController {
  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final String email = 'user@example.com'; // Simulasi email pengguna

  void verifyOTP() {
    String otpCode = otpControllers.map((controller) => controller.text).join();

    if (otpCode.length < 4) {
      Get.snackbar(
        'Error',
        'Masukkan kode OTP lengkap',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (otpCode == '1234') {
      // Simulasi kode OTP
      Get.snackbar(
        'Success',
        'Verifikasi OTP berhasil',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.toNamed(Routes
          .RESETPASSWORDCUSTOMER); // Navigasi ke halaman utama setelah verifikasi
    } else {
      Get.snackbar(
        'Error',
        'Kode OTP salah',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void resendOTP() {
    Get.snackbar(
      'Info',
      'Kode OTP baru telah dikirim',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }
}

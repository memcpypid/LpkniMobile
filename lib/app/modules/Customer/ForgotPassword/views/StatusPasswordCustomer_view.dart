import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/controllers/StatusPasswordCustomer_controller.dart';

class StatuspasswordcustomerView
    extends GetView<StatuspasswordcustomerController> {
  const StatuspasswordcustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Icon(
                  controller.isSuccess.value ? Icons.check_circle : Icons.error,
                  size: 100,
                  color: controller.isSuccess.value ? Colors.teal : Colors.red,
                )),
            const SizedBox(height: 20),
            Obx(() => Text(
                  controller.isSuccess.value ? 'Selamat!' : 'Gagal!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  controller.isSuccess.value
                      ? 'Kata sandi akun Anda telah berhasil diubah.'
                      : 'Kata sandi gagal diubah. Silakan coba lagi.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.proceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

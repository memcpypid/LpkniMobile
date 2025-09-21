import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/controllers/ForgotCustomer_controller.dart';

class ForgotcustomerView extends GetView<ForgotcustomerController> {
  const ForgotcustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock,
              size: 100,
              color: Colors.teal,
            ),
            const SizedBox(height: 20),
            const Text(
              'Ubah Password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Masukkan alamat email yang terhubung dengan akun Anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: 'Masukkan Email Anda',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                  onPressed: controller.sendResetEmail,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

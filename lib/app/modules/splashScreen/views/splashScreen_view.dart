import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splashScreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Tampilan Home is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

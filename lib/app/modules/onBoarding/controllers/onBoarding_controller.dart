import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  //TODO: Implement HomeController
  final PageController pageController =
      PageController(); // Kontrol untuk PageView
  var currentPage = 0.obs; // State untuk halaman aktif

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void nextPage() {
    if (currentPage.value < 2) {
      // Pastikan tidak melewati halaman terakhir
      pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      Get.offAllNamed(
          '/pilihkategori'); // Setelah halaman terakhir, langsung ke Home
    }
  }

  void updatePage(int index) {
    currentPage.value = index; // Perbarui halaman aktif
  }

  void increment() => count.value++;
}

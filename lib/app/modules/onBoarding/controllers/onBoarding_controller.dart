import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/onBoarding/views/onBoardingSelection_view.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  //TODO: Implement HomeController
  final PageController pageController =
      PageController(); // Kontrol untuk PageView
  var currentPage = 0.obs; // State untuk halaman aktif
  var selectedCategory = "".obs;
  final count = 0.obs;
  final List<Map<String, String>> categories = [
    {
      'title': 'Konsumen',
      'description':
          'Belanja hemat, banyak pilihan! Nikmati kemudahan belanja kebutuhan harian dengan harga terbaik.',
      'image': 'assets/images/swikonsumen.png'
    },
    {
      'title': 'Pemilik Warung',
      'description':
          'Tambah omzet, stok selalu siap! Dapatkan pasokan barang berkualitas dengan harga terjangkau untuk warung Anda.',
      'image': 'assets/images/swimerchant.png'
    },
    {
      'title': 'Grosir',
      'description':
          'Jadi pemasok terpercaya! Jangkau lebih banyak pelanggan dan kembangkan bisnis grosir Anda bersama kami.',
      'image': 'assets/images/swigrosir.png'
    },
    {
      'title': 'Sponsor',
      'description':
          'Maksimalkan brand awareness! Tampilkan produk Anda di platform kami dan raih lebih banyak pelanggan potensial.',
      'image': 'assets/images/swisponsor.png'
    },
  ];
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
      Get.off(
          OnboardingselectionView()); // Setelah halaman terakhir, langsung ke Home
    }
  }

  void updatePage(int index) {
    currentPage.value = index; // Perbarui halaman aktif
  }

  void navigateToPage(String role) {
    selectedCategory.value = role;
    switch (role) {
      case 'Konsumen':
        Get.toNamed(Routes.LANDINGCUSTOMER);
        break;
      case 'Pemilik Warung':
        Get.toNamed(Routes.LANDINGMERCHANT);
        break;
      // case 'Grosir':
      //   Get.toNamed(Routes.GROSIR_PAGE);
      //   break;
      case 'Sponsor':
        // Get.toNamed(Routes.SPONSOR);
        break;
      default:
        break;
    }
  }

  void increment() => count.value++;
}

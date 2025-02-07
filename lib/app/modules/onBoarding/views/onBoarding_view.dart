import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onBoarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          /// **PageView untuk Swipe Onboarding**
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.updatePage,
            itemCount: 3, // Jumlah halaman onboarding
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  /// **Background Image yang bisa dinaikkan**
                  Positioned(
                    top: -120, // Naikkan background jika perlu
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/splashScreen.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// **Navigasi dengan Background Rounded**
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      height: 320,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// **Judul Onboarding**
                          Text(
                            index == 0
                                ? "Aplikasi Pengantaran\nMakanan Tercepat"
                                : index == 1
                                    ? "Makanan Terbaik untuk Anda"
                                    : "Pesan dengan Mudah!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          SizedBox(height: 10),

                          /// **Deskripsi**
                          Text(
                            index == 0
                                ? "Tugas kami adalah memenuhi pesanan Anda dengan makanan paling lezat dan pengantaran yang super cepat."
                                : index == 1
                                    ? "Kami menyediakan makanan dari berbagai restoran dengan kualitas terbaik."
                                    : "Pesan makanan hanya dalam beberapa ketukan dengan aplikasi kami!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),

                          SizedBox(height: 20),

                          /// **Indicator Onboarding (Dot Indicator)**
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (pageIndex) => AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: controller.currentPage.value == pageIndex ? 25 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: controller.currentPage.value == pageIndex
                                        ? Color(0xFF04A981)
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          /// **Tombol Lanjut**
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.nextPage, // Navigasi ke halaman berikutnya
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF04A981),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Obx(
                                () => Text(
                                  controller.currentPage.value == 2 ? "Mulai" : "Lanjut",
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

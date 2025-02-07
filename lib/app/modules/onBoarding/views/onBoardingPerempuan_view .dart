import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onBoarding_controller.dart';

class OnboardingperempuanView  extends GetView<OnboardingController> {
  const OnboardingperempuanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// **Background Image yang dinaikkan**
          Positioned(
            top: -120, // Naikkan background 50 pixel
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/backGround.png',
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
                  /// **Judul**
                  Text(
                    "Semua Makanan\nFavorit Anda",
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
                    "Pesan menu favorit Anda dengan\npengantaran sesuai permintaan.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: 20),

                  /// **Indicator Onboarding (Dot Indicator)**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: index == 1 ? 25 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == 1 ? Color(0xFF04A981) : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  /// **Tombol Lanjut**
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/onboard2');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF04A981),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "Lanjut",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

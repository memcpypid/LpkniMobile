import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onBoarding_controller.dart';
import 'dart:math' as math; // Import for math.sin

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  // Warna tema air mineral
  final Color primaryBlue = const Color(0xFF86AEFF);
  final Color lightBlue = const Color(0xFFB3D9FF);
  final Color darkBlue = const Color(0xFF4A90E2);
  final Color accentBlue = const Color(0xFF1E56A0);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Modern Gradient Background dengan floating elements
          _buildModernBackground(),

          // PageView untuk Swipe Gambar Onboarding saja
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.45, // Sesuaikan agar gambar di atas card
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.updatePage,
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildOnboardingImage(context, index);
              },
            ),
          ),

          // Bottom Content Card yang statis
          _buildBottomContentCard(context, controller),

          // Skip Button
          // _buildSkipButton(controller),
        ],
      ),
    );
  }

  Widget _buildModernBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryBlue.withOpacity(0.8),
            primaryBlue,
            darkBlue,
            accentBlue,
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Floating water drops decoration
          ...List.generate(12, (index) => _buildFloatingWaterDrop(index)),

          // Wave effect at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: WavePainter(),
              size: Size(double.infinity, 100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingWaterDrop(int index) {
    final positions = [
      {'top': 80.0, 'left': 30.0, 'size': 20.0},
      {'top': 150.0, 'right': 40.0, 'size': 16.0},
      {'top': 120.0, 'left': 100.0, 'size': 24.0},
      {'top': 200.0, 'right': 80.0, 'size': 18.0},
      {'top': 90.0, 'right': 120.0, 'size': 14.0},
      {'top': 180.0, 'left': 200.0, 'size': 22.0},
      {'top': 250.0, 'left': 50.0, 'size': 16.0},
      {'top': 300.0, 'right': 60.0, 'size': 20.0},
      {'top': 220.0, 'left': 150.0, 'size': 18.0},
      {'top': 280.0, 'right': 150.0, 'size': 14.0},
      {'top': 160.0, 'left': 250.0, 'size': 16.0},
      {'top': 320.0, 'left': 300.0, 'size': 12.0},
    ];

    if (index >= positions.length) return SizedBox.shrink();

    final pos = positions[index];

    return Positioned(
      top: pos['top'],
      left: pos['left'],
      right: pos['right'],
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 3 + (index % 3)),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double value, child) {
          return Transform.translate(
            offset: Offset(0, 20 * (0.5 - (value % 1 - 0.5).abs())),
            child: Opacity(
              opacity: 0.1 + (0.2 * (0.5 - (value % 1 - 0.5).abs())),
              child: Icon(
                Icons.water_drop,
                color: Colors.white,
                size: pos['size'] as double,
              ),
            ),
          );
        },
        onEnd: () {
          // Restart animation
        },
      ),
    );
  }

  // Widget _buildSkipButton(OnboardingController controller) {
  //   return Positioned(
  //     top: 50,
  //     right: 20,
  //     child: Obx(() {
  //       if (controller.currentPage.value == 2) return SizedBox.shrink();
  //
  //       return Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white.withOpacity(0.2),
  //           borderRadius: BorderRadius.circular(20),
  //           border: Border.all(color: Colors.white.withOpacity(0.3)),
  //         ),
  //         child: TextButton(
  //           onPressed: () => controller.skipToEnd(),
  //           child: Text(
  //             "Lewati",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }

  Widget _buildOnboardingImage(BuildContext context, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80), // Space for status bar and skip button

        // Main Image with animation
        TweenAnimationBuilder(
          duration: Duration(milliseconds: 800),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * value),
              child: Opacity(
                opacity: value,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      _getImagePath(index),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomContentCard(BuildContext context, OnboardingController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45, // Tinggi card
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Obx(() {
            final currentIndex = controller.currentPage.value;
            return Column(
              children: [
                // Drag indicator
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 30),

                // Title with animation
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 0.5),
                        end: Offset(0, 0),
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    _getTitle(currentIndex),
                    key: ValueKey<int>(currentIndex), // Penting untuk AnimatedSwitcher
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Description with animation
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 0.5),
                        end: Offset(0, 0),
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    _getDescription(currentIndex),
                    key: ValueKey<int>(currentIndex + 100), // Key unik
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 40),

                // Page Indicator
                _buildPageIndicator(controller),
                SizedBox(height: 30),

                // Next Button
                _buildNextButton(controller),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(OnboardingController controller) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (pageIndex) {
        bool isActive = controller.currentPage.value == pageIndex;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(colors: [primaryBlue, darkBlue])
                : null,
            color: isActive ? null : Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
            boxShadow: isActive ? [
              BoxShadow(
                color: primaryBlue.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ] : null,
          ),
        );
      }),
    ));
  }

  Widget _buildNextButton(OnboardingController controller) {
    return Obx(() => Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryBlue, darkBlue],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: controller.nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.currentPage.value == 2 ? "Mulai Sekarang" : "Lanjutkan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              controller.currentPage.value == 2
                  ? Icons.rocket_launch_rounded
                  : Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    ));
  }

  String _getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/images/qmas-logo.png';
      case 1:
        return 'assets/product/all-product.png';
      case 2:
        return 'assets/images/family.png';
      default:
        return 'assets/images/qmas-logo.png';
    }
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return "Kesegaran Dimulai dari Sini! 💧";
      case 1:
        return "Beragam Pilihan Kemasan 📦";
      case 2:
        return "Untuk Keluarga Indonesia 👨‍👩‍👧‍👦";
      default:
        return "";
    }
  }

  String _getDescription(int index) {
    switch (index) {
      case 0:
        return "QMas hadir untuk keluarga Indonesia dengan air mineral jernih yang menjaga kesehatan dan kebersamaan setiap hari.";
      case 1:
        return "Tersedia dalam berbagai pilihan kemasan, dari botol kecil hingga galon. Siap memenuhi kebutuhan rumah tangga maupun usaha Anda.";
      case 2:
        return "Air mineral QMas, pilihan sehat untuk seluruh keluarga. Rasa segar dan kualitas terjaga di setiap tegukan.";
      default:
        return "";
    }
  }
}

// Custom Wave Painter untuk efek gelombang
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height * 0.5);

    // Create wave effect
    for (double x = 0; x <= size.width; x++) {
      double y = size.height * 0.5 +
          (size.height * 0.3) *
              (0.5 + 0.5 * math.sin(x / size.width * 2 * math.pi)) *
              (1 - x / size.width);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpkni/app/modules/splashScreen/controllers/splashScreen_controller.dart';
import 'package:lpkni/app/routes/app_pages.dart';
import 'dart:math' as math;
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final box = GetStorage();

  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _waveController;
  late AnimationController _dropController;
  late AnimationController _bubbleController;
  late AnimationController _rippleController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _dropAnimation;
  late Animation<double> _bubbleAnimation;
  late Animation<double> _rippleAnimation;

  // Warna tema air
  final Color primaryColor = Color(0xFF86AEFF);
  final Color waterBlue = Color(0xFF4A90E2);
  final Color lightBlue = Color(0xFFB3D9FF);
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _waveController;
  late AnimationController _dropController;
  late AnimationController _bubbleController;
  late AnimationController _rippleController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _dropAnimation;
  late Animation<double> _bubbleAnimation;
  late Animation<double> _rippleAnimation;

  // Warna tema air
  final Color primaryColor = Color(0xFF86AEFF);
  final Color waterBlue = Color(0xFF4A90E2);
  final Color lightBlue = Color(0xFFB3D9FF);

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _initAnimations();
    _playMusic();
    // Get.put(SplashscreenController());
    Get.find<SplashscreenController>();
    // _navigateToHome();
    // Timer(const Duration(seconds: 2));
    // Future.delayed(Duration(seconds: 5));
  }

  // _initStart() async {}

  _initAnimations() {
    // Fade Animation
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Scale Animation
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Wave Animation
    _waveController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _waveAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.linear),
    );

    // Water Drop Animation
    _dropController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _dropAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _dropController, curve: Curves.easeInOut),
    );

    // Bubble Animation
    _bubbleController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat();
    _bubbleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bubbleController, curve: Curves.linear),
    );

    // Ripple Animation
    _rippleController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    // Start animations
    _fadeController.forward();
    _scaleController.forward();
  }

  _playMusic() async {
    try {
      await _audioPlayer.play(AssetSource('music/sound2.wav'));
    } catch (e) {
      print('Error playing audio: $e');
    }
    try {
      await _audioPlayer.play(AssetSource('music/sound2.wav'));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  // _navigateToHome() async {
    
  //   await Future.delayed(Duration(seconds: 5));
  //   if (box.read('isLoggedIn') == true) {
  //     Get.offAllNamed(Routes.HOMECUSTOMER);
  //   } else {
  //     Get.offAllNamed(Routes.ONBOARDING);
  //   }
  // }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _waveController.dispose();
    _dropController.dispose();
    _bubbleController.dispose();
    _rippleController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _waveController.dispose();
    _dropController.dispose();
    _bubbleController.dispose();
    _rippleController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightBlue.withOpacity(0.3),
              primaryColor.withOpacity(0.6),
              primaryColor,
              waterBlue,
              Color(0xFF2E5BBA),
            ],
            stops: [0.0, 0.2, 0.5, 0.8, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated Water Waves at Top
            _buildWaterWaves(),

            // Floating Water Bubbles
            ...List.generate(8, (index) => _buildFloatingBubble(index)),

            // Water Drops Animation
            ...List.generate(5, (index) => _buildWaterDrop(index)),

            // Water Ripples
            _buildWaterRipples(),

            // Main content
            Center(
              child: AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Water Bottle Icon dengan animasi
                              AnimatedBuilder(
                                animation: _bubbleAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: 1.0 + (_bubbleAnimation.value * 0.1),
                                    child: Container(
                                      width: 140,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.9),
                                            lightBlue.withOpacity(0.7),
                                            primaryColor.withOpacity(0.5),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            blurRadius: 25,
                                            spreadRadius: 8,
                                          ),
                                          BoxShadow(
                                            color:
                                                primaryColor.withOpacity(0.3),
                                            blurRadius: 15,
                                            spreadRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.water_drop_rounded,
                                        size: 70,
                                        color: primaryColor,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: 40),

                              // App Name dengan efek air
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.2),
                                      Colors.white.withOpacity(0.1),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'Q-Mas M Store',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 8,
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 16),

                              // Tagline
                              Text(
                                'Pure • Fresh • Healthy',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 3,
                                ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                'Premium Mineral Water',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                ),
                              ),

                              SizedBox(height: 60),

                              // Loading indicator dengan tema air
                              Container(
                                width: 60,
                                height: 60,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      strokeWidth: 4,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white.withOpacity(0.8),
                                      ),
                                      backgroundColor:
                                          Colors.white.withOpacity(0.2),
                                    ),
                                    Icon(
                                      Icons.opacity,
                                      color: Colors.white.withOpacity(0.6),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 20),

                              Text(
                                'Loading Fresh Water...',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            // Version info at bottom
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Version 1.0.0 • Premium Quality',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterWaves() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 200,
      child: AnimatedBuilder(
        animation: _waveAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: WavePainter(_waveAnimation.value, primaryColor),
            size: Size(double.infinity, 200),
          );
        },
      ),
    );
  }

  Widget _buildWaterRipples() {
    return Positioned(
      bottom: 100,
      left: 50,
      child: AnimatedBuilder(
        animation: _rippleAnimation,
        builder: (context, child) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white
                    .withOpacity(0.3 * (1 - _rippleAnimation.value)),
                width: 2,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingBubble(int index) {
    final sizes = [20.0, 35.0, 15.0, 28.0, 12.0, 40.0, 18.0, 25.0];
    final delays = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5];

    return AnimatedBuilder(
      animation: _bubbleAnimation,
      builder: (context, child) {
        double animationValue = (_bubbleAnimation.value + delays[index]) % 1.0;
        return Positioned(
          left: 50.0 + (index * 40.0),
          bottom: -50 +
              (animationValue * (MediaQuery.of(context).size.height + 100)),
          child: Opacity(
            opacity: 0.6 * (1 - animationValue),
            child: Container(
              width: sizes[index],
              height: sizes[index],
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWaterDrop(int index) {
    final positions = [80.0, 150.0, 220.0, 290.0, 360.0];
    final delays = [0.0, 0.4, 0.8, 1.2, 1.6];

    return AnimatedBuilder(
      animation: _dropAnimation,
      builder: (context, child) {
        double animationValue = (_dropAnimation.value + delays[index]) % 1.0;
        return Positioned(
          left: positions[index],
          top: -20 + (animationValue * 200),
          child: Opacity(
            opacity: 0.7 * (1 - animationValue),
            child: Icon(
              Icons.water_drop,
              color: Colors.white.withOpacity(0.6),
              size: 16,
            ),
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  WavePainter(this.animationValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Create wave effect
    path.moveTo(0, size.height * 0.7);

    for (double x = 0; x <= size.width; x++) {
      double y = size.height * 0.7 +
          math.sin((x / size.width * 2 * math.pi) + animationValue) * 20 +
          math.sin((x / size.width * 4 * math.pi) + animationValue * 2) * 10;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

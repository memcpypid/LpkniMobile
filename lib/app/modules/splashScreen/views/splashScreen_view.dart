import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart'; 

// import 'package:lpkni/app/modules/home/views/home_view.dart';
import 'package:lpkni/app/modules/onBoarding/views/onBoarding_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playMusic();
    _navigateToHome();
  }

  _playMusic() async {
    await _audioPlayer.play(AssetSource('music/sound2.wav'));
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5));
    Get.offAll(() => OnboardingView());
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// **Background Image**
          Positioned.fill(
            child: Image.asset(
              'assets/images/splashScreen.png',
              fit: BoxFit.cover, // Agar gambar menyesuaikan layar
            ),
          ),

          /// **Teks atau Logo bisa ditambahkan di sini jika perlu**

        ],
      ),
    );
  }
}

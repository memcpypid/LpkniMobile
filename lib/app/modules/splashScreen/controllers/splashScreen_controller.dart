import 'dart:developer';

import 'package:get/get.dart';
// import 'package:lpkni/app/services/api_service.dart';
import 'package:lpkni/app/services/auth_service.dart';

class SplashscreenController extends GetxController {
  final AuthService auth = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _checkSesion();
  }

  Future<void> _checkSesion() async {
    log("cek sesi...");
    await Future.delayed(const Duration(seconds: 3)); // biar animasi keliatan
    try {
      final isExpired = await auth.isTokenExpired();
      if (!isExpired) {
        Get.offAllNamed('/home-customer');
      } else {
        final isRefreshExpired = await auth.isRefreshTokenExpired();
        if (!isRefreshExpired) {
          // await auth.refreshToken();
          Get.offAllNamed('/home-customer');
        } else {
          await auth.cookieJar.deleteAll();
          Get.offAllNamed('/onboarding');
        }
      }
    } catch (e) {
      print("error check sesion $e");
      Get.offAllNamed('/onboarding');
      throw Exception("error ${e.toString()}");
    }
  }
}

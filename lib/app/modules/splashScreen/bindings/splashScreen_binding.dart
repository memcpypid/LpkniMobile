import 'package:get/get.dart';

import '../controllers/splashScreen_controller.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreenController>(
      () => SplashscreenController(),
    );
  }
}

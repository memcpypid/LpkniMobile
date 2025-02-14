import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Landing/controllers/LandingMerchant_controller.dart';

class LandingmerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingmerchantController>(
      () => LandingmerchantController(),
    );
  }
}

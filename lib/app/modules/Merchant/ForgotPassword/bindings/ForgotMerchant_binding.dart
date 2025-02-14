import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/controllers/ForgotMerchant_controller.dart';

class ForgotmerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotmerchantController>(
      () => ForgotmerchantController(),
    );
  }
}

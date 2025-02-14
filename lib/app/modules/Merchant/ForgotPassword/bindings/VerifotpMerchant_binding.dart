import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/controllers/VerifotpMerchant_controller.dart';

class VerifotpmerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifotpmerchantController>(
      () => VerifotpmerchantController(),
    );
  }
}

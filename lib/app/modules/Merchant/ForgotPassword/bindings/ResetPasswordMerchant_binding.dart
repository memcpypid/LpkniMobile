import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/controllers/ResetPasswordMerchant_controller.dart';

class ResetpasswordmerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetpasswordmerchantController>(
      () => ResetpasswordmerchantController(),
    );
  }
}

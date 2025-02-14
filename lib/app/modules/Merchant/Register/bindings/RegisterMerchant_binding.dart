import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Register/controllers/RegisterMerchant_controller.dart';

class RegistermerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistermerchantController>(
      () => RegistermerchantController(),
    );
  }
}

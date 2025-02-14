import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Login/controllers/loginMerchant_controller.dart';

class LoginmerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginmerchantController>(
      () => LoginmerchantController(),
    );
  }
}

import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Home/controllers/HomeMerchant_controller.dart';

class HomemerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomemerchantController>(
      () => HomemerchantController(),
    );
  }
}

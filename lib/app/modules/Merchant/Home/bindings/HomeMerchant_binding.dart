import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Home/controllers/HomeMerchant_controller.dart';
import 'package:lpkni/app/modules/Merchant/Menu/controllers/MenuMerchant_controller.dart';

class HomemerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomemerchantController>(
      () => HomemerchantController(),
    );
    Get.lazyPut<MenumerchantController>(
      () => MenumerchantController(),
    );
  }
}

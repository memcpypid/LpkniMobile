import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Menu/controllers/MenuMerchant_controller.dart';

class MenumerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenumerchantController>(
      () => MenumerchantController(),
    );
  }
}

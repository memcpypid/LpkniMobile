import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Menu/controllers/MenuMerchant_controllers.dart';

class MenumerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenumerchantControllers>(
      () => MenumerchantControllers(),
    );
  }
}

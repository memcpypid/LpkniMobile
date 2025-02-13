import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Chat/controllers/MerchantChat_controller.dart';

class MerchantchatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantchatController>(() => MerchantchatController());
  }
}

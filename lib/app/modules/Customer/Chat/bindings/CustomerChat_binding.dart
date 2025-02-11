import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Chat/controllers/CustomerChat_controller.dart';

class CustomerchatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerchatController>(() => CustomerchatController());
  }
}

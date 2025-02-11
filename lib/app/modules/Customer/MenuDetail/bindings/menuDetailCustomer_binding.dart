import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/MenuDetail/controllers/MenuDetailCustomer_controller.dart';

class MenudetailcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenudetailcustomerController>(
        () => MenudetailcustomerController());
  }
}

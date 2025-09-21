import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Register/controllers/RegisterCustomer_controller.dart';

class RegistercustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterCustomerController>(
      () => RegisterCustomerController(),
    );
  }
}

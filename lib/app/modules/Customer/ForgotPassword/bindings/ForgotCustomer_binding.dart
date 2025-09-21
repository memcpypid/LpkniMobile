import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/controllers/ForgotCustomer_controller.dart';

class ForgotcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotcustomerController>(
      () => ForgotcustomerController(),
    );
  }
}

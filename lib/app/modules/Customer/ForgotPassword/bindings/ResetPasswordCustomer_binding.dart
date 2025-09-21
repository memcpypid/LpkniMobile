import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/controllers/ResetPasswordCustomer_controller.dart';

class ResetpasswordcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetpasswordcustomerController>(
      () => ResetpasswordcustomerController(),
    );
  }
}

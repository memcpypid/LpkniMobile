import 'package:get/get.dart';
// import 'package:lpkni/app/modules/Customer/ForgotPassword/controllers/ForgotCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/controllers/StatusPasswordCustomer_controller.dart';

class StatuspasswordcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatuspasswordcustomerController>(
      () => StatuspasswordcustomerController(),
    );
  }
}

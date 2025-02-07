import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/controllers/VerifotpCustomer_controller.dart';

class VerifotpcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifotpcustomerController>(
      () => VerifotpcustomerController(),
    );
  }
}

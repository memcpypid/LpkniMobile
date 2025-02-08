import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Landing/controllers/LandingCustomer_controller.dart';

class LandingcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingcustomerController>(
      () => LandingcustomerController(),
    );
  }
}

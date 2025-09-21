import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Checkout/controller/Checkout_controller.dart';
import 'package:lpkni/app/modules/Customer/Profile/controllers/CustomerProfile_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
    Get.lazyPut<CustomerprofileController>(
      () => CustomerprofileController(),
    );
  }
}

import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Menu/Controllers/CustomerMenu_controller.dart';

class CustomermenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomermenuController>(() => CustomermenuController());
    Get.lazyPut<ButtomnavbarController>(() => ButtomnavbarController());
    Get.lazyPut<CartcustomerController>(() => CartcustomerController());
  }
}

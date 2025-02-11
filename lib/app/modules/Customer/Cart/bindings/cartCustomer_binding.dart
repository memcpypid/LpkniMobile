import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import '../controllers/cartCustomer_controller.dart';

class CartcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartcustomerController>(() => CartcustomerController());
    Get.lazyPut<ButtomnavbarController>(() => ButtomnavbarController());
  }
}

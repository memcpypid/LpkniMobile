import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/HomeCustomer_controller.dart';

class HomecustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomecustomerController>(() => HomecustomerController());
    Get.lazyPut<ButtomnavbarController>(() => ButtomnavbarController());
    Get.lazyPut<CartcustomerController>(() => CartcustomerController());
  }
}

import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Products/Controllers/Products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(() => ProductsController());
    Get.lazyPut<ButtomnavbarController>(() => ButtomnavbarController());
    Get.lazyPut<CartcustomerController>(() => CartcustomerController());
  }
}

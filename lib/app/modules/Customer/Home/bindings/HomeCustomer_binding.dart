import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/HomeCustomerfood_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/HomeCustomerNews_controller.dart';

class HomecustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodController>(() => FoodController());
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<ButtomnavbarController>(() => ButtomnavbarController());
    Get.lazyPut<CartcustomerController>(() => CartcustomerController());
  }
}

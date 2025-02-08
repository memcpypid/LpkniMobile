import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/CartCustomer/controllers/cart_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/food_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/news_controller.dart';

class HomecustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodController>(() => FoodController());
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<ButtomnavbarController>(() => ButtomnavbarController());
    Get.lazyPut<CartController>(() => CartController());
  }
}

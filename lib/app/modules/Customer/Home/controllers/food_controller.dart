import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Home/Model/food_model.dart';
import '../../CartCustomer/controllers/cart_controller.dart';

class FoodController extends GetxController {
  final CartController cartController = Get.find<CartController>();

  var newProducts = <FoodItem>[].obs;
  var bestSellers = <FoodItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    newProducts.assignAll([
      FoodItem(
          name: "Rendang Jengkol",
          price: "Rp17.000",
          image: "assets/rendang.png"),
      FoodItem(
          name: "Sate Pak Muh", price: "Rp20.000", image: "assets/sate.png"),
    ]);

    bestSellers.assignAll([
      FoodItem(
          name: "Rendang Jengkol",
          price: "Rp17.000",
          image: "assets/rendang.png"),
      FoodItem(
          name: "Sate Pak Muh", price: "Rp20.000", image: "assets/sate.png"),
      FoodItem(
          name: "Gado Gado", price: "Rp11.000", image: "assets/gado_gado.png"),
      FoodItem(
          name: "Soto Bu Ida", price: "Rp12.000", image: "assets/soto.png"),
      FoodItem(name: "Gudeg", price: "Rp15.999", image: "assets/gudeg.png"),
      FoodItem(
          name: "Nasi Goreng",
          price: "Rp11.000",
          image: "assets/nasi_goreng.png"),
      FoodItem(
          name: "Rendang Paru",
          price: "Rp15.000",
          image: "assets/rendang_paru.png"),
      FoodItem(
          name: "Mie Aceh", price: "Rp12.000", image: "assets/mie_aceh.png"),
    ]);
  }

  void toggleCart(FoodItem product) {
    if (cartController.cartItems.any((item) => item.product == product)) {
      cartController.removeFromCart(product);
    } else {
      cartController.addToCart(product);
    }
    update();
  }
}

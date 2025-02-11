import 'package:get/get.dart';

class MenudetailcustomerController extends GetxController {
  var quantity = 1.obs;
  var spicyLevel = 0.0.obs;
  var isFavorite = false.obs;

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void updateSpicyLevel(double value) {
    spicyLevel.value = value;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}

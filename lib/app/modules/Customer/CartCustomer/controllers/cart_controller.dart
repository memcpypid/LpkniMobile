import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/CartCustomer/model/cart_model.dart';
import 'package:lpkni/app/modules/Customer/Home/Model/food_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var deliveryFee = 5000.0;
  var discount = 10000.0; // Simulasi diskon kupon

  void addToCart(FoodItem product) {
    int index = cartItems.indexWhere((item) => item.product == product);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(CartItem(product: product));
    }
    update();
  }

  void removeFromCart(FoodItem product) {
    cartItems.removeWhere((item) => item.product == product);
    update();
  }

  void increaseQuantity(FoodItem product) {
    int index = cartItems.indexWhere((item) => item.product == product);
    if (index >= 0) {
      cartItems[index].quantity += 1;
      update();
    }
  }

  void decreaseQuantity(FoodItem product) {
    int index = cartItems.indexWhere((item) => item.product == product);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        removeFromCart(product);
      }
      update();
    }
  }

  double get subtotal {
    return cartItems.fold(0, (sum, item) {
      return sum +
          (double.parse(
                  item.product.price.replaceAll("Rp", "").replaceAll(".", "")) *
              item.quantity);
    });
  }

  double get totalPrice =>
      (subtotal + deliveryFee - discount).clamp(0, double.infinity);

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
}

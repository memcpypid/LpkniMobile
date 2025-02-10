import 'package:lpkni/app/data/Customer/Model/food_model.dart';

class CartItem {
  final FoodItem product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

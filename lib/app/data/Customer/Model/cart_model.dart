import 'package:lpkni/app/data/Customer/Model/food_model.dart';

class CartItem {
  final String name;
  final String image;
  final String Desc;
  final int soldCount;
  final double rating;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.Desc,
    required this.soldCount,
    required this.rating,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  factory CartItem.fromFoodItem(FoodItem foodItem) {
    return CartItem(
      name: foodItem.name,
      image: foodItem.image,
      Desc: foodItem.Desc,
      soldCount: foodItem.soldCount,
      rating: foodItem.rating,
      price:
          double.parse(foodItem.price.replaceAll("Rp", "").replaceAll(".", "")),
      quantity: 1,
    );
  }

  // ✅ Konversi ke JSON agar bisa disimpan di local storage
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "Desc": Desc,
      "soldCount": soldCount,
      "rating": rating,
      "price": price,
      "quantity": quantity,
    };
  }

  // ✅ Konversi dari JSON agar bisa dibaca dari local storage
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json["name"],
      image: json["image"],
      Desc: json["Desc"],
      soldCount: json["soldCount"],
      rating: json["rating"],
      price: json["price"],
      quantity: json["quantity"],
    );
  }
}

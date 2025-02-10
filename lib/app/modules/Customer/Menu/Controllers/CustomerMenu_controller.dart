import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';

class CustomermenuController extends GetxController {
  // List makanan dengan observables
  var foodItems = <FoodItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMenu();
  }

  // Fungsi untuk mengisi menu
  void loadMenu() {
    foodItems.assignAll([
      FoodItem(
        name: "Rendang Jengkol",
        price: "Rp17.000",
        image: "assets/food/food1.png",
        Desc:
            "Jengkol empuk dengan bumbu rendang khas Padang yang kaya rempah, menggugah selera.",
        rating: 4.2,
        soldCount: 150,
      ),
      FoodItem(
        name: "Sate Pak Muh",
        price: "Rp20.000",
        image: "assets/food/food1.png",
        Desc:
            "Sate ayam dengan bumbu kacang kental, dipanggang dengan arang untuk cita rasa khas.",
        rating: 4.8,
        soldCount: 230,
      ),
      FoodItem(
        name: "Sate Pak Muh",
        price: "Rp20.000",
        image: "assets/food/food1.png",
        Desc:
            "Daging yang lembut dan bumbu khas, membuat sate ini jadi favorit banyak orang.",
        rating: 4.6,
        soldCount: 200,
      ),
      FoodItem(
        name: "Rendang Jengkol",
        price: "Rp17.000",
        image: "assets/food/food1.png",
        Desc:
            "Jengkol empuk dengan bumbu rendang khas Padang yang kaya rempah, menggugah selera.",
        rating: 4.2,
        soldCount: 150,
      ),
      FoodItem(
        name: "Sate Pak Muh",
        price: "Rp20.000",
        image: "assets/food/food1.png",
        Desc:
            "Sate ayam dengan bumbu kacang kental, dipanggang dengan arang untuk cita rasa khas.",
        rating: 4.8,
        soldCount: 230,
      ),
      FoodItem(
        name: "Sate Pak Muh",
        price: "Rp20.000",
        image: "assets/food/food1.png",
        Desc:
            "Daging yang lembut dan bumbu khas, membuat sate ini jadi favorit banyak orang.",
        rating: 4.6,
        soldCount: 200,
      ),
    ]);
  }
}

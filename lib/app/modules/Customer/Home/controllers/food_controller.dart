import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';

class FoodController extends GetxController {
  final CartcustomerController cartController =
      Get.find<CartcustomerController>();

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

    bestSellers.assignAll([
      FoodItem(
        name: "Rendang Jengkol Mantap Enak Boy Enak Sekali hahahaha",
        price: "Rp17.000",
        image: "assets/food/food1.png",
        Desc:
            "Jengkol yang dimasak perlahan dalam bumbu rendang kaya rempah, menggoda lidah.",
        rating: 4.3,
        soldCount: 180,
      ),
      FoodItem(
        name: "Sate Pak Muh",
        price: "Rp20.000",
        image: "assets/food/food1.png",
        Desc:
            "Sate ayam yang lezat, disajikan dengan saus kacang kental dan lontong.",
        rating: 4.7,
        soldCount: 250,
      ),
      FoodItem(
        name: "Gado Gado",
        price: "Rp11.000",
        image: "assets/food/food1.png",
        Desc:
            "Salad khas Indonesia dengan aneka sayuran segar, disiram saus kacang gurih.",
        rating: 4.5,
        soldCount: 190,
      ),
      FoodItem(
        name: "Soto Bu Ida",
        price: "Rp12.000",
        image: "assets/food/food1.png",
        Desc:
            "Kuah kuning gurih dengan suwiran ayam, bihun, dan taburan bawang goreng.",
        rating: 4.6,
        soldCount: 220,
      ),
      FoodItem(
        name: "Gudeg",
        price: "Rp15.999",
        image: "assets/food/food1.png",
        Desc:
            "Nangka muda yang dimasak dengan santan, manis dan gurih, khas Yogyakarta.",
        rating: 4.4,
        soldCount: 210,
      ),
      FoodItem(
        name: "Nasi Goreng",
        price: "Rp11.000",
        image: "assets/food/food1.png",
        Desc:
            "Nasi goreng spesial dengan bumbu khas, dilengkapi dengan telur mata sapi.",
        rating: 4.3,
        soldCount: 300,
      ),
      FoodItem(
        name: "Rendang Paru",
        price: "Rp15.000",
        image: "assets/food/food1.png",
        Desc:
            "Paru sapi empuk yang dimasak dalam bumbu rendang kental, kaya rasa.",
        rating: 4.5,
        soldCount: 170,
      ),
      FoodItem(
        name: "Mie Aceh",
        price: "Rp12.000",
        image: "assets/food/food1.png",
        Desc:
            "Mie tebal dengan kuah kari kental dan rempah-rempah khas Aceh, pedas dan nikmat.",
        rating: 4.6,
        soldCount: 200,
      ),
    ]);
  }
}

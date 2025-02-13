import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpkni/app/data/Merchant/Model/Merchantfood_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class MenumerchantController extends GetxController {
  var foodList = <FoodItem>[].obs;
  var searchQuery = "".obs;
  final storage = GetStorage(); // 🔥 Inisialisasi GetStorage

  @override
  void onInit() {
    super.onInit();
    loadFoodData(); // ✅ Load data saat aplikasi dibuka
  }

  // 🔹 Load Data dari Local Storage
  void loadFoodData() {
    List<dynamic>? storedFood = storage.read<List<dynamic>>("foodList");
    if (storedFood != null) {
      foodList.assignAll(storedFood
          .map((item) => FoodItem.fromJson(jsonDecode(item)))
          .toList());
    } else {
      _loadInitialData();
    }
  }

  // 🔹 Data Dummy Jika Belum Ada
  void _loadInitialData() {
    foodList.assignAll([
      FoodItem(
        id: const Uuid().v4(),
        name: "Rendang Jengkol",
        description:
            "Rendang jengkol adalah varian rendang yang menggunakan jengkol sebagai bahan utama.",
        price: 17000,
        image: "assets/food/food2.png",
        tag: "Makanan",
        quantity: 10,
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: "Ayam Geprek",
        description:
            "Ayam goreng crispy yang dihancurkan dengan sambal bawang pedas, cocok untuk pencinta pedas.",
        price: 25000,
        image: "assets/food/food2.png",
        tag: "Makanan",
        quantity: 15,
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: "Nasi Goreng Spesial",
        description:
            "Nasi goreng dengan campuran daging ayam, telur, dan bumbu khas yang lezat.",
        price: 20000,
        image: "assets/food/food2.png",
        tag: "Makanan",
        quantity: 8,
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: "Mie Ayam Bakso",
        description:
            "Mie ayam dengan kuah gurih, topping ayam kecap, dan tambahan bakso kenyal.",
        price: 18000,
        image: "assets/food/food2.png",
        tag: "Makanan",
        quantity: 20,
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: "Sate Ayam Madura",
        description:
            "Sate ayam khas Madura dengan bumbu kacang gurih dan lontong.",
        price: 30000,
        image: "assets/food/food2.png",
        tag: "Makanan",
        quantity: 12,
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: "Es Teh Manis",
        description:
            "Es teh segar dengan rasa manis pas dan menyegarkan tenggorokan.",
        price: 5000,
        image: "assets/food/food2.png",
        tag: "Minuman",
        quantity: 50,
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: "Es Jeruk Peras",
        description:
            "Es jeruk peras alami tanpa tambahan gula, segar dan kaya vitamin C.",
        price: 8000,
        image: "assets/food/food2.png",
        tag: "Minuman",
        quantity: 30,
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: "Martabak Manis Coklat Keju",
        description:
            "Martabak manis dengan topping coklat lumer dan keju yang lezat.",
        price: 35000,
        image: "assets/food/food2.png",
        tag: "Camilan",
        quantity: 5,
      ),
      FoodItem(
        id: const Uuid().v4(),
        name: "Pisang Goreng Crispy",
        description:
            "Pisang goreng dengan lapisan crispy yang renyah dan manis.",
        price: 12000,
        image: "assets/food/food2.png",
        tag: "Camilan",
        quantity: 10,
      ),
    ]);

    saveFoodData(); // ✅ Simpan ke local storage pertama kali
  }

  // 🔹 Simpan Data ke Local Storage
  void saveFoodData() {
    List<String> storedFood =
        foodList.map((item) => jsonEncode(item.toJson())).toList();
    storage.write("foodList", storedFood);
  }

  // 🔹 Tambah Makanan Baru
  void addFood(FoodItem food) {
    foodList.add(food);
    saveFoodData(); // ✅ Simpan setelah menambah
    foodList.refresh(); // 🔥 Pastikan UI diperbarui
  }

  // 🔹 Edit Makanan Berdasarkan ID
  void editFood(String id, FoodItem updatedFood) {
    int index = foodList.indexWhere((food) => food.id == id);
    if (index != -1) {
      foodList[index] = updatedFood;
      saveFoodData(); // ✅ Simpan setelah update
    }
  }

  // 🔹 Hapus Makanan
  void deleteFood(String id) {
    foodList.removeWhere((food) => food.id == id);
    saveFoodData(); // ✅ Simpan setelah hapus
    foodList.refresh(); // 🔥 Pastikan UI diperbarui
  }

  // 🔹 Update Data Makanan (Alternatif dari editFood)
  void updateFood(String id,
      {String? name,
      String? description,
      int? price,
      String? image,
      String? tag,
      int? quantity}) {
    int index = foodList.indexWhere((food) => food.id == id);
    if (index != -1) {
      foodList[index] = FoodItem(
        id: id,
        name: name ?? foodList[index].name,
        description: description ?? foodList[index].description,
        price: price ?? foodList[index].price,
        image: image ?? foodList[index].image,
        tag: tag ?? foodList[index].tag,
        quantity: quantity ?? foodList[index].quantity,
      );
      saveFoodData(); // ✅ Simpan setelah update
      foodList.refresh(); // 🔥 Pastikan UI diperbarui
    }
  }

  // 🔹 Filter Berdasarkan Pencarian
  List<FoodItem> get filteredFoodList {
    if (searchQuery.isEmpty) {
      return foodList;
    } else {
      return foodList
          .where((food) =>
              food.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }
}

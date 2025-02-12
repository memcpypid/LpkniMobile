import 'package:get/get.dart';
import 'package:lpkni/app/data/Merchant/Model/Merchantfood_model.dart';
import 'package:lpkni/app/modules/Merchant/Menu/controllers/MenuMerchant_controller.dart';

class HomemerchantController extends GetxController {
  final MenumerchantController foodController =
      Get.find(); // ✅ Ambil controller utama
  var foodList = <FoodItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFoodData();
    _listenToFoodList();
  }

  void loadFoodData() {
    foodList.assignAll(foodController.foodList);
  }

  // 🔹 Sinkronisasi agar perubahan di `MenumerchantController` langsung diperbarui di Home Merchant
  void _listenToFoodList() {
    ever(foodController.foodList, (_) {
      foodList.assignAll(foodController.foodList);
    });
  }
}

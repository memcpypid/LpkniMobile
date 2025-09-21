import 'package:get/get.dart';
import 'package:lpkni/app/services/api_service.dart';

class MenudetailcustomerController extends GetxController {
  late ApiService api = Get.find<ApiService>();
    var quantity = 1.obs;
  var spicyLevel = 0.0.obs;
  var isFavorite = false.obs;
  var isSuccess = false.obs;

  Future<void> addToCart(String productID, String gudangID, int qty) async {
    print("menambhakna produk ke keranjang");
    try {
      final result = await api.addToCart(productID, gudangID, qty);
      print(result);
      if (result["status_code"] == 200) {
        isSuccess.value = true;
        Get.back();
        // await fetchCart(); // refresh isi keranjang
      } else {
        Get.snackbar("Kesalahan Sistem", "Produk gagal dimasukkan.");
      }
    } catch (e) {
      Get.snackbar("Kesalahan", "Gagal memasukkan produk: $e");
    }
  }

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

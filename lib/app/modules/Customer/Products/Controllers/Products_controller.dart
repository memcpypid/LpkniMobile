import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/product_model.dart';
// import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
// import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/services/api_service.dart';
import 'package:lpkni/app/services/auth_service.dart';

class ProductsController extends GetxController {
  late final ApiService api;
  late final AuthService auth;

  var produkList = <Produk>[].obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();
  var isSuccess = false.obs;

  int currentPage = 1;
  bool hasMore = true; // awalnya true

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    api = Get.find<ApiService>();
    auth = Get.find<AuthService>();
    getProduk(); // load pertama

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading.value &&
          hasMore) {
        getProduk(loadMore: true);
      }
    });
  }

    @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> getProduk({bool loadMore = false}) async {
    if (isLoading.value) return;

    if (!hasMore && loadMore) return;

    isLoading.value = true;
    try {
      // contoh API paginasi
      final newProduk = await api.getProducts(page: currentPage);

      if (loadMore) {
        produkList.addAll(newProduk);
      } else {
        produkList.value = newProduk;
      }

      if (newProduk.isEmpty) {
        hasMore = false;
      } else {
        currentPage++;
      }

      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCart(String productID, String gudangID, int qty) async {
    try {
      final result = await api.addToCart(productID, gudangID, qty);

      if (result["status_code"] == 200) {
        isSuccess.value = true;
      } else {
        Get.snackbar("Kesalahan Sistem", "Produk gagal dimasukkan.");
      }
    } catch (e) {
      Get.snackbar("Kesalahan Sistem", "Gagal memasukkan produk ke keranjang.");
    }
  }
}

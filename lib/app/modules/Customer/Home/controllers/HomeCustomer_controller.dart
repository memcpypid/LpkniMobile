import 'dart:developer';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/product_model.dart';
import 'package:lpkni/app/data/Customer/Model/news_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/services/api_service.dart';
import 'package:lpkni/app/services/auth_service.dart';

class HomecustomerController extends GetxController {
  late final CartcustomerController cartController = Get.find<CartcustomerController>();
  late final ApiService apiService = Get.find<ApiService>();
  late AuthService auth = Get.find<AuthService>();

  var newProducts = <Produk>[].obs;
  var bestSellers = <Produk>[].obs;

  List<Produk> _produkList = [];
  bool isLoading = false;
  String? _errorMessage;

  var artikelList = <ArtikelModel>[].obs;

  List<Produk> get produkList => _produkList;
  bool get loading => isLoading;
  String? get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> _initData() async {
  await getNews();
  await getProduk();
}

  Future<void> refreshData() async {
    // Simulasi delay saat mengambil data
    await Future.delayed(const Duration(seconds: 2));
    // await
    // await auth.refreshToken();
    getNews();
    getProduk();
  }

  Future<void> getProduk() async {
    isLoading = true;

    try {
      _produkList = await apiService.getProducts(limit: 4);
      // log(_produkList as String);
      newProducts.assignAll(_produkList);
      log("produk terbaru: ${newProducts}");
      _errorMessage = null;
      isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> getNews() async {
    try {
      // isLoading.value = true;

      final response = await apiService.getNews();
      artikelList.assignAll(response.data); // simpan ke observable list

      print("Jumlah berita: ${artikelList.length}");
    } catch (e) {
      print("Error ambil berita: $e");
      Get.snackbar("Kesalahan", e.toString());
    } finally {
      // isLoading.value = false;
    }
  }
}

import 'dart:developer';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/orderHistory_model.dart';
import 'package:lpkni/app/services/api_service.dart';

class OrderHistoryController extends GetxController {
  late ApiService api = Get.find<ApiService>();

  var orderHistory = <OrderHistory>[].obs;
  var selectedFilter = 'Semua'.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrderHistory();
  }

  Future<void> loadOrderHistory() async {
    try {
      isLoading.value = true;
      final response = await api.getOrderHistory();
      log("respon: ${response['data']}");

      final List<dynamic> data = response["data"] ?? [];
      log("data list: ${data}");
      orderHistory.value =
          data.map((e) => OrderHistory.fromJson(e)).toList();

      log("orderHistory vlue: ${orderHistory}");
    } catch (e) {
      log("error ambil order history: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> compliteOrder(String id, String status) async{
    try{
      await api.compliteOrder(id, status);
      Get.snackbar("Sukses", "Berhasil menyelesaikan pesanan");
    }catch (e) {
      log("error menyelesaikan pesanan: $e");
      Get.snackbar("Error", "$e");
    }
  }

  void filterOrders(String filter) {
    selectedFilter.value = filter;
  }

  List<OrderHistory> get filteredOrders {
    log("history filtered: $orderHistory");
    if (selectedFilter.value == 'Semua') {
      return orderHistory;
    }
    return orderHistory
        .where((order) => order.status == selectedFilter.value)
        .toList();
  }
}

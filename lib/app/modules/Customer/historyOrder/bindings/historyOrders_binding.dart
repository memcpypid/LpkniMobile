import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/historyOrder/controllers/historyOrders_controller.dart';

class HistoryordersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHistoryController>(
      () => OrderHistoryController(),
    );
  }
}
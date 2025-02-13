import 'package:get/get.dart';
import 'package:lpkni/app/data/Merchant/Model/notification_model.dart';

class NotificationmerchantController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = [
      NotificationModel(
        title: "Pesanan Dikonfirmasi",
        message:
            "Pesanan Anda telah dikonfirmasi. Harap tunggu hingga pesanan diproses.",
        dateTime: "09-01-2025 07:16",
        icon: "assets/food/food1.png",
        image: "assets/food/food1.png",
      ),
      NotificationModel(
        title: "Promo Spesial!",
        message:
            "Dapatkan diskon 30% untuk semua makanan selama 2 hari ke depan!",
        dateTime: "08-01-2025 15:45",
        icon: "assets/food/food1.png",
      ),
    ];
  }

  void clearNotifications() {
    notifications.clear();
  }
}

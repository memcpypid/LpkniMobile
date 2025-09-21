import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/notification_model.dart';

class NotificationcustomerController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    isLoading.value = true;
    
    // Simulasi loading delay
    Future.delayed(Duration(milliseconds: 500), () {
      notifications.value = [
        NotificationModel(
          title: "Pesanan Dikonfirmasi",
          message: "Pesanan Anda telah dikonfirmasi. Harap tunggu hingga pesanan diproses.",
          dateTime: "09-01-2025 07:16",
          type: "order", // Sesuai dengan _getNotificationIcon
          isRead: false,
          image: "assets/food/food1.png", icon: '',
        ),
        NotificationModel(
          title: "Promo Spesial!",
          message: "Dapatkan diskon 30% untuk semua makanan selama 2 hari ke depan!",
          dateTime: "08-01-2025 15:45",
          type: "promotion",
          isRead: true,
          image: null, // Tidak ada gambar
        ),
        NotificationModel(
          title: "Pembayaran Berhasil",
          message: "Pembayaran untuk pesanan #12345 telah berhasil diproses.",
          dateTime: "08-01-2025 12:30",
          type: "payment",
          isRead: false,
          image: null,
        ),
        NotificationModel(
          title: "Pesan Baru",
          message: "Anda memiliki pesan baru dari customer service.",
          dateTime: "07-01-2025 20:15",
          type: "message",
          isRead: true,
          image: null,
        ),
        NotificationModel(
          title: "Update Sistem",
          message: "Aplikasi telah diperbarui ke versi terbaru. Nikmati fitur-fitur baru!",
          dateTime: "06-01-2025 10:00",
          type: "system",
          isRead: true,
          image: null,
        ),
      ];
      isLoading.value = false;
    });
  }

  void refreshNotifications() async {
    // Simulasi refresh dari server
    await Future.delayed(Duration(seconds: 1));
    loadNotifications();
  }

  void markAsRead(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications[index].isRead = true;
      notifications.refresh(); // Trigger UI update
    }
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification.isRead = true;
    }
    notifications.refresh();
  }

  void deleteNotification(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications.removeAt(index);
    }
  }

  void clearNotifications() {
    notifications.clear();
  }

  // Getter untuk mendapatkan jumlah notifikasi yang belum dibaca
  int get unreadCount {
    return notifications.where((notification) => !notification.isRead).length;
  }

  // Getter untuk mendapatkan notifikasi yang belum dibaca
  List<NotificationModel> get unreadNotifications {
    return notifications.where((notification) => !notification.isRead).toList();
  }
}
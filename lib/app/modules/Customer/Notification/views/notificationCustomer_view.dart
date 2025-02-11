import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Notification/controllers/notificationCustomer_controller.dart';

class NotificationcustomerView extends StatelessWidget {
  final NotificationcustomerController notificationController =
      Get.find<NotificationcustomerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (notificationController.notifications.isEmpty) {
          return _buildEmptyNotification();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            final notification = notificationController.notifications[index];
            return _buildNotificationItem(notification);
          },
        );
      }),
    );
  }

  // ✅ AppBar dengan tombol kembali
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        "Notifikasi",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  // ✅ Jika tidak ada notifikasi, tampilkan tampilan kosong
  Widget _buildEmptyNotification() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty_notification.png", width: 120),
          const SizedBox(height: 10),
          const Text(
            "Belum ada notifikasi",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // ✅ Tampilan item notifikasi
  Widget _buildNotificationItem(notification) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // **Icon Notifikasi**
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.green.shade100,
              child: Image.asset(notification.icon, width: 30),
            ),

            const SizedBox(width: 10),

            // **Isi Notifikasi**
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.message,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification.dateTime,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // **Gambar Notifikasi (Jika Ada)**
            if (notification.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  notification.image!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Chat/controllers/CustomerChat_controller.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class CustomerchatlistView extends StatelessWidget {
  final CustomerchatController chatController =
      Get.find<CustomerchatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 🔥 Background lebih lembut
      appBar: AppBar(
        title: const Text(
          "Pesan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Obx(() {
        return ListView.separated(
          itemCount: chatController.chatList.length,
          itemBuilder: (context, index) {
            final chat = chatController.chatList[index];
            return InkWell(
              onTap: () =>
                  Get.toNamed(Routes.ROOMCHATCUSTOMER, arguments: chat),
              splashColor: Colors.teal.withOpacity(0.1),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  children: [
                    // **Profile Picture**
                    CircleAvatar(
                      backgroundImage: AssetImage(chat.profileImage),
                      radius: 28, // 🔥 Lebih besar
                    ),
                    const SizedBox(width: 12),

                    // **Chat Info (Nama, Last Message, Time)**
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Chat
                          Text(
                            chat.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Pesan Terakhir
                          Text(
                            chat.lastMessage,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              color: chat.unreadCount > 0
                                  ? Colors.black
                                  : Colors
                                      .black54, // 🔥 Beri warna hitam jika unread
                              fontWeight: chat.unreadCount > 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // **Time & Unread Message Badge**
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chat.time,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54),
                        ),
                        const SizedBox(height: 5),

                        // **Unread Badge (Jika ada pesan belum dibaca)**
                        if (chat.unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${chat.unreadCount}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 10, // 🔥 Beri jarak antar item
            thickness: 0.5,
            indent: 70, // 🔥 Agar sejajar dengan avatar
            endIndent: 10,
            color: Colors.grey,
          ),
        );
      }),
    );
  }
}

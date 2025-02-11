import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Chat/controllers/CustomerChat_controller.dart';

class CustomerchatlistView extends StatelessWidget {
  final CustomerchatController chatController =
      Get.find<CustomerchatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pesan"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: chatController.chatList.length,
          itemBuilder: (context, index) {
            final chat = chatController.chatList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(chat.profileImage),
              ),
              title: Text(chat.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(chat.lastMessage, overflow: TextOverflow.ellipsis),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(chat.time, style: const TextStyle(fontSize: 12)),
                  if (chat.unreadCount > 0)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text("${chat.unreadCount}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12)),
                    ),
                ],
              ),
              onTap: () => chatController.openChat(chat),
            );
          },
        );
      }),
    );
  }
}

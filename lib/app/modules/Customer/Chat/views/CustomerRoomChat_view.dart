import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/chatList_model.dart';
import 'package:lpkni/app/data/Customer/Model/chat_model.dart';
import 'package:lpkni/app/modules/Customer/Chat/controllers/CustomerChat_controller.dart';

class CustomerroomchatView extends StatelessWidget {
  final CustomerchatController chatController =
      Get.find<CustomerchatController>();

  final TextEditingController textController = TextEditingController();
  final FocusNode messageFocus =
      FocusNode(); // ✅ Untuk menangani keyboard focus
  final ScrollController scrollController =
      ScrollController(); // ✅ Auto scroll ke bawah
  final ChatListItem
      chatUser; // 🔥 Tambahkan parameter untuk menyimpan data pengguna

  CustomerroomchatView({required this.chatUser}); // 🔥 Tambahkan konstruktor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // ✅ AppBar dengan Nama & Foto Pengguna
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                AssetImage(chatUser.profileImage), // 🔥 Ambil dari model
            radius: 18,
          ),
          const SizedBox(width: 10),
          Text(
            chatUser.name, // 🔥 Ambil nama pengguna dari model
            style: const TextStyle(color: Colors.teal, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ✅ ListView Chat dengan Scroll Controller
  Widget _buildMessageList() {
    return Obx(() {
      return ListView.builder(
        controller:
            scrollController, // ✅ Auto scroll ke bawah saat ada pesan baru
        reverse: false,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: chatController.messages.length,
        itemBuilder: (context, index) {
          final message = chatController.messages[index];
          return _buildChatBubble(message);
        },
      );
    });
  }

  // ✅ Desain Chat Bubble mirip Shopee/WhatsApp
  Widget _buildChatBubble(ChatMessage message) {
    bool isSender = message.isSender;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth:
              Get.width * 0.75, // ✅ Batasi lebar bubble agar tidak full screen
        ),
        decoration: BoxDecoration(
          color: isSender ? Colors.teal : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isSender ? const Radius.circular(12) : Radius.zero,
            bottomRight: isSender ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Pesan teks
            Text(
              message.message,
              style: TextStyle(
                color: isSender ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            // ✅ Waktu & Status Pesan
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time.toString(), // 🔥 Waktu pesan
                  style: TextStyle(
                    color: isSender ? Colors.white70 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
                if (isSender) ...[
                  const SizedBox(width: 5),
                  Icon(
                    message.isConfirmed ? Icons.check_circle : Icons.check,
                    size: 14,
                    color: message.isConfirmed
                        ? Colors.blueAccent
                        : Colors.white70,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Input Chat dengan Tombol Kirim
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              focusNode: messageFocus,
              decoration: InputDecoration(
                hintText: "Tulis pesan...",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.teal),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  // ✅ Fungsi Kirim Pesan + Auto Scroll ke Bawah
  void _sendMessage() {
    if (textController.text.isNotEmpty) {
      chatController.sendMessage(textController.text);
      textController.clear();
      messageFocus.unfocus(); // ✅ Tutup keyboard
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      });
    }
  }
}

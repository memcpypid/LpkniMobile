import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpkni/app/data/Customer/Model/chatList_model.dart';
import 'package:lpkni/app/data/Customer/Model/chat_model.dart';

class CustomerchatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var chatList = <ChatListItem>[].obs;
  final TextEditingController messageController =
      TextEditingController(); // ✅ Fix
  final box = GetStorage();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadMessages();
    loadChatList();
  }

  // ✅ Load pesan dari local storage
  void loadMessages() {
    // List<String>? storedMessages = box.read<List<String>>('messages');
    List<dynamic>? storedMessages =
        box.read('messages'); // Ambil sebagai List<dynamic>
    if (storedMessages != null) {
      messages.assignAll(
        storedMessages
            .map((item) => ChatMessage.fromJson(jsonDecode(item)))
            .toList(),
      );
    } else {
      messages.assignAll(_defaultMessages());
      saveMessages();
    }
  }

  // ✅ Default chat jika tidak ada data tersimpan
  List<ChatMessage> _defaultMessages() {
    return [
      ChatMessage(
        sender: "M Ahsan Furqan",
        message: "Halo Permisi",
        time: DateTime.now(),
        isSender: true,
        profileImage: "assets/food/food2.png",
        isConfirmed: true,
      ),
      ChatMessage(
        sender: "M Ahsan Furqan",
        message: "Masih Rendang Jengkol?",
        time: DateTime.now().subtract(const Duration(minutes: 5)),
        isSender: true,
        profileImage: "assets/food/food2.png",
        isConfirmed: true,
      ),
      ChatMessage(
        sender: "Penjual",
        message:
            "Halo, Ahsan! Semua produk yang bisa dipesan adalah ready stock. Jika terdapat stok kosong, kami akan menginfokan.",
        time: DateTime.now().subtract(const Duration(minutes: 10)),
        isSender: false,
        profileImage: "assets/food/food2.png",
      ),
      ChatMessage(
        sender: "M Ahsan Furqan",
        message: "Masih ya Silahkan Reservasi",
        time: DateTime.now().subtract(const Duration(minutes: 15)),
        isSender: true,
        profileImage: "assets/food/food2.png",
        isConfirmed: true,
      ),
    ];
  }

  // ✅ Load daftar chat dari local storage atau default
  void loadChatList() {
    chatList.assignAll([
      ChatListItem(
        name: "M Ahsan Furqan",
        lastMessage: "Masih ya Silahkan Reservasi",
        time: "07:15",
        profileImage: "assets/food/food2.png",
        unreadCount: 2,
      ),
      ChatListItem(
        name: "Budi Santoso",
        lastMessage: "Terima kasih, pesanan sudah dikirim.",
        time: "07:00",
        profileImage: "assets/food/food2.png",
        unreadCount: 1,
      ),
    ]);
  }

  // ✅ Simpan pesan ke local storage
  void saveMessages() {
    List<String> storedMessages =
        messages.map((item) => jsonEncode(item.toJson())).toList();
    box.write('messages', storedMessages);
  }

  // ✅ Kirim pesan baru dan simpan ke local storage
  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages.add(ChatMessage(
        sender: "M Ahsan Furqan",
        message: message,
        time: DateTime.now(),
        isSender: true,
        profileImage: "assets/food/food2.png",
        isConfirmed: false,
      ));
      saveMessages(); // ✅ Simpan setelah mengirim
      messageController.clear();
      update();
      _scrollToBottom(); // 🔥 Scroll ke pesan terbaru
    }
  }

  // ✅ Kirim pesan dengan konfirmasi
  void sendMessageWithConfirmation(String message) {
    sendMessage(message);
    Future.delayed(const Duration(seconds: 2), () {
      messages[messages.length - 1] = messages.last.copyWith(isConfirmed: true);
      saveMessages();
      update();
    });
  }

  // ✅ Auto-scroll ke pesan terbaru
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

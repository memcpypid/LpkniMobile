class ChatMessage {
  final String sender;
  final String message;
  final DateTime time; // 🔹 Gunakan DateTime agar lebih fleksibel
  final bool isSender;
  final String? profileImage;
  final bool isConfirmed;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.time,
    required this.isSender,
    this.profileImage,
    this.isConfirmed = false,
  });

  // 🔹 Konversi ke JSON untuk penyimpanan
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
      'time': time.toIso8601String(), // 🔹 Simpan sebagai String ISO8601
      'isSender': isSender,
      'profileImage': profileImage,
      'isConfirmed': isConfirmed,
    };
  }

  // 🔹 Factory untuk membaca dari JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      sender: json['sender'],
      message: json['message'],
      time: DateTime.parse(json['time']), // 🔹 Parse ke DateTime
      isSender: json['isSender'] ?? false,
      profileImage: json['profileImage'],
      isConfirmed: json['isConfirmed'] ?? false,
    );
  }

  // 🔹 `copyWith()` untuk mengedit objek pesan tanpa membuat baru
  ChatMessage copyWith({
    String? sender,
    String? message,
    DateTime? time,
    bool? isSender,
    String? profileImage,
    bool? isConfirmed,
  }) {
    return ChatMessage(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      time: time ?? this.time,
      isSender: isSender ?? this.isSender,
      profileImage: profileImage ?? this.profileImage,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}

class ChatListItem {
  final String name;
  final String lastMessage;
  final String time;
  final String profileImage;
  final int unreadCount;

  ChatListItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profileImage,
    this.unreadCount = 0,
  });

  factory ChatListItem.fromJson(Map<String, dynamic> json) {
    return ChatListItem(
      name: json['name'],
      lastMessage: json['lastMessage'],
      time: json['time'],
      profileImage: json['profileImage'],
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'time': time,
      'profileImage': profileImage,
      'unreadCount': unreadCount,
    };
  }
}

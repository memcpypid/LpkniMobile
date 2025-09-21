class NotificationModel {
  final String? title;
  final String message;
  final String dateTime;
  final String? type;
  bool isRead;
  final String? image;
  final String? icon;

  NotificationModel({
    this.title,
    required this.message,
    required this.dateTime,
    this.type = 'default',
    this.isRead = false,
    this.image,
    this.icon
  });

  // Convert from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      message: json['message'] ?? '',
      dateTime: json['dateTime'] ?? '',
      type: json['type'] ?? 'default',
      isRead: json['isRead'] ?? false,
      image: json['image'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'dateTime': dateTime,
      'type': type,
      'isRead': isRead,
      'image': image,
    };
  }

  // Copy with method untuk update
  NotificationModel copyWith({
    String? title,
    String? message,
    String? dateTime,
    String? type,
    bool? isRead,
    String? image,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      message: message ?? this.message,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      image: image ?? this.image,
    );
  }
}
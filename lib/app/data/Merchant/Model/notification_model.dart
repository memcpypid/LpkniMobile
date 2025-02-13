class NotificationModel {
  final String title;
  final String message;
  final String dateTime;
  final String icon;
  final String? image;

  NotificationModel({
    required this.title,
    required this.message,
    required this.dateTime,
    required this.icon,
    this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      message: json['message'],
      dateTime: json['dateTime'],
      icon: json['icon'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'dateTime': dateTime,
      'icon': icon,
      'image': image,
    };
  }
}

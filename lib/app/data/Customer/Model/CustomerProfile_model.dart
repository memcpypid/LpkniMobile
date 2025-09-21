class UserProfile2 {
  final String name;
  final String email;
  final String profileImage;
  final String language;
  bool pushNotification;
  bool announcementNotification;

  UserProfile2({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.language,
    this.pushNotification = true,
    this.announcementNotification = false,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "profileImage": profileImage,
      "language": language,
      "pushNotification": pushNotification,
      "announcementNotification": announcementNotification,
    };
  }

  // Convert from JSON
  factory UserProfile2.fromJson(Map<String, dynamic> json) {
    return UserProfile2(
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      language: json['language'],
      pushNotification: json['pushNotification'] ?? true,
      announcementNotification: json['announcementNotification'] ?? false,
    );
  }
}

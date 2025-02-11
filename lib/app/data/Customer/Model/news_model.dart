class News {
  final String title;
  final String description;
  final String image;
  final String author; // ✅ Penulis Berita
  final String date; // ✅ Tanggal Berita
  final String time; // ✅ Jam Berita
  bool isPopular;

  News({
    required this.title,
    required this.description,
    required this.image,
    required this.author,
    required this.date,
    required this.time,
    this.isPopular = false,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      author: json['author'],
      date: json['date'],
      time: json['time'],
      isPopular: json['isPopular'] ?? false,
    );
  }
}

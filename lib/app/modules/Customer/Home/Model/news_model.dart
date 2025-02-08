class News {
  final String title;
  final String description;
  final String image;
  bool isPopular;

  News({
    required this.title,
    required this.description,
    required this.image,
    this.isPopular = false,
  });
}

class FoodItem {
  final String name;
  final String price;
  final String image;
  final String Desc;
  final int soldCount;
  final double rating; // Tambahkan rating
  bool isFavorite;
  bool isInCart;

  FoodItem({
    required this.name,
    required this.price,
    required this.image,
    required this.Desc,
    required this.soldCount,
    required this.rating,
    this.isFavorite = false,
    this.isInCart = false,
  });
}

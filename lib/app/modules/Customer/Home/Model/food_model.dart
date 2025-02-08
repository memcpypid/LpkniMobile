class FoodItem {
  final String name;
  final String price;
  final String image;
  bool isFavorite;
  bool isInCart;

  FoodItem({
    required this.name,
    required this.price,
    required this.image,
    this.isFavorite = false,
    this.isInCart = false,
  });
}

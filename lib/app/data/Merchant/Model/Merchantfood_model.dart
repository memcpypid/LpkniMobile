class FoodItem {
  String id;
  String name;
  String description;
  int price;
  String image;
  String tag;
  int quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.tag,
    required this.quantity,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'tag': tag,
      'quantity': quantity,
    };
  }

  // Convert from JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      tag: json['tag'],
      quantity: json['quantity'],
    );
  }
}

class CartItem {
  final String id;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final String color;
  final String size;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.color,
    required this.size,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,
    String? color,
    String? size,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }
}


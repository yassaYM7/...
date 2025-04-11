class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final List<ProductColor> colors;
  final List<ProductSize> sizes;
  final bool isFeatured;
  final bool isNew;
  final double rating;
  final int reviewCount;
  final List<String> specifications;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.colors,
    required this.sizes,
    required this.isFeatured,
    required this.isNew,
    required this.rating,
    required this.reviewCount,
    required this.specifications,
  });
}

class ProductColor {
  final String name;
  final int colorCode;

  ProductColor({
    required this.name,
    required this.colorCode,
  });
}

class ProductSize {
  final String name;
  final double price;

  ProductSize({
    required this.name,
    required this.price,
  });
}


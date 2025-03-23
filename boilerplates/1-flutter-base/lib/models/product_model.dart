/// A lightweight model class representing a product or item.
///
/// This model is UI-focused and designed for use with mock data.
/// In fullstack tiers, it can be extended to include API response handling,
/// backend integration, or additional metadata like ratings or tags.

class ProductModel {
  /// Unique identifier for the product.
  final String id;

  /// Title of the product shown in the UI.
  final String title;

  /// Short description for listing or preview cards.
  final String description;

  /// Price as a decimal value.
  final double price;

  /// Remote URL to an image asset (optional).
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  /// Factory constructor to create a ProductModel from a JSON map.
  ///
  /// This is used when decoding from local JSON files or API responses.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  /// Converts this ProductModel into a JSON map.
  ///
  /// Useful for local caching or serialization.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

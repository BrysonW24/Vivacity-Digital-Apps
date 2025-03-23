/// Represents a category with a display name and optional icon.
class CategoryModel {
  final String name;
  final String icon; // Material Icon name or asset key

  CategoryModel({required this.name, required this.icon});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
    };
  }
}

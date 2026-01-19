
// lib/data/models/category_model.dart
class Category {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  int? productsCount;

  Category({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.productsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isActive: json['is_active'],
      productsCount: json['products_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_active': isActive,
      'products_count': productsCount,
    };
  }
}
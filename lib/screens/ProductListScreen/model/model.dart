
// lib/data/models/product_model.dart
class Product {
  int? id;
  String? name;
  String? categoryId;
  String? packId;
  double? price;
  double? cost;
  String? description;
  String? sku;
  List<String>? images;
  bool? isActive;
  int? stock;
  String? createdAt;

  Product({
    this.id,
    this.name,
    this.categoryId,
    this.packId,
    this.price,
    this.cost,
    this.description,
    this.sku,
    this.images,
    this.isActive,
    this.stock,
    this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      packId: json['pack_id'],
      price: json['price']?.toDouble(),
      cost: json['cost']?.toDouble(),
      description: json['description'],
      sku: json['sku'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      isActive: json['is_active'],
      stock: json['stock'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'pack_id': packId,
      'price': price,
      'cost': cost,
      'description': description,
      'sku': sku,
      'images': images,
      'is_active': isActive,
      'stock': stock,
      'created_at': createdAt,
    };
  }
}

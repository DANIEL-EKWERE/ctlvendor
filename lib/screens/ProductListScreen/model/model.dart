import 'dart:convert';

ProductModel productModelFromJson(String x) =>
    ProductModel.fromJson(json.decode(x));

// lib/data/models/product_model.dart
// class Product {
//   int? id;
//   String? name;
//   String? categoryId;
//   String? categoryName;
//   String? packId;
//   String? pack;
//   double? price;
//   double? cost;
//   String? description;
//   String? sku;
//   List<String>? images;
//   bool? isActive;
//   int? stock;
//   String? createdAt;

//   Product({
//     this.id,
//     this.name,
//     this.categoryId,
//     this.categoryName,
//     this.packId,
//     this.pack,
//     this.price,
//     this.cost,
//     this.description,
//     this.sku,
//     this.images,
//     this.isActive,
//     this.stock,
//     this.createdAt,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       categoryId: json['category_id'],
//       categoryName: json['categoryName'],
//       packId: json['pack_id'],
//       pack: json['pack'],
//       price: json['price']?.toDouble(),
//       cost: json['cost']?.toDouble(),
//       description: json['description'],
//       sku: json['sku'],
//       images: json['images'] != null ? List<String>.from(json['images']) : null,
//       isActive: json['is_active'],
//       stock: json['stock'],
//       createdAt: json['created_at'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'category_id': categoryId,
//       'pack_id': packId,
//       'pack': pack,
//       'price': price,
//       'cost': cost,
//       'categoryName': categoryName,
//       'description': description,
//       'sku': sku,
//       'images': images,
//       'is_active': isActive,
//       'stock': stock,
//       'created_at': createdAt,
//     };
//   }
// }

class ProductModel {
  bool? status;
  String? message;
  List<Data>? data;

  ProductModel({this.status, this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  Product? product;
  Category? category;
  String? packId;
  String? price;
  String? cost;
  String? stock;
  String? sku;
  String? finalPrice;
  String? description;
  String? imageUrl;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.product,
    this.category,
    this.packId,
    this.price,
    this.cost,
    this.stock,
    this.sku,
    this.finalPrice,
    this.description,
    this.imageUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    packId = json['pack_id'];
    price = json['price'];
    cost = json['cost'];
    stock = json['stock'];
    sku = json['sku'];
    finalPrice = json['final_price'].toString();
    description = json['description'];
    imageUrl = json['image_url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['pack_id'] = this.packId;
    data['price'] = this.price;
    data['cost'] = this.cost;
    data['stock'] = this.stock;
    data['sku'] = this.sku;
    data['final_price'] = this.finalPrice;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  bool? status;
  String? createdAt;
  String? updatedAt;

  Product({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Category {
  int? id;
  String? type;
  String? name;
  String? description;
  String? imageUrl;
  String? sort;
  String? createdAt;

  Category({
    this.id,
    this.type,
    this.name,
    this.description,
    this.imageUrl,
    this.sort,
    this.createdAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    sort = json['sort'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['sort'] = this.sort;
    data['created_at'] = this.createdAt;
    return data;
  }
}

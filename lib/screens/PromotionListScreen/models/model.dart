
// lib/data/models/promotion_model.dart
// class Promotion {
//   int? id;
//   String? title;
//   String? image;
//   String? discountType; // 'percentage' or 'fixed'
//   double? discountValue;
//   String? startDate;
//   String? endDate;
//   List<int>? productIds;
//   bool? isActive;
//   int? productsCount;

//   Promotion({
//     this.id,
//     this.title,
//     this.image,
//     this.discountType,
//     this.discountValue,
//     this.startDate,
//     this.endDate,
//     this.productIds,
//     this.isActive,
//     this.productsCount,
//   });

//   factory Promotion.fromJson(Map<String, dynamic> json) {
//     return Promotion(
//       id: json['id'],
//       title: json['title'],
//       image: json['image'],
//       discountType: json['discount_type'],
//       discountValue: json['discount_value']?.toDouble(),
//       startDate: json['start_date'],
//       endDate: json['end_date'],
//       productIds: json['product_ids'] != null 
//           ? List<int>.from(json['product_ids']) 
//           : null,
//       isActive: json['is_active'],
//       productsCount: json['products_count'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'image': image,
//       'discount_type': discountType,
//       'discount_value': discountValue,
//       'start_date': startDate,
//       'end_date': endDate,
//       'product_ids': productIds,
//       'is_active': isActive,
//       'products_count': productsCount,
//     };
//   }
// }

import 'dart:convert';

PromotionModel promotionModelFromJson(String x) => PromotionModel.fromJson(json.decode(x));

class PromotionModel {
  bool? status;
  String? message;
  List<Data>? data;

  PromotionModel({this.status, this.message, this.data});

  PromotionModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? discount;
  String? discountLabel;
  String? type;
  String? typeLabel;
  String? startsAt;
  String? endsAt;
  String? imageUrl;
  List<VendorProducts>? vendorProducts;

  Data(
      {this.id,
      this.title,
      this.discount,
      this.discountLabel,
      this.type,
      this.typeLabel,
      this.startsAt,
      this.endsAt,
      this.imageUrl,
      this.vendorProducts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    discount = json['discount'];
    discountLabel = json['discount_label'];
    type = json['type'];
    typeLabel = json['type_label'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    imageUrl = json['image_url'];
    if (json['vendor_products'] != null) {
      vendorProducts = <VendorProducts>[];
      json['vendor_products'].forEach((v) {
        vendorProducts!.add(new VendorProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['discount'] = this.discount;
    data['discount_label'] = this.discountLabel;
    data['type'] = this.type;
    data['type_label'] = this.typeLabel;
    data['starts_at'] = this.startsAt;
    data['ends_at'] = this.endsAt;
    data['image_url'] = this.imageUrl;
    if (this.vendorProducts != null) {
      data['vendor_products'] =
          this.vendorProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorProducts {
  int? id;
  Product? product;
  Category? category;
  Null? packId;
  String? price;
  String? cost;
  String? stock;
  String? sku;
  int? finalPrice;
  String? description;
  Null? imageUrl;
  String? status;
  String? createdAt;
  String? updatedAt;

  VendorProducts(
      {this.id,
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
      this.updatedAt});

  VendorProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    packId = json['pack_id'];
    price = json['price'];
    cost = json['cost'];
    stock = json['stock'];
    sku = json['sku'];
    finalPrice = json['final_price'];
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

  Product(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

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
  Null? imageUrl;
  String? sort;
  String? createdAt;

  Category(
      {this.id,
      this.type,
      this.name,
      this.description,
      this.imageUrl,
      this.sort,
      this.createdAt});

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

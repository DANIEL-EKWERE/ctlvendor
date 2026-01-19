// lib/data/models/promotion_model.dart
class Promotion {
  int? id;
  String? title;
  String? image;
  String? discountType; // 'percentage' or 'fixed'
  double? discountValue;
  String? startDate;
  String? endDate;
  List<int>? productIds;
  bool? isActive;
  int? productsCount;

  Promotion({
    this.id,
    this.title,
    this.image,
    this.discountType,
    this.discountValue,
    this.startDate,
    this.endDate,
    this.productIds,
    this.isActive,
    this.productsCount,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      discountType: json['discount_type'],
      discountValue: json['discount_value']?.toDouble(),
      startDate: json['start_date'],
      endDate: json['end_date'],
      productIds: json['product_ids'] != null 
          ? List<int>.from(json['product_ids']) 
          : null,
      isActive: json['is_active'],
      productsCount: json['products_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'discount_type': discountType,
      'discount_value': discountValue,
      'start_date': startDate,
      'end_date': endDate,
      'product_ids': productIds,
      'is_active': isActive,
      'products_count': productsCount,
    };
  }
}
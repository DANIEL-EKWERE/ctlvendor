


// lib/data/models/pack_model.dart
// class Pack {
//   int? id;
//   String? name;
//   double? priceModifier;

//   Pack({this.id, this.name, this.priceModifier});

//   factory Pack.fromJson(Map<String, dynamic> json) {
//     return Pack(
//       id: json['id'],
//       name: json['name'],
//       priceModifier: json['price_modifier']?.toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'price_modifier': priceModifier,
//     };
//   }
// }

import 'dart:convert';

PackModel packModelFromJson(String x) => PackModel.fromJson(json.decode(x));

class PackModel {
  bool? status;
  String? message;
  List<Data>? data;

  PackModel({this.status, this.message, this.data});

  PackModel.fromJson(Map<String, dynamic> json) {
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
  String? vendorId;
  String? companyId;
  String? name;
  String? price;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.vendorId,
      this.companyId,
      this.name,
      this.price,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    companyId = json['company_id'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

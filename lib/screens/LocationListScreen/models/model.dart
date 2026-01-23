// lib/data/models/location_model.dart
// class Location {
//   int? id;
//   String? city;
//   String? state;
//   String? country;
//   String? contactAddress;
//   String? phone;
//   bool? isActive;

//   Location({
//     this.id,
//     this.city,
//     this.state,
//     this.country,
//     this.contactAddress,
//     this.phone,
//     this.isActive,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       id: json['id'],
//       city: json['city'],
//       state: json['state'],
//       country: json['country'],
//       contactAddress: json['contact_address'],
//       phone: json['phone'],
//       isActive: json['is_active'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'city': city,
//       'state': state,
//       'country': country,
//       'contact_address': contactAddress,
//       'phone': phone,
//       'is_active': isActive,
//     };
//   }
// }

import 'dart:convert';

LocationModel locationModelFromJson(String x) =>
    LocationModel.fromJson(json.decode(x));

class LocationModel {
  bool? status;
  String? message;
  List<Data>? data;

  LocationModel({this.status, this.message, this.data});

  LocationModel.fromJson(Map<String, dynamic> json) {
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
  String? contactAddress;
  String? lat;
  String? lon;
  String? country;
  String? state;
  String? lga;
  String? phone;
  String? isActive;
  bool? isPrimary;
  String? createdAt;

  Data({
    this.id,
    this.contactAddress,
    this.lat,
    this.lon,
    this.country,
    this.state,
    this.lga,
    this.phone,
    this.isActive,
    this.isPrimary,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactAddress = json['contact_address'];
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
    lga = json['lga'];
    phone = json['phone_number'];
    isActive = json['is_default'];
    isPrimary = json['is_primary'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_address'] = this.contactAddress;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['country'] = this.country;
    data['state'] = this.state;
    data['lga'] = this.lga;
    data['phone_number'] = this.phone;
    data['is_default'] = this.isActive;
    data['is_primary'] = this.isPrimary;
    data['created_at'] = this.createdAt;
    return data;
  }
}

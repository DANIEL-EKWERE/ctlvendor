import 'dart:convert';

import 'package:get/get.dart';

OrderModel orderModelFromJson(String x) => OrderModel.fromJson(jsonDecode(x));

class OrderModel {
  bool? status;
  String? message;
  List<Data>? data;

  OrderModel({this.status, this.message, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? reference;
  String? status;
  String? packageType;
  bool? isPaid;
  String? total;
  String? serviceCharge;
  String? shippingFee;
  String? remark;
  String? vat;
  RxBool isAccepted;
  RxBool isRejected;
  RxBool isCompleted;
  RxBool isStarted;

  Customer? customer;
  Address? address;
  Vendor? vendor;
  List<Items>? items;
  List<Histories>? histories;
  String? createdAt;

  Data({
    this.id,
    this.reference,
    this.status,
    this.packageType,
    this.isPaid,
    this.total,
    this.remark,
    this.serviceCharge,
    this.shippingFee,
    this.vat,
    this.customer,
    this.address,
    this.vendor,
    this.items,

    this.histories,
    this.createdAt,
  }) : isAccepted = RxBool(false),
       isRejected = RxBool(false),
       isCompleted = RxBool(false),
       isStarted = RxBool(false);

  Data.fromJson(Map<String, dynamic> json)
    : isAccepted = RxBool(false),
      isRejected = RxBool(false),
      isCompleted = RxBool(false),
      isStarted = RxBool(false) {
    id = json['id'];
    reference = json['reference'];
    status = json['status'];
    packageType = json['package_type'];
    isPaid = json['is_paid'];
    remark = json['remark'] ?? 'this user has no remark!!!';
    total = json['total']?.toString();
    serviceCharge = json['service_charge']?.toString();
    shippingFee = json['shipping_fee']?.toString();
    vat = json['vat']?.toString();
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['histories'] != null) {
      histories = <Histories>[];
      json['histories'].forEach((v) {
        histories!.add(Histories.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['status'] = this.status;
    data['package_type'] = this.packageType;
    data['is_paid'] = this.isPaid;
    data['total'] = this.total;
    data['remark'] = this.remark;
    data['service_charge'] = this.serviceCharge;
    data['shipping_fee'] = this.shippingFee;
    data['vat'] = this.vat;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.histories != null) {
      data['histories'] = this.histories!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  String? country; // Changed from Null? to String?

  Customer({
    this.id,
    this.name,
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.country,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    profilePicture = json['profile_picture'];
    country = json['country']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['profile_picture'] = this.profilePicture;
    data['country'] = this.country;
    return data;
  }
}

class Address {
  int? id;
  String? country; // Changed from Null? to String?
  String? state;
  String? lga;
  String? contactAddress;
  String? phoneNumber;
  String? lat;
  String? lon;
  String? isDefault;
  String? createdAt;

  Address({
    this.id,
    this.country,
    this.state,
    this.lga,
    this.contactAddress,
    this.phoneNumber,
    this.lat,
    this.lon,
    this.isDefault,
    this.createdAt,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country']?.toString();
    state = json['state'];
    lga = json['lga'];
    contactAddress = json['contact_address'];
    phoneNumber = json['phone_number'];
    lat = json['lat'];
    lon = json['lon'];
    isDefault = json['is_default']?.toString();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    data['state'] = this.state;
    data['lga'] = this.lga;
    data['contact_address'] = this.contactAddress;
    data['phone_number'] = this.phoneNumber;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Vendor {
  int? id;
  String? businessName;
  String? businessAddress;
  String? distanceKm; // Changed from Null? to String?
  String? phoneNumber;
  String? businessTypeId;
  String? email;
  String? fulfilmentType;
  String? logo;
  String? banner;
  String? createdAt;

  Vendor({
    this.id,
    this.businessName,
    this.businessAddress,
    this.distanceKm,
    this.phoneNumber,
    this.businessTypeId,
    this.email,
    this.fulfilmentType,
    this.logo,
    this.banner,
    this.createdAt,
  });

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    businessAddress = json['business_address'];
    distanceKm = json['distance_km']?.toString();
    phoneNumber = json['phone_number'];
    businessTypeId = json['business_type_id'];
    email = json['email'];
    fulfilmentType = json['fulfilment_type'];
    logo = json['logo'];
    banner = json['banner'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['business_address'] = this.businessAddress;
    data['distance_km'] = this.distanceKm;
    data['phone_number'] = this.phoneNumber;
    data['business_type_id'] = this.businessTypeId;
    data['email'] = this.email;
    data['fulfilment_type'] = this.fulfilmentType;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Items {
  Product? product;
  String? productId;
  String? quantity;
  String? price;
  String? total;

  Items({this.product, this.productId, this.quantity, this.price, this.total});

  Items.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
    productId = json['product_id']?.toString();
    quantity = json['quantity']?.toString();
    price = json['price']?.toString();
    total = json['total']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total'] = this.total;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Histories {
  String? status;
  String? changedBy;
  String? createdAt;

  Histories({this.status, this.changedBy, this.createdAt});

  Histories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    changedBy = json['changed_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['changed_by'] = this.changedBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}

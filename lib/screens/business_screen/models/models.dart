
import 'dart:convert';

VendorSuccessModel vendorSuccessModelFromJson(String x) => VendorSuccessModel.fromJson(json.decode(x));



class VendorSuccessModel {
  final bool status;
  final String message;
  final VendorData? data;

  VendorSuccessModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory VendorSuccessModel.fromJson(Map<String, dynamic> json) {
    return VendorSuccessModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? VendorData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class VendorData {
  final int? id;
  final String? businessName;
  final String? businessAddress;
  final String? phoneNumber;
  final String? businessTypeId;
  final String? email;
  final String? rcNumber;
  final String? taxNumber;
  final String? businessDescription;
  final String? bvn;
  final String? meansOfIdentification;
  final String? identificationUrl;
  final bool isVerified;
  final bool isActive;
  final bool isRegistered;
  final String? fulfilmentType;
  final String? logo;
  final String? banner;
  final double? distanceKm;
  final List<VendorLocation> locations;
  final VendorCategory? category;
  final VendorPlan? plan;
  final DateTime? createdAt;

  VendorData({
    this.id,
    this.businessName,
    this.businessAddress,
    this.phoneNumber,
    this.businessTypeId,
    this.email,
    this.rcNumber,
    this.taxNumber,
    this.businessDescription,
    this.bvn,
    this.meansOfIdentification,
    this.identificationUrl,
    this.isVerified = false,
    this.isActive = false,
    this.isRegistered = false,
    this.fulfilmentType,
    this.logo,
    this.banner,
    this.distanceKm,
    this.locations = const [],
    this.category,
    this.plan,
    this.createdAt,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) {
    return VendorData(
      id: json['id'] ?? 0,
      businessName: json['business_name'] ?? '',
      businessAddress: json['business_address'] ?? '',
      phoneNumber: json['phone_number'],
      businessTypeId: json['business_type_id'],
      email: json['email'],
      rcNumber: json['rc_number'],
      taxNumber: json['tax_number'],
      businessDescription: json['business_description'],
      bvn: json['bvn'],
      meansOfIdentification: json['means_of_identification'],
      identificationUrl: json['identification_url'],
      isVerified: json['is_verified'] ?? false,
      isActive: json['is_active'] ?? false,
      isRegistered: json['is_registered'] ?? false,
      fulfilmentType: json['fulfilment_type'],
      logo: json['logo'],
      banner: json['banner'],
      distanceKm: json['distance_km'] != null 
          ? (json['distance_km'] as num).toDouble() 
          : null,
      locations: json['locations'] != null
          ? (json['locations'] as List)
              .map((e) => VendorLocation.fromJson(e))
              .toList()
          : [],
      category: json['category'] != null
          ? VendorCategory.fromJson(json['category'])
          : null,
      plan: json['plan'] != null 
          ? VendorPlan.fromJson(json['plan']) 
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_name': businessName,
      'business_address': businessAddress,
      'phone_number': phoneNumber,
      'business_type_id': businessTypeId,
      'email': email,
      'rc_number': rcNumber,
      'tax_number': taxNumber,
      'business_description': businessDescription,
      'bvn': bvn,
      'means_of_identification': meansOfIdentification,
      'identification_url': identificationUrl,
      'is_verified': isVerified,
      'is_active': isActive,
      'is_registered': isRegistered,
      'fulfilment_type': fulfilmentType,
      'logo': logo,
      'banner': banner,
      'distance_km': distanceKm,
      'locations': locations.map((e) => e.toJson()).toList(),
      'category': category?.toJson(),
      'plan': plan?.toJson(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  // Helper method to check if images exist
  bool hasLogo() => logo != null && logo!.isNotEmpty;
  bool hasBanner() => banner != null && banner!.isNotEmpty;
}

class VendorLocation {
  final int id;
  final String? phoneNumber;
  final String? contactAddress;
  final double? latitude;
  final double? longitude;
  final String? country;
  final LocationState? state;
  final LocationLga? lga;
  final bool isActive;
  final bool isPrimary;
  final DateTime? createdAt;

  VendorLocation({
    required this.id,
    this.phoneNumber,
    this.contactAddress,
    this.latitude,
    this.longitude,
    this.country,
    this.state,
    this.lga,
    this.isActive = false,
    this.isPrimary = false,
    this.createdAt,
  });

  factory VendorLocation.fromJson(Map<String, dynamic> json) {
    return VendorLocation(
      id: json['id'] ?? 0,
      phoneNumber: json['phone_number'],
      contactAddress: json['contact_address'],
      latitude: json['lat'] != null ? (json['lat'] as num).toDouble() : null,
      longitude: json['lon'] != null ? (json['lon'] as num).toDouble() : null,
      country: json['country'],
      state: json['state'] != null 
          ? LocationState.fromJson(json['state']) 
          : null,
      lga: json['lga'] != null 
          ? LocationLga.fromJson(json['lga']) 
          : null,
      isActive: json['is_active'] ?? false,
      isPrimary: json['is_primary'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'contact_address': contactAddress,
      'lat': latitude,
      'lon': longitude,
      'country': country,
      'state': state?.toJson(),
      'lga': lga?.toJson(),
      'is_active': isActive,
      'is_primary': isPrimary,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

class LocationState {
  final int id;
  final String name;
  final String? countryId;

  LocationState({
    required this.id,
    required this.name,
    this.countryId,
  });

  factory LocationState.fromJson(Map<String, dynamic> json) {
    return LocationState(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      countryId: json['country_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
    };
  }
}

class LocationLga {
  final int id;
  final String name;

  LocationLga({
    required this.id,
    required this.name,
  });

  factory LocationLga.fromJson(Map<String, dynamic> json) {
    return LocationLga(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class VendorCategory {
  final int id;
  final String type;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? sort;
  final DateTime? createdAt;

  VendorCategory({
    required this.id,
    required this.type,
    required this.name,
    this.description,
    this.imageUrl,
    this.sort,
    this.createdAt,
  });

  factory VendorCategory.fromJson(Map<String, dynamic> json) {
    return VendorCategory(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      imageUrl: json['image_url'],
      sort: json['sort'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'sort': sort,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

class VendorPlan {
  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;

  VendorPlan({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
  });

  factory VendorPlan.fromJson(Map<String, dynamic> json) {
    return VendorPlan(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

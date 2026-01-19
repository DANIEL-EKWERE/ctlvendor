// lib/data/models/location_model.dart
class Location {
  int? id;
  String? city;
  String? state;
  String? country;
  String? contactAddress;
  String? phone;
  bool? isActive;

  Location({
    this.id,
    this.city,
    this.state,
    this.country,
    this.contactAddress,
    this.phone,
    this.isActive,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      contactAddress: json['contact_address'],
      phone: json['phone'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'state': state,
      'country': country,
      'contact_address': contactAddress,
      'phone': phone,
      'is_active': isActive,
    };
  }
}
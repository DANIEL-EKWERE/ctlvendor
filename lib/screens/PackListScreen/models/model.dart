


// lib/data/models/pack_model.dart
class Pack {
  int? id;
  String? name;
  double? priceModifier;

  Pack({this.id, this.name, this.priceModifier});

  factory Pack.fromJson(Map<String, dynamic> json) {
    return Pack(
      id: json['id'],
      name: json['name'],
      priceModifier: json['price_modifier']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price_modifier': priceModifier,
    };
  }
}
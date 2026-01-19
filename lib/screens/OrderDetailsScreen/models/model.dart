
// lib/data/models/order_model.dart
class Order {
  int? id;
  String? orderNumber;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? date;
  double? subtotal;
  double? discount;
  double? tax;
  double? total;
  String? paymentMethod;
  String? status; // pending, confirmed, packed, shipped, delivered, cancelled
  List<OrderItem>? items;

  Order({
    this.id,
    this.orderNumber,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.date,
    this.subtotal,
    this.discount,
    this.tax,
    this.total,
    this.paymentMethod,
    this.status,
    this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      customerName: json['customer_name'],
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'],
      date: json['date'],
      subtotal: json['subtotal']?.toDouble(),
      discount: json['discount']?.toDouble(),
      tax: json['tax']?.toDouble(),
      total: json['total']?.toDouble(),
      paymentMethod: json['payment_method'],
      status: json['status'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'customer_phone': customerPhone,
      'date': date,
      'subtotal': subtotal,
      'discount': discount,
      'tax': tax,
      'total': total,
      'payment_method': paymentMethod,
      'status': status,
      'items': items?.map((i) => i.toJson()).toList(),
    };
  }
}

class OrderItem {
  int? productId;
  String? productName;
  int? quantity;
  double? price;
  double? total;

  OrderItem({
    this.productId,
    this.productName,
    this.quantity,
    this.price,
    this.total,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: json['price']?.toDouble(),
      total: json['total']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
      'total': total,
    };
  }
}
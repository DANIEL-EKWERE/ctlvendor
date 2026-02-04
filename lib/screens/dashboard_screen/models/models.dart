import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

class DashboardModel {
  int? salesToday;
  int? ordersToday;
  int? totalProducts;
  int? activePromotions;
  int? lowStockAlert;
  int? pendingOrders;
  List<MonthlyRevenue>? monthlyRevenue;
  List<TopSellingProduct>? topSellingProducts;

  DashboardModel({
    this.salesToday,
    this.ordersToday,
    this.totalProducts,
    this.activePromotions,
    this.lowStockAlert,
    this.pendingOrders,
    this.monthlyRevenue,
    this.topSellingProducts,
  });

  DashboardModel.fromJson(Map<String, dynamic> json) {
    salesToday = json['sales_today'];
    ordersToday = json['orders_today'];
    totalProducts = json['total_products'];
    activePromotions = json['active_promotions'];
    lowStockAlert = json['low_stock_alert'];
    pendingOrders = json['pending_orders'];

    if (json['monthly_revenue'] != null) {
      monthlyRevenue = <MonthlyRevenue>[];
      json['monthly_revenue'].forEach((v) {
        monthlyRevenue!.add(MonthlyRevenue.fromJson(v));
      });
    }

    if (json['top_selling_products'] != null) {
      topSellingProducts = <TopSellingProduct>[];
      json['top_selling_products'].forEach((v) {
        topSellingProducts!.add(TopSellingProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sales_today'] = this.salesToday;
    data['orders_today'] = this.ordersToday;
    data['total_products'] = this.totalProducts;
    data['active_promotions'] = this.activePromotions;
    data['low_stock_alert'] = this.lowStockAlert;
    data['pending_orders'] = this.pendingOrders;

    if (this.monthlyRevenue != null) {
      data['monthly_revenue'] = this.monthlyRevenue!
          .map((v) => v.toJson())
          .toList();
    }

    if (this.topSellingProducts != null) {
      data['top_selling_products'] = this.topSellingProducts!
          .map((v) => v.toJson())
          .toList();
    }

    return data;
  }
}

// Monthly Revenue Model
class MonthlyRevenue {
  String? month;
  double? revenue;

  MonthlyRevenue({this.month, this.revenue});

  MonthlyRevenue.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    if (json['amount'] != null) {
      revenue = double.tryParse(json['amount'].toString()) ?? 0.0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month'] = this.month;
    data['amount'] = this.revenue;
    return data;
  }
}

// Top Selling Product Model
class TopSellingProduct {
  int? id;
  String? name;
  int? soldCount;
  double? revenue;
  String? category;
  String? stock;

  TopSellingProduct({this.id, this.name, this.soldCount, this.revenue});

  TopSellingProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    soldCount = json['sold_count'];
    category = json['category'];
    stock = json['stock'];
    revenue = json['revenue']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sold_count'] = this.soldCount;
    data['revenue'] = this.revenue;
    return data;
  }
}

import 'package:kkn_store/features/shop/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String status; // Pending, Processing, Shipped, Delivered, Cancelled
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final String? paymentStatus;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final Map<String, dynamic>? shippingAddress;
  final Map<String, dynamic>? billingAddress;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.paymentStatus,
    this.deliveryDate,
    this.shippingAddress,
    this.billingAddress,
  });

  String get formattedOrderDate => orderDate.toString().split(' ')[0];

  static OrderModel empty() => OrderModel(id: '', status: '', items: [], totalAmount: 0, orderDate: DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'total_amount': totalAmount,
      'order_date': orderDate.toIso8601String(),
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'delivery_date': deliveryDate?.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(), // Simplified store, or store in separate table
    };
  }

  factory OrderModel.fromSnapshot(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return OrderModel.empty();

    return OrderModel(
      id: data['id'] ?? '',
      userId: data['user_id'] ?? '',
      status: data['status'] ?? 'Pending',
      totalAmount: (data['total_amount'] ?? 0.0).toDouble(),
      orderDate: DateTime.tryParse(data['created_at'] ?? '') ?? DateTime.now(),
      paymentMethod: data['payment_method'] ?? '',
      paymentStatus: data['payment_status'],
      deliveryDate: data['delivery_date'] != null ? DateTime.tryParse(data['delivery_date']) : null,
      items: [], // Items usually fetched separately
      shippingAddress: data['shipping_address'] as Map<String, dynamic>?,
      billingAddress: data['billing_address'] as Map<String, dynamic>?,
    );
  }
}

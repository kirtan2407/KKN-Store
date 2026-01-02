// import 'package:get/get.dart';
// import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:kkn_store/features/shop/models/order_model.dart';
// import 'package:kkn_store/features/shop/models/cart_item_model.dart'; // Import CartItemModel

// class OrderRepository extends GetxController {
//   static OrderRepository get instance => Get.find();

//   final _db = Supabase.instance.client;

//   // Fetch User Orders
//   Future<List<OrderModel>> fetchUserOrders() async {
//     try {
//       final userId = AuthenticationRepository.instance.authUser?.id;
//       if (userId == null) throw 'User not logged in';

//       final result = await _db.from('orders').select().eq('user_id', userId).order('created_at', ascending: false);
//       return (result as List<dynamic>).map((e) => OrderModel.fromSnapshot(e)).toList();
//     } catch (e) {
//       throw 'Error fetching orders: $e';
//     }
//   }

//   // --- Admin Methods ---

//   // Fetch All Orders (for User List calculation)
//   Future<List<OrderModel>> fetchAllOrders() async {
//     try {
//       final result = await _db.from('orders').select().order('created_at', ascending: false);
//       return (result as List<dynamic>).map((e) => OrderModel.fromSnapshot(e)).toList();
//     } catch (e) {
//       throw 'Error fetching all orders: $e';
//     }
//   }

//   // Fetch Orders by specific User
//   Future<List<OrderModel>> fetchOrdersByUser(String userId) async {
//     try {
//        final result = await _db.from('orders').select().eq('user_id', userId).order('created_at', ascending: false);
//        return (result as List<dynamic>).map((e) => OrderModel.fromSnapshot(e)).toList();
//     } catch (e) {
//       throw 'Error fetching user orders: $e';
//     }
//   }

//   // Fetch Order Items for an Order
//   Future<List<CartItemModel>> fetchOrderItems(String orderId) async {
//     try {
//       final result = await _db.from('order_items').select('*, products(title, thumbnail)').eq('order_id', orderId);

//       return (result as List<dynamic>).map((e) {
//          final product = e['products'];
//          return CartItemModel(
//             productId: e['product_id'],
//             quantity: e['quantity'],
//             price: (e['price'] as num).toDouble(),
//             title: product != null ? product['title'] : 'Unknown Product',
//             image: product != null ? product['thumbnail'] : null,
//          );
//       }).toList();
//     } catch (e) {
//       // return empty if error or just throw
//       print('Error fetching items: $e');
//       return [];
//     }
//   }

//   // Create Order (Transactional)
//   Future<void> createOrder(OrderModel order, List<CartItemModel> items) async {
//     try {
//       final userId = AuthenticationRepository.instance.authUser?.id;
//       if (userId == null) throw 'User not logged in';

//       // 1. Insert Order
//       final orderData = {
//         'user_id': userId,
//         'status': order.status,
//         'total_amount': order.totalAmount,
//         'payment_method': order.paymentMethod,
//         'payment_status': order.paymentStatus ?? 'Unpaid',
//         'created_at': DateTime.now().toIso8601String(),
//       };

//       final orderResponse = await _db.from('orders').insert(orderData).select().single();
//       final orderId = orderResponse['id'];

//       // 2. Insert Order Items & Transactions & Update Stock
//       // Note: Ideal to use a Postgres Function for atomicity.
//       // For now, doing sequentially in Dart.

//       for (var item in items) {
//         // Insert Item
//         await _db.from('order_items').insert({
//           'order_id': orderId,
//           'product_id': item.productId,
//           'quantity': item.quantity,
//           'price': item.price,
//           'total_price': item.price * item.quantity,
//         });

//         // Update Stock
//         // Update Stock (Manual Fallback)
//         // Since SQL Trigger might be missing, we enforce it here.
//         await _db.rpc('decrement_stock', params: {
//            'product_id': item.productId,
//            'quantity': item.quantity
//         });
//       }

//       // 3. Create Transaction Record
//       // Need profit calculation?
//       // Assuming 'profit' logic is handled by backend trigger or we estimate it here.
//       // Or we just insert the Sale transaction.
//       await _db.from('store_transactions').insert({
//         'order_id': orderId,
//         'amount': order.totalAmount,
//         'type': 'Credit', // Income
//         'category': 'Sale',
//         'description': 'Order #$orderId',
//         'transaction_date': DateTime.now().toIso8601String(),
//         // 'profit': ... calculate if we had cost price
//       });

//     } catch (e) {
//       throw 'Error creating order: $e';
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kkn_store/features/shop/models/order_model.dart';
import 'package:kkn_store/features/shop/models/cart_item_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  // ============================================
  // FETCH ORDERS
  // ============================================

  /// Fetch User's Own Orders
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.id;
      if (userId == null) throw 'User not logged in';

      final result = await _db
          .from('orders')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (result as List<dynamic>)
          .map((e) => OrderModel.fromSnapshot(e))
          .toList();
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error fetching orders: $e';
    }
  }

  /// Fetch All Orders (Admin Only)
  Future<List<OrderModel>> fetchAllOrders() async {
    try {
      final result = await _db
          .from('orders')
          .select()
          .order('created_at', ascending: false);

      return (result as List<dynamic>)
          .map((e) => OrderModel.fromSnapshot(e))
          .toList();
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error fetching all orders: $e';
    }
  }

  /// Fetch Orders by Specific User (Admin Only)
  Future<List<OrderModel>> fetchOrdersByUser(String userId) async {
    try {
      final result = await _db
          .from('orders')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (result as List<dynamic>)
          .map((e) => OrderModel.fromSnapshot(e))
          .toList();
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error fetching user orders: $e';
    }
  }

  /// Fetch Order Items for a Specific Order
  Future<List<CartItemModel>> fetchOrderItems(String orderId) async {
    try {
      final result = await _db
          .from('order_items')
          .select('*, products(title, thumbnail)')
          .eq('order_id', orderId);

      if (result.isEmpty) return [];

      return (result as List<dynamic>).map((e) {
        final product = e['products'];
        return CartItemModel(
          productId: e['product_id'],
          quantity: e['quantity'],
          price: (e['price'] as num).toDouble(),
          title: product != null ? product['title'] : 'Product Unavailable',
          image: product != null ? product['thumbnail'] : null,
          variationId: e['variation_id'],
        );
      }).toList();
    } on PostgrestException catch (e) {
      print('Database error fetching order items: ${e.message}');
      return [];
    } catch (e) {
      print('Error fetching order items: $e');
      return [];
    }
  }

  // ============================================
  // CREATE ORDER (RECOMMENDED METHOD)
  // ============================================

  // ============================================
  // CREATE ORDER (Standard Insert + Trigger)
  // ============================================

  /// Create Order (Standard Way)
  /// Relies on 'trg_reduce_stock' SQL Trigger to update stock automatically.
  Future<String> createOrder(
    OrderModel order,
    List<CartItemModel> items,
  ) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.id;
      if (userId == null) throw 'User not logged in';
      if (items.isEmpty) throw 'Cannot create order with no items';

      // 1. Insert Order
      final orderData = {
        'user_id': userId,
        'status': order.status,
        'total_amount': order.totalAmount,
        'payment_method': order.paymentMethod,
        'payment_status': order.paymentStatus ?? 'Unpaid',
        'shipping_address': order.shippingAddress,
        'billing_address': order.billingAddress,
        'created_at': DateTime.now().toIso8601String(),
      };

      final orderResponse =
          await _db.from('orders').insert(orderData).select().single();

      final orderId = orderResponse['id'] as String;

      // 2. Insert Items (Trigger will handle Stock Update)
      for (var item in items) {
        await _db.from('order_items').insert({
          'order_id': orderId,
          'product_id': item.productId,
          'quantity': item.quantity,
          'price': item.price,
          'total_price': item.price * item.quantity,
          'variation_id': item.variationId,
        });
        // NOTE: No manual stock deduction here.
        // The SQL Trigger 'trg_reduce_stock' does it automatically.
      }

      // 3. Create Transaction Record
      await _db.from('store_transactions').insert({
        'order_id': orderId,
        'amount': order.totalAmount,
        'type': 'Credit', // Income
        'category': 'Sale',
        'description': 'Order #$orderId',
        'transaction_date': DateTime.now().toIso8601String(),
      });

      return orderId;
    } on PostgrestException catch (e) {
      if (e.message.contains('Insufficient stock')) {
        throw 'Insufficient stock for one or more items.';
      }
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error creating order: $e';
    }
  }

  // ============================================
  // ORDER MANAGEMENT
  // ============================================

  /// Update Order Status (Admin)
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _db
          .from('orders')
          .update({
            'status': newStatus,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId);
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error updating order status: $e';
    }
  }

  /// Update Payment Status
  Future<void> updatePaymentStatus(String orderId, String paymentStatus) async {
    try {
      await _db
          .from('orders')
          .update({
            'payment_status': paymentStatus,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId);
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error updating payment status: $e';
    }
  }

  /// Update Delivery Date
  Future<void> updateDeliveryDate(String orderId, DateTime deliveryDate) async {
    try {
      await _db
          .from('orders')
          .update({
            'delivery_date': deliveryDate.toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId);
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error updating delivery date: $e';
    }
  }

  /// Cancel Order and Restore Stock
  Future<void> cancelOrder(String orderId) async {
    try {
      // Use database function to restore stock atomically
      await _db.rpc(
        'restore_stock_from_order',
        params: {'p_order_id': orderId},
      );

      // Update order status
      await _db
          .from('orders')
          .update({
            'status': 'Cancelled',
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId);

      // Update transaction record (mark as refund)
      await _db
          .from('store_transactions')
          .update({
            'type': 'Debit',
            'category': 'Refund',
            'description': 'Order #$orderId - Cancelled',
          })
          .eq('order_id', orderId);
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error cancelling order: $e';
    }
  }

  // ============================================
  // STOCK VERIFICATION
  // ============================================

  /// Check if all items in cart have sufficient stock
  Future<Map<String, dynamic>> verifyCartStock(
    List<CartItemModel> items,
  ) async {
    try {
      final unavailableItems = <Map<String, dynamic>>[];

      for (var item in items) {
        final result = await _db.rpc(
          'check_stock_availability',
          params: {
            'p_product_id': item.productId,
            'p_required_quantity': item.quantity,
          },
        );

        if (result is List && result.isNotEmpty) {
          final stockInfo = result.first;
          if (stockInfo['available'] == false) {
            unavailableItems.add({
              'productId': item.productId,
              'title': stockInfo['product_title'],
              'currentStock': stockInfo['current_stock'],
              'requiredQuantity': item.quantity,
            });
          }
        }
      }

      return {
        'allAvailable': unavailableItems.isEmpty,
        'unavailableItems': unavailableItems,
      };
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error verifying stock: $e';
    }
  }

  // ============================================
  // STATISTICS
  // ============================================

  /// Get Order Statistics
  Future<Map<String, dynamic>> getOrderStatistics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = _db.from('orders').select('status, total_amount');

      if (startDate != null) {
        query = query.gte('created_at', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('created_at', endDate.toIso8601String());
      }

      final result = await query;

      int totalOrders = result.length;
      double totalRevenue = 0;
      Map<String, int> statusCount = {};

      for (var order in result) {
        totalRevenue += (order['total_amount'] as num).toDouble();
        String status = order['status'];
        statusCount[status] = (statusCount[status] ?? 0) + 1;
      }

      return {
        'totalOrders': totalOrders,
        'totalRevenue': totalRevenue,
        'statusBreakdown': statusCount,
      };
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error fetching statistics: $e';
    }
  }

  /// Get User's Order Count
  Future<int> getUserOrderCount(String userId) async {
    try {
      final result = await _db
          .from('orders')
          .count(CountOption.exact)
          .eq('user_id', userId);

      return result;
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Error fetching order count: $e';
    }
  }
}

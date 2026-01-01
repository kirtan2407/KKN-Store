import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/orders/order_repository.dart';
import 'package:kkn_store/features/shop/models/cart_item_model.dart';

class OrderDetailsController extends GetxController {
  final OrderRepository _repo = OrderRepository.instance;
  
  // Observables
  final isLoading = false.obs;
  final orderItems = <CartItemModel>[].obs;

  Future<void> fetchOrderItems(String orderId) async {
    try {
      isLoading.value = true;
      final items = await _repo.fetchOrderItems(orderId);
      orderItems.assignAll(items);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load order items: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

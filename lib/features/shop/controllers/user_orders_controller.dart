import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/orders/order_repository.dart';
import 'package:kkn_store/features/shop/models/order_model.dart';

class UserOrdersController extends GetxController {
  final orderRepo = Get.put(OrderRepository());
  RxList<OrderModel> orders = <OrderModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    try {
      isLoading.value = true;
      final userOrders = await orderRepo.fetchUserOrders();
      orders.assignAll(userOrders);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

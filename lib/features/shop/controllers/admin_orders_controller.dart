import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/orders/order_repository.dart';
import 'package:kkn_store/data/repositories/user/user_repository.dart';
import 'package:kkn_store/features/shop/models/order_model.dart';

class AdminOrdersController extends GetxController {
  final orderRepo = Get.put(OrderRepository());
  final userRepo = Get.put(UserRepository());

  RxList<Map<String, dynamic>> userList = <Map<String, dynamic>>[].obs;
  RxList<OrderModel> selectedUserOrders = <OrderModel>[].obs;
  RxString selectedUserId = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserList();
  }

  // Fetch Users who have orders
  Future<void> fetchUserList() async {
    try {
      isLoading.value = true;
      
      // 1. Get All Orders
      final allOrders = await orderRepo.fetchAllOrders();
      final userIds = allOrders.map((e) => e.userId).toSet().toList();
      
      // 2. Get All Profiles (Or optimize to filter)
      final allProfiles = await userRepo.fetchAllUsers();
      
      final List<Map<String, dynamic>> mappedUsers = [];
      
      for (var uid in userIds) {
         final profile = allProfiles.firstWhere(
           (p) => p['id'] == uid, 
           orElse: () => {'id': uid, 'full_name': 'Unknown User', 'email': 'No Email'}
         );
         
         // Count Orders for this user
         final orderCount = allOrders.where((o) => o.userId == uid).length;
         
         mappedUsers.add({
            ...profile,
            'order_count': orderCount,
         });
      }
      
      userList.assignAll(mappedUsers);
      
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch Orders for Selected User
  Future<void> selectUser(String userId) async {
    try {
      isLoading.value = true;
      selectedUserId.value = userId;
      final orders = await orderRepo.fetchOrdersByUser(userId);
      selectedUserOrders.assignAll(orders);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

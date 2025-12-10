import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';
import 'package:kkn_store/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CartController());
  }
}

import 'package:get/get.dart';
import 'package:kkn_store/features/shop/screens/Cart/pin/pin_controller.dart';


class PinBinding extends Bindings {
  final int noOfDigits;

  PinBinding(this.noOfDigits);

  @override
  void dependencies() {
    Get.lazyPut<PinController>(() => PinController(noOfDigits));
  }
}

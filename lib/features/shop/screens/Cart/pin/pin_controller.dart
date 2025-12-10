import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/features/shop/screens/Cart/pin/home_extra.dart';

class PinController extends GetxController {
  final pin = ''.obs;
  RxBool isLoading = false.obs;
  late int noOfDigits;

  final String correctPin = "002407";

  PinController(this.noOfDigits);

  void addPin(String digit) {
    if (pin.value.length < noOfDigits) {
      pin.value += digit;

      // 👉 When PIN is complete, verify automatically
      if (isPinComplete) {
        verifyPin();
      }
    }
  }

  void deleteDigit() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }

  /// Verify entered PIN
  void verifyPin() {
    if (isPinComplete) {
      if (pin.value == correctPin) {
        debugPrint("✅ PIN Verified Successfully!");
        // 👉 Navigate to HomeExtra page
        Get.offAll(() => const HomeExtra());
      } else {
        debugPrint("❌ Incorrect PIN!");
        // 👉 Show toast/snackbar
        Get.snackbar(
          "Invalid PIN",
          "Please try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        pin.value = ''; // reset pin after wrong entry
      }
    }
  }

  bool get isPinComplete => pin.value.length == noOfDigits;
}

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kkn_store/features/authentication/screens/login/loginscreen.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  /// Variables
  final pageController = PageController();
  Rx<int> curruntPageIndex = 0.obs;

  /// Update Currunt Index when Page Scroll...
  void updatePageIndicator(index) => curruntPageIndex.value = index;

  /// Jump to the specific dot selected Page...
  void dotNavigationClick(index) {
    curruntPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Update Currunt Index & jump to next page
  void nextPage() {
    if (curruntPageIndex.value == 2) {
      Get.to(LoginScreen()); // Navigate to LoginScreen
    } else {
      int page = curruntPageIndex.value + 1;
      pageController.jumpToPage(page); // <-- FIXED
    }
  }

  /// Update Currunt Index & jump to last page
  void skippage() {
    curruntPageIndex.value = 2;
    pageController.jumpToPage(2); // ✅ Fixed
  }
}

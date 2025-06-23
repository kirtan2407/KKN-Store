import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // ✅ ADD
import 'package:kkn_store/features/authentication/screens/login/loginscreen.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> curruntPageIndex = 0.obs;

  void updatePageIndicator(index) => curruntPageIndex.value = index;

  void dotNavigationClick(index) {
    curruntPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (curruntPageIndex.value == 2) {
      final box = GetStorage();
      box.write('isFirstLaunch', false); // ✅ Save onboarding done
      Get.offAll(() => const LoginScreen());
    } else {
      pageController.jumpToPage(curruntPageIndex.value + 1);
    }
  }

  void skippage() {
    curruntPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}

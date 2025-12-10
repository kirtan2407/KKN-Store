import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              // You can use Lottie here if you have the package and asset
              // Lottie.asset(animation, width: 200, height: 200),
              const CircularProgressIndicator(), 
              const SizedBox(height: 25),
              Text(text, style: Theme.of(Get.context!).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customToast(String message) {
  Get.rawSnackbar(
    message: message,
    backgroundColor: Colors.black87,
    borderRadius: 12,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    animationDuration: const Duration(milliseconds: 300),
    duration: const Duration(seconds: 2),
  );
}

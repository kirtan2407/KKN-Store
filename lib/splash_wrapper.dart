import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kkn_store/features/authentication/screens/login/loginscreen.dart';
import 'package:kkn_store/features/authentication/screens/onboarding/onboarding.dart';

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final isFirstLaunch = box.read('isFirstLaunch') ?? true;

    // ✅ Show onboarding only once
    if (isFirstLaunch) {
      return const OnboardingScreen();
    } else {
      return const LoginScreen();
    }
  }
}

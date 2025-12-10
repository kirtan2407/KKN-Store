import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:kkn_store/utils/helpers/network_manager.dart';
import 'package:kkn_store/utils/popups/full_screen_loader.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = "Male".obs;
  final dob = Rx<DateTime?>(null);
  
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// -- SIGNUP
  void signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information...', 'assets/images/animations/loader-animation.json');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register User in the Firebase Auth & Save User Data in the Firebase
      await AuthenticationRepository.instance.registerWithEmailPassword(
        email.text.trim(),
        password.text.trim(),
        "${firstName.text.trim()} ${lastName.text.trim()}",
        phoneNumber.text.trim(),
        username.text.trim(),
        gender.value,
        dob.value?.toIso8601String(),
      );

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

      // Move to Verify Email Screen
      // Get.to(() => const VerifyEmailScreen()); // Already handled in Repository or here if needed
      
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

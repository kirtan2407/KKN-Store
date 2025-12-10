import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kkn_store/features/authentication/screens/login/loginscreen.dart';
import 'package:kkn_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:kkn_store/navigation_menu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;
  final deviceStorage = GetStorage();

  User? get authUser => _supabase.auth.currentUser;

  @override
  void onReady() {
    // Check if user is already logged in
    _redirectBasedOnSession();
    
    // Listen to auth state changes
    _supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        // Navigate to Home/Profile
        // For now, let's go to Profile or a Home screen if you have one
        // Get.offAll(() => const ProfileScreen()); 
      } else if (event == AuthChangeEvent.signedOut) {
        Get.offAll(() => const LoginScreen());
      }
    });
    super.onReady();
  }



  void screenRedirect() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      Get.offAll(() => const NavigationMenu());
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true 
        ? Get.offAll(() => const LoginScreen()) 
        : Get.offAll(() => const OnboardingScreen());
    }
  }

  void _redirectBasedOnSession() {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      // User is logged in
      Get.offAll(() => const NavigationMenu()); 
    } else {
      // User is not logged in, check if first time
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true 
        ? Get.offAll(() => const LoginScreen()) 
        : Get.offAll(() => const OnboardingScreen());
    }
  }

  // Login
  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (res.user != null) {
        deviceStorage.write('IsFirstTime', false); // Update flag
        Get.snackbar('Success', 'Logged in successfully');
        // Navigation is handled by onAuthStateChange listener or manual redirect
        // Get.offAll(() => const NavigationMenu()); 
      }
    } catch (e) {
      if (e.toString().contains('email_not_confirmed')) {
        Get.snackbar(
          'Email Not Verified', 
          'Please check your email and verify your account.',
          duration: const Duration(seconds: 5),
          mainButton: TextButton(
            onPressed: () => resendSignUpEmail(email),
            child: const Text('Resend Email', style: TextStyle(color: Colors.white)),
          ),
        );
      } else {
        Get.snackbar('Error', 'Login failed: ${e.toString()}');
      }
    }
  }

  // Resend Signup Email
  Future<void> resendSignUpEmail(String email) async {
    try {
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      Get.snackbar('Success', 'Verification email sent. Please check your inbox (and spam).');
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend email: ${e.toString()}');
    }
  }

  // Signup
  Future<void> registerWithEmailPassword(String email, String password, String fullName, String phoneNumber, String username, String gender, String? dob) async {
    try {
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone_number': phoneNumber,
          'username': username,
          'gender': gender,
          'dob': dob,
        }
      );

      if (res.user != null) {
        // Profile creation is handled by Supabase Trigger 'on_auth_user_created'
        Get.snackbar('Success', 'Account created successfully. Please verify your email if required.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Signup failed: ${e.toString()}');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    }
  }
}

import 'dart:io';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  // Save user record to 'profiles' table
  Future<void> saveUserRecord(
    User user,
    String fullName,
    String phoneNumber,
    String email,
    String username,
    String gender,
    String dob,
  ) async {
    try {
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'full_name': fullName,
        'phone_number': phoneNumber,
        'email': email,
        'username': username,
        'gender': gender,
        'dob': dob,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to save user data: ${e.toString()}');
    }
  }

  // Fetch user details
  Future<Map<String, dynamic>?> fetchUserDetails() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;

      final data =
          await _supabase
              .from('profiles')
              .select()
              .eq('id', userId)
              .maybeSingle();

      return data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user details: ${e.toString()}');
      return null;
    }
    // Upload Image to Supabase Storage
  }
}

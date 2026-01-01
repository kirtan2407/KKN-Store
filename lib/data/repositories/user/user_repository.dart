import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
      print('DEBUG: Error saving user data: $e');
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
      print('DEBUG: Error fetching user details: $e');
      Get.snackbar('Error', 'Failed to fetch user details: ${e.toString()}');
      return null;
    }
  }

  // Update specific field in user record
  Future<void> updateUserField(String fieldName, dynamic value) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final data = await _supabase.from('profiles').upsert({
        'id': userId,
        fieldName: value,
        'updated_at': DateTime.now().toIso8601String(),
      }).select();
      
      print('DEBUG: Updated User Data: $data');
      Get.snackbar('Success', '$fieldName updated successfully');
    } catch (e) {
      print('DEBUG: Error updating $fieldName: $e');
      Get.snackbar('Error', 'Failed to update $fieldName: ${e.toString()}');
      rethrow;
    }
  }
  // Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final file = File(image.path);
      if (!file.existsSync()) {
        throw const FileSystemException("File not found");
      }

      // Upload image to Storage
      // Syntax: storage.from('bucket_name').upload('path/to/file', file)
      await _supabase.storage.from('avatars').upload(
        path,
        file,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
      );

      // Get Download URL
      final url = _supabase.storage.from('avatars').getPublicUrl(path);
      print('DEBUG: Uploaded Image URL: $url');
      return url;
    } catch (e) {
       // if we encounter an error, we might want to throw it to be caught by the controller
      print('DEBUG: Upload Error: $e');
      throw 'Something went wrong uploading image: $e';
    }
  }
  // Admin: Fetch All Users
  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    try {
      final response = await _supabase.from('profiles').select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Error fetching users: $e';
    }
  }
}

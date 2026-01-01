import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<String?> signupUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
    required String phone,
    required String gender,
    required DateTime dob,
  }) async {
    try {
      // 1️⃣ Create user in Supabase Auth
      final authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        return "Signup failed!";
      }

      final userId = authResponse.user!.id;

      // 2️⃣ Save profile details in "profiles" table
      await supabase.from("profiles").insert({
        "id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "phone": phone,
        "gender": gender,
        "dob": dob.toIso8601String(),
      });

      return null; // success
    } catch (e) {
      return e.toString();
    }
  }
}

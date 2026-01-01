import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kkn_store/app.dart';
import 'package:kkn_store/core/app_secrets.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:kkn_store/data/repositories/user/user_repository.dart';
import 'package:kkn_store/utils/helpers/network_manager.dart';
import 'package:kkn_store/features/personalization/controllers/profile_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Required before using async in main
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init(); 
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  // Initialize app-wide repositories/managers
  
  Get.put(AuthenticationRepository());
  Get.put(UserRepository());
  Get.put(NetworkManager());
  // Fetch user profile immediately on app start
  Get.put(ProfileController());

  // Run the app
  runApp(const App());
}

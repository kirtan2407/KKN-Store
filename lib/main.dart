// // ignore_for_file: unused_import

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:kkn_store/app.dart';
// import 'package:kkn_store/firebase_options.dart';
// import 'package:kkn_store/utils/constants/colors.dart';
// import 'package:kkn_store/utils/theme/theme.dart';
// import 'package:get_storage/get_storage.dart'; // ✅ ADD

// /// -------------- Entry point of Flutter application -------------
// void main() async {  // Todo : Add Widgets Binding
//   // Todo : Init Local Storage
//   // Todo : Await Native Splash
//   // Todo : Initialization Firebase

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform).then(FirebaseApp value)=>Get.put(AuthenticationRepository()),
//   // Todo : Init Firebase Analytics
//   // Todo : Initialize Authantication

//   runApp(const App());
// }

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kkn_store/app.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kkn_store/utils/helpers/network_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Required before using async in main
  WidgetsFlutterBinding.ensureInitialized();

  // Init Local GetStorage
  await GetStorage.init();
  await dotenv.load();
  // Initialize Supabase (REQUIRED for your hybrid setup)
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Initialize Authentication Repository
  Get.put(AuthenticationRepository());
  Get.put(NetworkManager());

  // Run App
  runApp(const App());
}

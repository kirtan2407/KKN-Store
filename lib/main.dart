// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/app.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// -------------- Entry point of Flutter application -------------
Future<void> main() async {
  // Todo : Add Widgets Binding
  // Todo : Init Local Storage
  // Todo : Await Native Splash
  // Todo : Initialization Firebase

  // ...

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  // Todo : Init Firebase Analytics
  // Todo : Initialize Authantication

  runApp(const App());
}

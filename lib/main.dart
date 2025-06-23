// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:kkn_store/app.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/theme/theme.dart';
import 'package:get_storage/get_storage.dart'; // ✅ ADD


/// -------------- Entry point of Flutter application -------------
void main() async {  // Todo : Add Widgets Binding
  // Todo : Init Local Storage
  // Todo : Await Native Splash
  // Todo : Initialization Firebase
  // Todo : Init Firebase Analytics
  // Todo : Initialize Authantication

  WidgetsFlutterBinding.ensureInitialized(); // ✅ Required
  await GetStorage.init(); // ✅ Init GetStorage
  runApp(const App());
}


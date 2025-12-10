import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/splash_wrapper.dart';
import 'package:kkn_store/utils/theme/theme.dart';
import 'package:kkn_store/bindings/general_bindings.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const SplashWrapper(),
    );
  }
}

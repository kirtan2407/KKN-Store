import 'package:flutter/material.dart';
import 'package:kkn_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:kkn_store/utils/theme/theme.dart';
import 'package:get/get.dart';

/// --use this class to setup themes, initial Bindings , an animations and to much
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}

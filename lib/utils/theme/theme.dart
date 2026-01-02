// import 'package:flutter/material.dart';
// import 'package:kkn_store/utils/theme/Custom_themes/text_theme.dart';

// import 'Custom_themes/appbar_theme.dart';
// import 'Custom_themes/bottom_sheet_theme.dart';
// import 'Custom_themes/checkbox_theme.dart';
// import 'Custom_themes/chip_theme.dart';
// import 'Custom_themes/outlined_button_theme.dart';
// import 'Custom_themes/elevated_button_theme.dart';
// // import 'Custom_themes/text_theme.dart';
// import 'Custom_themes/textfield_theme.dart';

// class TAppTheme {
//   TAppTheme._();
// /// Light theme 
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     fontFamily: 'Poppins',
//     brightness: Brightness.light,
//     primaryColor: Colors.blue,
//     scaffoldBackgroundColor: Colors.white,
//     textTheme: TTextTheme.lightTextTheme,
//     chipTheme: TChipTheme.lightChipTheme,
//     appBarTheme: TAppBarTheme.LightAppBarTheme,
//     checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
//     bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
//     elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
//     outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
//     inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
//   );

//   /// Dark theme
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     fontFamily: 'Poppins',
//     brightness: Brightness.dark,
//     primaryColor: Colors.blue,
//     scaffoldBackgroundColor: Colors.black,
//     textTheme: TTextTheme.darkTextTheme,
//     chipTheme: TChipTheme.darkChipTheme,
//     appBarTheme: TAppBarTheme.darkAppBarTheme,
//     checkboxTheme: TCheckboxTheme.DarkCheckboxTheme,
//     bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
//     elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
//     outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
//     inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
//   );
// }
import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/colors.dart'; // Ensure this path is correct
import 'package:kkn_store/utils/theme/Custom_themes/text_theme.dart';
import 'Custom_themes/appbar_theme.dart';
import 'Custom_themes/bottom_sheet_theme.dart';
import 'Custom_themes/checkbox_theme.dart';
import 'Custom_themes/chip_theme.dart';
import 'Custom_themes/outlined_button_theme.dart';
import 'Custom_themes/elevated_button_theme.dart';
import 'Custom_themes/textfield_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: TColors.primaryColor,
    scaffoldBackgroundColor: TColors.light, // Using the new slate-light
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.LightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: TColors.primaryColor,
    scaffoldBackgroundColor: TColors.dark, // Using the deep midnight navy
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.DarkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
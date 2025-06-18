import 'package:flutter/material.dart';
import 'package:kkn_store/common/style/spacing_style.dart';
import 'package:kkn_store/common/widgets/widget_login_singin/form_divider.dart';
import 'package:kkn_store/common/widgets/widget_login_singin/social_button.dart';
import 'package:kkn_store/features/authentication/screens/login/Widgets/login_header.dart';
import 'package:kkn_store/common/widgets/widget_login_singin/login_divider.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.PaddingwithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Logo , title & subtitle
              LoginHeader(dark: dark),
              const SizedBox(height: TSizes.sm),

              /// --- Form ---
              LoginForm(),

              /// Divider
              LoginDivider(dark: dark),
              const SizedBox(height: TSizes.spaceBtwsections),

              /// Footer
              const LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

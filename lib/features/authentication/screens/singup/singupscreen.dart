import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/widget_login_singin/login_divider.dart';
import 'package:kkn_store/common/widgets/widget_login_singin/social_button.dart';
import 'package:kkn_store/features/authentication/screens/singup/widgets/singup_form.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/constants/text_string.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios_new,
      //       color: dark ? TColors.light : TColors.dark,
      //     ),
      //     onPressed: () => Navigator.of(context).pop(), // 👈 Go back
      //   ),
      // ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: dark ? TColors.light : TColors.dark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- title ---
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems * 2),

              /// --- form ---
              const SingupForm(),
              SizedBox(height: TSizes.spaceBtwsections),

              /// --- Divider ---
              const singupDivider(),
              const SizedBox(height: TSizes.spaceBtwsections),

              /// social Icons
              const LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

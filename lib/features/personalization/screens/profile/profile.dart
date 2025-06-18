import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/images/TCircularImages.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/personalization/screens/profile/Widgets/profile_menu.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: KknAppbar(title: Text('Profile'), showArrowBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpacing),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TCircularImage(
                      dark: dark,
                      image: TImages.userAvatar2,
                      width: 80,
                      height: 80,
                      backgroundcolor: dark ? TColors.white : TColors.black,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    ),

                    /// Details
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    ///--- Profile Information
                    const TSectionHeading(
                      title: 'Profile Information',
                      showActionButton: false,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TProfileMenu(
                      title: 'Name',
                      value: 'Kirtan Kankotiya',
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'Username',
                      value: 'Kirtan',
                      onPressed: () {},
                    ),

                    /// ---- Divider
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// --- Personal Information
                    const TSectionHeading(
                      title: 'Personal Information',
                      showActionButton: false,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TProfileMenu(
                      title: 'UserId',
                      value: 'kkn5332',
                      icon: Iconsax.copy4,
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'Email',
                      value: 'kirtan@kkn.com',
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'Phone Number',
                      value: ' +91 87581 94251',
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'Gender',
                      value: 'Male',
                      onPressed: () {},
                    ),
                    TProfileMenu(
                      title: 'Date of Birth',
                      value: '24 Jul 2006',
                      onPressed: () {},
                    ),

                    ///divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Close Account',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: TSizes.fontSizesm,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/images/TCircularImages.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/personalization/controllers/profile_controller.dart';
import 'package:kkn_store/features/personalization/screens/profile/Widgets/profile_menu.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const KknAppbar(title: Text('Profile'), showArrowBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpacing),
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

                    Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final user = controller.userProfile.value;
                      return Column(
                        children: [
                          TProfileMenu(
                            title: 'Name',
                            value: user['full_name'] ?? 'N/A',
                            onPressed: () {},
                          ),
                          TProfileMenu(
                            title: 'Username',
                            value: user['username'] ?? 'N/A',
                            onPressed: () {},
                          ),
                        ],
                      );
                    }),

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

                    Obx(() {
                      final user = controller.userProfile.value;
                      return Column(
                        children: [
                          TProfileMenu(
                            title: 'UserId',
                            value: user['id'] ?? 'N/A',
                            icon: Iconsax.copy4,
                            onPressed: () {},
                          ),
                          TProfileMenu(
                            title: 'Email',
                            value: user['email'] ?? 'N/A',
                            onPressed: () {},
                          ),
                          TProfileMenu(
                            title: 'Phone No',
                            value: user['phone_number'] ?? 'N/A',
                            onPressed: () {
                              Get.defaultDialog();
                            },
                          ),
                          TProfileMenu(
                            title: 'Gender',
                            value: user['gender'] ?? 'N/A',
                            onPressed: () {},
                          ),
                          TProfileMenu(
                            title: 'Date of Birth',
                            value:
                                user['dob'] != null
                                    ? user['dob'].toString().split('T')[0]
                                    : 'N/A',
                            onPressed: () {},
                          ),
                        ],
                      );
                    }),

                    ///divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    Center(
                      child: TextButton(
                        onPressed: () => controller.logout(),
                        child: const Text(
                          'Logout',
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

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
                    Obx(() {
                      final networkImage = controller.userProfile.value['avatar_url'] as String?;
                      final image = networkImage ?? TImages.userAvatar2;
                      return TCircularImage(
                        dark: dark,
                        image: image,
                        isNetworkImage: networkImage != null,
                        width: 80,
                        height: 80,
                        backgroundcolor: dark ? TColors.white : TColors.black,
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
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
                            onPressed:
                                () => _showEditDialog(
                                  context,
                                  controller,
                                  'Full Name',
                                  'full_name',
                                  user['full_name'] ?? '',
                                ),
                          ),
                          TProfileMenu(
                            title: 'Username',
                            value: user['username'] ?? 'N/A',
                            onPressed:
                                () => _showEditDialog(
                                  context,
                                  controller,
                                  'Username',
                                  'username',
                                  user['username'] ?? '',
                                ),
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
                            onPressed:
                                () => _showEditDialog(
                                  context,
                                  controller,
                                  'Email',
                                  'email',
                                  user['email'] ?? '',
                                ),
                          ),
                          TProfileMenu(
                            title: 'Phone No',
                            value: user['phone_number'] ?? 'N/A',
                            onPressed:
                                () => _showEditDialog(
                                  context,
                                  controller,
                                  'Phone Number',
                                  'phone_number',
                                  user['phone_number'] ?? '',
                                ),
                          ),
                          TProfileMenu(
                            title: 'Gender',
                            value: user['gender'] ?? 'N/A',
                            onPressed:
                                () => _showEditDialog(
                                  context,
                                  controller,
                                  'Gender',
                                  'gender',
                                  user['gender'] ?? '',
                                ),
                          ),
                          TProfileMenu(
                            title: 'Date of Birth',
                            value:
                                user['dob'] != null
                                    ? user['dob'].toString().split('T')[0]
                                    : 'N/A',
                            onPressed:
                                () => _showEditDialog(
                                  context,
                                  controller,
                                  'Date of Birth (YYYY-MM-DD)',
                                  'dob',
                                  user['dob']?.toString().split('T')[0] ?? '',
                                ),
                          ),
                        ],
                      );
                    }),

                    ///divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: const Text(
                                  "Confirm Logout",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(fontSize: 14),
                                ),
                                actions: [
                                  // Cancel Button
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("Cancel"),
                                  ),

                                  // Confirm Logout Button (Outlined Red)
                                  OutlinedButton(
                                    onPressed: () {
                                      Get.back(); // close dialog
                                      controller.logout(); // logout
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                      foregroundColor: Colors.red,
                                    ),
                                    child: const Text("Logout"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 1.5),
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 130,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: TSizes.fontSizesm,
                            fontWeight: FontWeight.w600,
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

  void _showEditDialog(
    BuildContext context,
    ProfileController controller,
    String title,
    String field,
    String currentValue,
  ) {
    final textController = TextEditingController(text: currentValue);
    Get.defaultDialog(
      title: 'Update $title',
      content: TextFormField(
        controller: textController,
        decoration: InputDecoration(labelText: title),
      ),
      textConfirm: 'Save',
      textCancel: 'Cancel',
      onConfirm: () {
        controller.updateProfileField(field, textController.text.trim());
        Get.back();
      },
    );
  }
}

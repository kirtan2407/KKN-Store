import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/custom_shaps/container/primary_header_container.dart';
import 'package:kkn_store/common/widgets/list-tile/settings_menu_tile.dart';
import 'package:kkn_store/common/widgets/list-tile/userprofilelisttile.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/my_coupons.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/personalization/screens/address/adress.dart';
import 'package:kkn_store/features/personalization/screens/profile/profile.dart';
import 'package:kkn_store/features/shop/screens/Cart/cart.dart';
import 'package:kkn_store/features/shop/screens/Order/order.dart';
import 'package:kkn_store/features/shop/screens/admin/admin_dashboard.dart';
import 'package:kkn_store/features/shop/screens/admin/admin_user_list_screen.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/features/personalization/controllers/profile_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// --- Header ---
            TPrimaryHeaderConatainer(
              child: Column(
                children: [
                  /// --- Appbar ---
                  KknAppbar(
                    title: Text(
                      'Account',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: TColors.white),
                    ),
                  ),

                  ///user Profile Card
                  UserProfileTile(
                    dark: dark,
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwsections),
                ],
              ),
            ),

            /// --- Body ----
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpacing),
              child: Column(
                children: [
                  /// -- Account Settings
                  TSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  TSettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressSscreen()),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all the discounted coupons',
                    onTap: () => Get.to(() => const MyCoupons()),
                  ),
                  // TSettingMenuTile(
                  //   icon: Iconsax.notification,
                  //   title: 'Notifications',
                  //   subTitle: 'Set any kind of notification message',
                  // ),
                  TSettingMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected accounts',
                  ),

                  /// -- App Settings
                  SizedBox(height: TSizes.spaceBtwsections),
                  TSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  TSettingMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data to your Cloud Firebase',
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),

                  TSettingMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  TSettingMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// -- Admin Panel (Store Management)
                  const SizedBox(height: TSizes.spaceBtwsections),
                  const TSectionHeading(
                    title: 'Admin Management',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  
                  TSettingMenuTile(
                    icon: Iconsax.bag_2,
                    title: 'Store Bank (Ledger)',
                    subTitle: 'View Sales, Profits, and Transactions',
                    onTap: () => Get.to(() => const AdminDashboardScreen()),
                  ),

                  /// --- Logout Button
                  const SizedBox(height: TSizes.spaceBtwsections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text(
                                "Confirm Action",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                "Are you sure you want to delete this account of ${controller.email}?",
                                style: const TextStyle(fontSize: 14),
                              ),
                              actions: [
                                // Cancel Button
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("Cancel"),
                                ),

                                // Logout Button (Outlined)
                                OutlinedButton(
                                  onPressed: () {
                                    Get.back(); // close dialog
                                    controller.logout(); // perform logout
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
                      child: const Text('Logout'),
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwsections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

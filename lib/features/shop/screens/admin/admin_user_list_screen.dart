import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/features/shop/controllers/admin_orders_controller.dart';
import 'package:kkn_store/features/shop/screens/admin/admin_user_orders_screen.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class AdminUserListScreen extends StatelessWidget {
  const AdminUserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminOrdersController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const KknAppbar(
        showArrowBack: true,
        title: Text('Users Orders'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (controller.userList.isEmpty) return const Center(child: Text('No orders found.'));

        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
            itemCount: controller.userList.length,
            separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final user = controller.userList[index];
              return ListTile(
                onTap: () {
                   controller.selectUser(user['id']);
                   Get.to(() => AdminUserOrdersScreen(user: user));
                },
                tileColor: dark ? TColors.darkContainer : TColors.lightContainer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.cardRadiusLg)),
                leading: const CircleAvatar(child: Icon(Iconsax.user)),
                title: Text(user['full_name'] ?? 'Guest'),
                subtitle: Text(user['email'] ?? ''),
                trailing: Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                   decoration: BoxDecoration(
                      color: TColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                   ),
                   child: Text('${user['order_count']} Orders', style: const TextStyle(color: TColors.primaryColor, fontSize: 12)),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

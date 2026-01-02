import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/cart_menu_icon.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/text_string.dart';
import 'package:kkn_store/utils/constants/texts.dart';
import 'package:kkn_store/features/personalization/controllers/profile_controller.dart';
import 'package:iconsax/iconsax.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return KknAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final fullName =
                controller.userProfile.value['full_name'] ?? 'User';
            final firstName = fullName.split(' ')[0];
            return Text(
              'Hey $firstName 👋',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.apply(color: TColors.white),
            );
          }),
          const SizedBox(height: 4), // Reduced spacing slightly for tightness
          Text(
            TTexts.welcomeBack, // New subtitle
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: TColors.grey),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.notification, color: TColors.white),
        ),
        const SizedBox(width: 8),
        TCartCounterIcon(onPressed: () {}, iconColor: TColors.white),
      ],
    );
  }
}

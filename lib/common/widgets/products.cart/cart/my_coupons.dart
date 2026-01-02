import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/features/shop/controllers/user_promos_controller.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class MyCoupons extends StatelessWidget {
  const MyCoupons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserPromosController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const KknAppbar(title: Text('My Coupons'), showArrowBack: true),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (controller.activePromos.isEmpty) return const Center(child: Text('No active coupons available.'));

        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
            itemCount: controller.activePromos.length,
            separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final promo = controller.activePromos[index];
               return TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.md),
                  showBorder: true,
                  backgroundColor: dark ? TColors.dark : TColors.light,
                  child: Row(
                     children: [
                        // Icon
                        const Icon(Iconsax.ticket, color: TColors.primaryColor, size: 40),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        
                        // Details
                        Expanded(
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(promo.code, style: Theme.of(context).textTheme.headlineSmall),
                                 Text('${promo.discountPercent}% OFF', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                           ),
                        ),
                        
                        // Copy Button (Optional)
                        IconButton(
                           onPressed: () {
                              // Clipboard copy logic could go here
                              Get.snackbar('Copied', 'Coupon code copied to clipboard');
                           },
                           icon: const Icon(Iconsax.copy),
                        ),
                     ],
                  ),
               );
            },
          ),
        );
      }),
    );
  }
}

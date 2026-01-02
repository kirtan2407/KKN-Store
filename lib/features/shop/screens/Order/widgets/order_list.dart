import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/user_orders_controller.dart';
import 'package:kkn_store/features/shop/screens/Order/order_details.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserOrdersController());
    final dark = THelperFunctions.isDarkMode(context);
    
    return Obx(() {
       if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
       if (controller.orders.isEmpty) return const Center(child: Text('No orders found'));
       
       return ListView.separated(
        itemCount: controller.orders.length,
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          final order = controller.orders[index];
          final dateStr = order.formattedOrderDate;
          
          return GestureDetector(
            onTap: () => Get.to(() => OrderDetailsScreen(order: order)),
            child: TRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // row1
                  Row(
                    children: [
                      // 1.Icon
                      const Icon(Iconsax.ship),
                      const SizedBox(width: TSizes.defaultSpace),

                      // 2.Status & date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.status,
                              style: Theme.of(context).textTheme.bodyLarge!.apply(
                                color: order.status == 'Pending' ? Colors.orange : TColors.primaryColor,
                                fontWeightDelta: 1,
                              ),
                            ),
                            Text(
                              dateStr,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => OrderDetailsScreen(order: order)),
                        icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // row2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // 1.Icon
                            const Icon(Iconsax.tag),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),

                            // 2.Status & date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    '[#${order.id.substring(0, 5)}]',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            // 1.Icon
                            const Icon(Iconsax.moneys),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),

                            // 2.Status & date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    '₹${order.totalAmount.toStringAsFixed(1)}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

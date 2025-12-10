import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(() {
      final subTotal = controller.totalCartPrice.value;
      final shippingFee = 0.0; // TODO: Calculate shipping
      final taxFee = subTotal * 0.18; // 18% Tax
      final total = subTotal + shippingFee + taxFee;

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: TextTheme.of(context).bodyMedium),
              Text('₹${subTotal.toStringAsFixed(1)}', style: TextTheme.of(context).bodyMedium),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),

          /// Shiping Fees
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping Fee', style: TextTheme.of(context).bodyMedium),
              Text('₹${shippingFee.toStringAsFixed(1)}', style: TextTheme.of(context).labelLarge),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),

          /// Tax Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax Fee', style: TextTheme.of(context).bodyMedium),
              Text('₹${taxFee.toStringAsFixed(1)}', style: TextTheme.of(context).labelLarge),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),

          /// Order Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Total', style: TextTheme.of(context).bodyMedium),
              Text('₹${total.toStringAsFixed(1)}', style: TextTheme.of(context).titleMedium),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
        ],
      );
    });
  }
}

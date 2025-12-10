import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Obx(() {
        final controller = CartController.instance;
        controller.updateAlreadyAddedProductCount(product);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularIcon(
                  dark: dark,
                  icon: Iconsax.minus,
                  backgroundColor: TColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(controller.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(width: TSizes.spaceBtwItems),
                TCircularIcon(
                  dark: dark,
                  icon: Iconsax.add,
                  backgroundColor: TColors.dark,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                ),
              ],
            ),
            // SizedBox(width: TSizes.defaultSpace),
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1 ? null : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.dark,
                side: const BorderSide(color: TColors.black),
              ),
              child: Text('Add to Cart', style: TextStyle(color: TColors.light)),
            ),
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/add_remove_button.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/cart_Item.dart';
import 'package:kkn_store/common/widgets/text/product_price_text.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder:
          (_, __) => const SizedBox(height: TSizes.spaceBtwsections),
      itemCount: 2,
      itemBuilder:
          (_, index) => Column(
            children: [
              const TCartItem(),
              if (showAddRemoveButton)
                const SizedBox(height: TSizes.spaceBtwItems),

              /// Quantity Control and Price Row
              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Left Side: Spacer + Quantity Controls
                    Row(
                      children: [
                        /// Extra Space to align with image
                        const SizedBox(width: 70),

                        /// Add/Remove Buttons
                        TProductQuantityAddOrRemove(dark: dark),
                      ],
                    ),

                    /// Right Side: Total Price
                    const TProductPriceText(price: '8988'),
                  ],
                ),
            ],
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/add_remove_button.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/cart_item.dart';
import 'package:kkn_store/common/widgets/text/product_price_text.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    
    return Obx(() {
      if (controller.cartItems.isEmpty) {
        return const Center(child: Text('No items in cart'));
      }
      
      return ListView.separated(
        shrinkWrap: true,
        separatorBuilder:
            (_, __) => const SizedBox(height: TSizes.spaceBtwsections),
        itemCount: controller.cartItems.length,
        itemBuilder:
            (_, index) => Column(
              children: [
                TCartItem(cartItem: controller.cartItems[index]),
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
                          TProductQuantityAddOrRemove(
                            dark: dark,
                            quantity: controller.cartItems[index].quantity,
                            add: () => controller.addOneToCart(controller.cartItems[index]),
                            remove: () => controller.removeOneFromCart(controller.cartItems[index]),
                          ),
                        ],
                      ),

                      /// Right Side: Total Price
                      TProductPriceText(price: (controller.cartItems[index].price * controller.cartItems[index].quantity).toStringAsFixed(1)),
                    ],
                  ),
              ],
            ),
      );
    });
  }
}

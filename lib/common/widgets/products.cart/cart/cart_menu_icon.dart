import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/features/shop/screens/Cart/cart.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });
  final VoidCallback onPressed;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: Icon(Iconsax.shopping_bag, color: iconColor),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: dark ? TColors.black : TColors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  '3',
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                    color: dark ? TColors.white : TColors.black,
                    fontSizeFactor: 0.99,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

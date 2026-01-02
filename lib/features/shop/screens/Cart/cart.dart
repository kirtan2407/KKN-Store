// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/add_remove_button.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/cart_item.dart';
import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
import 'package:kkn_store/common/widgets/text/product_price_text.dart';
import 'package:kkn_store/common/widgets/text/product_title.dart';
import 'package:kkn_store/features/shop/screens/Cart/Widgets/cart_Items.dart';
import 'package:kkn_store/features/shop/screens/Checkout/checkout.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/Product_Attribute.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: KknAppbar(
        showArrowBack: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpacing),
        // cart items list / add remove buttons
        child: CartItems(),
      ),

      ///checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckOutScreen()),
          child: Obx(() => Text('CheckOut ₹${Get.find<CartController>().totalCartPrice.value.toStringAsFixed(1)}')),
        ),
      ),
    );
  }
}

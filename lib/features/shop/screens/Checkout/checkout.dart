// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/coupon_code.dart';
import 'package:kkn_store/common/widgets/success_scren/success_screen.dart';
import 'package:kkn_store/features/shop/screens/Cart/Widgets/cart_Items.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';
import 'package:kkn_store/features/shop/screens/Checkout/Widgets/billing_address_section.dart';
import 'package:kkn_store/features/shop/screens/Checkout/Widgets/billing_payment_section.dart';
import 'package:kkn_store/features/shop/screens/Checkout/Widgets/billing_amount_section.dart';
import 'package:kkn_store/features/shop/screens/Home/home.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/navigation_menu.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:lottie/lottie.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: KknAppbar(
        showArrowBack: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpacing),
          child: Column(
            children: [
              // item in cart
              const CartItems(showAddRemoveButton: false),
              const SizedBox(height: TSizes.spaceBtwsections),

              // Coupon Textfield
              // Coupon Input Section
              TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwsections),

              // Billing Section
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    // Pricing
                    TBillingAmountSection(),
                    const SizedBox(height: TSizes.spaceBtwsections / 2),

                    // Divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwsections / 2),

                    // Payment Methods
                    TBillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwsections / 2),

                    // Address
                    TBillingAddressSection(),
                    // const SizedBox(height: TSizes.spaceBtwsections),
                  ],
                ),
              ),
              // const SizedBox(height: TSizes.spaceBtwsections),
            ],
          ),
        ),  
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed:
              () => Get.to(
                () => SuccessScreen(
                  image: TImages.successLottie11,
                  title: 'Payment Success!',
                  subTitle: 'Your item will be shipped soon!',
                  onPressed: () => Get.offAll(() => const NavigationMenu()),
                ),
              ),
          child: Obx(() {
            final subTotal = Get.find<CartController>().totalCartPrice.value;
            final taxFee = subTotal * 0.18;
            final total = subTotal + taxFee;
            return Text('CheckOut ₹${total.toStringAsFixed(1)}');
          }),
        ),
      ),
    );
  }
}
// 

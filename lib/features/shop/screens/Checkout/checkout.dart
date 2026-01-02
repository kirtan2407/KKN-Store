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
import 'package:kkn_store/features/shop/controllers/order_controller.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
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
          onPressed: () {
            final cartController = CartController.instance;
            final subTotal = cartController.totalCartPrice.value;
            final discount = cartController.discountAmount.value;
            final taxFee = (subTotal - discount) * 0.18;
            final total = (subTotal - discount) + taxFee;

            if (total <= 0) {
               TLoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items to checkout.');
               return;
            }

            // Show QR Code Dialog
            Get.defaultDialog(
              title: 'Scan to Pay',
              content: Column(
                children: [
                   const Text('Scan this QR code to pay', style: TextStyle(fontWeight: FontWeight.bold)),
                   const SizedBox(height: 16),
                   // Placeholder QR - Replace with Asset or Network Image
                   const Icon(Icons.qr_code_2, size: 200, color: Colors.black), 
                   const SizedBox(height: 16),
                   Text('Amount: ₹${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              confirm: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close Dialog
                    final orderController = Get.put(OrderController());
                    orderController.processOrder(total);
                  }, 
                  child: const Text('Confirm Payment Paid')
                ),
              ),
              cancel: SizedBox(
                width: double.infinity, 
                child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Cancel'))
              ),
            );
          },
          child: Obx(() {
            final controller = CartController.instance;
            final subTotal = controller.totalCartPrice.value;
            final discount = controller.discountAmount.value;
            final taxFee = (subTotal - discount) * 0.18;
            final total = (subTotal - discount) + taxFee;
            return Text('Pay ₹${total.toStringAsFixed(1)}');
          }),
        ),
      ),
    );
  }
}
// 

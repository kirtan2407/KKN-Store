import 'package:flutter/material.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';


class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
        final dark = THelperFunctions.isDarkMode(context);
        final controller = TextEditingController();

    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.light,
      child: Padding(
        padding: const EdgeInsets.only(
          top: TSizes.sm,
          bottom: TSizes.sm,
          right: TSizes.sm,
          left: TSizes.md,
        ),
        child: Row(
          children: [
            /// Promo Code Input with border
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Have a promo code? Enter here',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: TSizes.sm),
    
            /// Apply Button with border
            SizedBox(
              width: 85,
              child: OutlinedButton(
                onPressed: () {
                    final code = controller.text.trim();
                    if (code.isNotEmpty) {
                       CartController.instance.applyPromoCode(code);
                       controller.clear();
                    }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      dark
                          ? TColors.white.withOpacity(0.9)
                          : TColors.dark.withOpacity(0.9),
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

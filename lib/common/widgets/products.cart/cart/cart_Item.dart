
import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
import 'package:kkn_store/common/widgets/text/product_title.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:kkn_store/features/shop/models/cart_item_model.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        /// Product Image
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor:
              dark
                  ? TColors.darkerGrey
                  : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
    
        /// Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: TProductsTitleText(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),
    
              /// Attribute
              if (cartItem.selectedVariation != null)
                Text.rich(
                  TextSpan(
                    children: cartItem.selectedVariation!.entries.map((e) => TextSpan(
                      children: [
                        TextSpan(text: '${e.key}: ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: '${e.value} ', style: Theme.of(context).textTheme.bodyLarge),
                      ]
                    )).toList(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

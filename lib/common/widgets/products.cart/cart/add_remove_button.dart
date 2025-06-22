
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class TProductQuantityAddOrRemove extends StatelessWidget {
  const TProductQuantityAddOrRemove({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          dark: dark,
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          color: dark ? TColors.white : TColors.black,
          backgroundColor:
              dark ? TColors.darkerGrey : TColors.light,
          size: TSizes.md,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text(
          '2',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        TCircularIcon(
          dark: dark,
          icon: Iconsax.add,
          width: 32,
          height: 32,
          color: TColors.white,
          backgroundColor: TColors.primaryColor,
          size: TSizes.md,
        ),
      ],
    );
  }
}

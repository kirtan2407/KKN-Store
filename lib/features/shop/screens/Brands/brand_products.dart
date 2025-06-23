import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/products.cart/sorttable/sortable_products.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/TCard.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const KknAppbar(title: Text('Nike')),

      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Brand Details
              TBrandCard(dark: dark, showBorder: true),
              SizedBox(height: TSizes.spaceBtwsections),

              TSortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}

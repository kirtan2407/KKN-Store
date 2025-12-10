import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/products.cart/sorttable/sortable_products.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/TCard.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

import 'package:kkn_store/features/shop/models/brand_model.dart';
import 'package:kkn_store/features/shop/controllers/brand_controller.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: KknAppbar(title: Text(brand.name)),

      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Brand Details
              TBrandCard(dark: dark, showBorder: true, brand: brand),
              const SizedBox(height: TSizes.spaceBtwsections),

              FutureBuilder(
                future: BrandController.instance.getBrandProducts(brand.id, -1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong!'));
                  }
                  final products = snapshot.data as List<ProductModel>;
                  if (products.isEmpty) {
                    return Center(child: Text('No Products Found!'));
                  }
                  return TSortableProducts(products: products);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

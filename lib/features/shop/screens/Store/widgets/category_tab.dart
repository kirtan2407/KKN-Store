import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/brands/brand_show_case.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_vertical.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/controllers/category_controller.dart';
import 'package:kkn_store/features/shop/controllers/product_controller.dart';
import 'package:kkn_store/features/shop/controllers/brand_controller.dart';
import 'package:kkn_store/features/shop/models/category_model.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final _ = CategoryController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    
    // Fetch products for this category (Mocking for now or implement in controller)
    // For now, we will use the dummy products from the controller or fetch specific ones
    // Ideally: controller.getCategoryProducts(category.id)
    
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpacing),
          child: Column(
            children: [
              /// ---brands---
              /// ---brands---
              Obx(() {
                final brandController = Get.put(BrandController());
                if (brandController.isLoading.value) return const Center(child: CircularProgressIndicator());
                
                if (brandController.featuredBrands.isEmpty) {
                  return const SizedBox();
                }

                // Display first 2 featured brands for now
                return Column(
                  children: brandController.featuredBrands.take(2).map((brand) {
                    return TBrandShowCase(
                      dark: dark,
                      brand: brand,
                      images: [TImages.nikeshoes, TImages.nikejacket, TImages.nikem], // TODO: Fetch real top product images for this brand
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// ---haedings---
              TSectionHeading(
                title: 'You might like',
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// ---
              /// ---
              FutureBuilder(
                future: Get.put(ProductController()).fetchProductsByCategory(category.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || (snapshot.data as List<ProductModel>).isEmpty) {
                    return Center(child: Text('No products found in this category.', style: Theme.of(context).textTheme.bodyMedium));
                  }

                  final products = snapshot.data as List<ProductModel>;
                  return TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) => TProductCardVertical(product: products[index]),
                  );
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}

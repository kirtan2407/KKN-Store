import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_vertical.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Find existing controller instead of creating new one
    final controller = Get.find<AllProductsController>();
    
    // REMOVED the problematic assignProducts logic that was causing the blink!
    // The controller already has the products, no need to reassign

    return Column(
      children: [
        // Dropdown
        Obx(() => DropdownButtonFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.sort),
          ),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value as String);
          },
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity',
          ]
              .map(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ),
              )
              .toList(),
        )),
        const SizedBox(height: TSizes.defaultSpace),

        // Products Grid
        Obx(() {
          return TGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => TProductCardVertical(
              product: controller.products[index],
            ),
          );
        }),
      ],
    );
  }
}
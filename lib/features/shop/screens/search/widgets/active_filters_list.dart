import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';
import 'package:kkn_store/features/shop/controllers/brand_controller.dart';
import 'package:kkn_store/features/shop/controllers/category_controller.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class ActiveFiltersList extends StatelessWidget {
  const ActiveFiltersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllProductsController>();
    final categoryController = Get.put(CategoryController());
    final brandController = Get.put(BrandController());
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      final activeFilters = <Widget>[];

      // 1. Categories
      for (var categoryId in controller.searchCategoryIds) {
        final category = categoryController.allCategories
            .firstWhereOrNull((c) => c.id == categoryId);
        if (category != null) {
          activeFilters.add(
            _buildChip(
              context, 
              label: category.name, 
              onDeleted: () => controller.removeCategoryFilter(categoryId),
              dark: dark
            )
          );
        }
      }

      // 2. Brands
      for (var brandId in controller.searchBrandIds) {
        final brand = brandController.allBrands
            .firstWhereOrNull((b) => b.id == brandId);
        
        // If brand not found in currently loaded list, we might just skip or show "Brand"
        // Ideally we should have it, as filters generally come from loaded content.
        if (brand != null) {
          activeFilters.add(
              _buildChip(
                context, 
                label: brand.name, 
                onDeleted: () => controller.removeBrandFilter(brandId),
                dark: dark
              )
          );
        }
      }

      // 3. Discount
      if (controller.minSalePercentage.value > 0) {
        activeFilters.add(
             _buildChip(
              context, 
              label: '${controller.minSalePercentage.value.toInt()}%+ Off', 
              onDeleted: () => controller.removeSaleFilter(),
              dark: dark
            )
        );
      }

      // 4. Rating
      if (controller.minRating.value > 0) {
        activeFilters.add(
            _buildChip(
              context, 
              label: '${controller.minRating.value.toInt()}+ Stars', 
              onDeleted: () => controller.removeRatingFilter(),
              dark: dark
            )
        );
      }

      if (activeFilters.isEmpty) return const SizedBox.shrink();

      return SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          children: activeFilters.map((e) => Padding(padding: const EdgeInsets.only(right: 8), child: e)).toList(),
        ),
      );
    });
  }

  Widget _buildChip(BuildContext context, {required String label, required VoidCallback onDeleted, required bool dark}) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: onDeleted,
      backgroundColor: dark ? TColors.darkerGrey : TColors.light,
      labelStyle: TextStyle(color: dark ? TColors.white : TColors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

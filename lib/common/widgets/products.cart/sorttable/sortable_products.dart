
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_vertical.dart';
import 'package:kkn_store/features/shop/controllers/brand_product_controller.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
    this.useBrandController = false,
    this.controller,
    this.products,
  });

  final bool useBrandController;
  final AllProductsController? controller;
  final List<ProductModel>? products;

  @override
  Widget build(BuildContext context) {
    // Get the appropriate controller
    // Priority: 1. Passed controller, 2. BrandController (if flag true), 3. Global AllProductsController
    final AllProductsController? allProductsController = controller ?? (useBrandController ? null : Get.find<AllProductsController>());
    final brandProductsController = useBrandController ? Get.find<BrandProductsController>() : null;

    return Column(
      children: [
        // Dropdown
        Obx(() => DropdownButtonFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.sort),
          ),
          value: useBrandController 
              ? brandProductsController!.selectedSortOption.value 
              : allProductsController!.selectedSortOption.value,
          onChanged: (value) {
            if (useBrandController) {
              brandProductsController!.sortProducts(value as String);
            } else {
              if (products != null && allProductsController != null) {
                  // If using explicit list, we need a way to sort it. 
                  // For now, let's assume the controller can handle it or we reuse the sort method 
                  // but we might need to tell controller to sort THIS list.
                  // Simplest: Controller's sort method updates internal observable. 
                  // If we passed a simple list, we can't observe changes unless it's RxList.
                  // So let's rely on the controller method which sorts the observable.
                  // If 'products' is passed, it implies the callee handles state or it's just static.
                  // For SearchScreen, it IS an RxList (searchResults).
                  
                  // ACTUALLY: SearchScreen passes searchResults (RxList). 
                  // If we use TSortableProducts inside Obx in SearchScreen, it receives the list value.
                  // We need to call controller.sortSearchResults(value).
                  
                  // Let's modify logic: If explicit products are passed, sorting might be disabled or handled outside? 
                  // Requirement: "Server-side search with .ilike() ... Pagination". Sorting is usually server side too.
                  // But we kept client sort for now.
                  
                  // Better approach: TSortableProducts is UI. It triggers sort on controller.
                  allProductsController.sortSearchResults(value as String);
              } else {
                  allProductsController!.sortProducts(value as String);
              }
            }
          },
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
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
        // If products (List) is passed, use it. But we want Obx if it's reactive?
        // In SearchScreen, we wrap TSortableProducts in Obx, so 'products' passed is the current list value.
        // So we don't need Obx INSIDE here for the list itself if we just render what we get.
        // BUT TSortableProducts wraps the grid in Obx usually.
        
        // Let's keep Obx but handle the source.
        Obx(() {
          // If explicit products provided, use them. 
          // Note: If 'products' is a simple List, Obx won't detect changes to the valid reference unless the parent rebuilds. 
          // SearchScreen Obx rebuilds TSortableProducts entirely when list changes, so it works.
          
          final displayProducts = products ?? (useBrandController 
              ? brandProductsController!.products 
              : allProductsController!.products);
              
          if (displayProducts.isEmpty) {
             // Handle empty state purely visually if needed or just grid count 0
          }
              
          return TGridLayout(
            itemCount: displayProducts.length,
            itemBuilder: (_, index) => TProductCardVertical(
              product: displayProducts[index],
            ),
          );
        }),
      ],
    );
  }
}
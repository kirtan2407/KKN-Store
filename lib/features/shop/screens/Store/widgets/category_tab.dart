import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/products.cart/sorttable/sortable_products.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';
import 'package:kkn_store/features/shop/controllers/category_controller.dart';
import 'package:kkn_store/features/shop/controllers/product_controller.dart';
import 'package:kkn_store/features/shop/models/category_model.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    CategoryController.instance;
    THelperFunctions.isDarkMode(context);
    
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
              /// ---haedings---
              TSectionHeading(
                title: 'You might like',
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              /// --- Products List ---
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
                  
                  // Initialize a unique controller for this category using the category ID as a tag
                  // This ensures each tab has its own independent sorting state
                  final controller = Get.put(AllProductsController(), tag: category.id);
                  
                  // Assign products to this specific controller
                  if (controller.products.isEmpty || controller.products != products) {
                      controller.assignProducts(products);
                  }

                  // Pass the tagged controller to the sortable widget
                  return TSortableProducts(controller: controller);
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

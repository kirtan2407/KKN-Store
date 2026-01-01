import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_horizontal.dart';
import 'package:kkn_store/common/widgets/products.cart/sorttable/sortable_products.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';
import 'package:kkn_store/features/shop/controllers/category_controller.dart';
import 'package:kkn_store/features/shop/controllers/product_controller.dart';
import 'package:kkn_store/features/shop/models/category_model.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;
    
    return Scaffold(
      appBar: KknAppbar(
        title: Text(category.name),
        showArrowBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
               // Banner (Use category image or placeholder)
               TRoundedImage(
                 width: double.infinity,
                 height: 170, // Consistent with design
                 imageUrl: category.image.isNotEmpty ? category.image : TImages.poster2, // Fallback
                 applyImageRadius: true,
                 isNetworkImage: category.image.isNotEmpty,
               ),
               const SizedBox(height: TSizes.spaceBtwsections),
            
              FutureBuilder<List<CategoryModel>>(
                  future: categoryController.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    final subCategories = snapshot.data ?? [];
          
                    if (subCategories.isEmpty) {
                      // NO Sub-Categories: Show standard Sortable Grid (Previous Logic)
                       return FutureBuilder(
                        future: Get.put(ProductController()).fetchProductsByCategory(category.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          final products = (snapshot.data as List<ProductModel>?) ?? [];
                          if (products.isEmpty) {
                            return Center(child: Text('No products found.', style: Theme.of(context).textTheme.bodyMedium));
                          }
          
                          // Initialize a unique controller for this category screen
                          final controller = Get.put(AllProductsController(), tag: category.id);
          
                          if (controller.products.isEmpty || controller.products != products) {
                            controller.assignProducts(products);
                          }
          
                          return TSortableProducts(controller: controller);
                        },
                      );
                    } else {
                      // HAS Sub-Categories: Show Sections
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        itemBuilder: (context, index) {
                           final subCategory = subCategories[index];
                           return _buildSubCategorySection(subCategory);
                        },
                      );
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubCategorySection(CategoryModel subCategory) {
    return FutureBuilder(
      future: ProductController.instance.fetchProductsByCategory(subCategory.id, limit: 4),
      builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox(); 
          final products = (snapshot.data as List<ProductModel>?) ?? [];
          
          if (products.isEmpty) return const SizedBox();

          return Column(
              children: [
                TSectionHeading(
                  title: subCategory.name, 
                  onPressed: () => Get.to(() => CategoryProductsScreen(category: subCategory)), // View All goes to Grid view of subcat
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
                    itemBuilder: (context, index) => TProductCardHorizontal(product: products[index]),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwsections),
              ],
          );
      }
    );
  }
}

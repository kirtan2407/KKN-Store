import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/controllers/brand_controller.dart';
import 'package:kkn_store/features/shop/controllers/category_controller.dart';
import 'package:kkn_store/features/shop/screens/Brands/brand_products.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/TCard.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(BrandController());
    final categoryController = Get.put(CategoryController());

    if (controller.allBrands.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getAllBrands();
      });
    }

    return Scaffold(
      appBar: const KknAppbar(title: Text('Brands'), showArrowBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Search & Filter Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged:
                          (value) => controller.searchQuery.value = value,
                      decoration: const InputDecoration(
                        labelText: 'Search Brand',
                        prefixIcon: Icon(Iconsax.search_normal),
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),

                  /// Filter Button
                  Obx(() {
                    final isFilterActive =
                        controller.selectedCategoryIds.isNotEmpty;
                    return Container(
                      decoration: BoxDecoration(
                        color:
                            isFilterActive
                                ? TColors.primaryColor
                                : (dark ? TColors.dark : TColors.light),
                        borderRadius: BorderRadius.circular(
                          TSizes.cardRadiusLg,
                        ),
                        border: Border.all(color: TColors.grey),
                      ),
                      child: IconButton(
                        onPressed:
                            () => _showFilterBottomSheet(
                              context,
                              isFilterActive,
                              dark,
                            ),
                        icon: Icon(
                          Iconsax.setting_4,
                          color:
                              isFilterActive
                                  ? TColors.white
                                  : (dark ? TColors.white : TColors.black),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Brands Grid
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.filteredBrands.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Brands Found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return TGridLayout(
                  itemCount: controller.filteredBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) {
                    final brand = controller.filteredBrands[index];
                    return TBrandCard(
                      dark: dark,
                      showBorder: true,
                      brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(
    BuildContext context,
    bool isFilterActive,
    bool dark,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final controller = BrandController.instance;
        final categoryController = CategoryController.instance;

        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TSectionHeading(
                    title: 'Filter by Category',
                    showActionButton: false,
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Flexible(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      categoryController.allCategories.map((category) {
                        return Obx(() {
                          final isSelected = controller.selectedCategoryIds
                              .contains(category.id);
                          return FilterChip(
                            label: Text(category.name),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                controller.selectedCategoryIds.add(category.id);
                              } else {
                                controller.selectedCategoryIds.remove(
                                  category.id,
                                );
                              }
                            },
                            selectedColor: TColors.primaryColor,
                            checkmarkColor: Colors.white,
                            labelStyle: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : (dark ? Colors.white : Colors.black),
                            ),
                          );
                        });
                      }).toList(),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Apply Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.fetchBrandIdsForSelectedCategories();
                    Get.back();
                  },
                  child: const Text('Apply'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/appbar/TabBar.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/cart_menu_icon.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/screens/Brands/all_brands.dart';
import 'package:kkn_store/features/shop/screens/Brands/brand_products.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/category_tab.dart';
import 'package:kkn_store/features/shop/controllers/category_controller.dart';
import 'package:kkn_store/features/shop/controllers/brand_controller.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/TCard.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/searchbar.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final categoryController = Get.put(CategoryController());
    final brandController = Get.put(BrandController());

    return Obx(() {
      if (categoryController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final categories = categoryController.featuredCategories;

      return DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: KknAppbar(
            backgroundColor: dark ? TColors.dark : TColors.light,
            title: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Store',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            actions: [
              TCartCounterIcon(
                onPressed: () {},
                iconColor: dark ? TColors.light : TColors.dark,
              ),
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: dark ? TColors.dark : TColors.light,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpacing),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: TSizes.spaceBtwItems),

                        const TSearchBarContainer(
                          text: 'Search in Store',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: TSizes.spaceBtwsections),

                        /// Feature Brands
                        TSectionHeading(
                          title: 'Feature Brands',
                          onPressed: () => Get.to(() => const AllBrands()),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),

                        Obx(() {
                          if (brandController.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                              child: Text(
                                'No Brands Found!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          }

                          // Show only 4 brands on StoreScreen
                          final displayCount = brandController.featuredBrands.length > 4
                              ? 4
                              : brandController.featuredBrands.length;

                          return TGridLayout(
                            itemCount: displayCount,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.featuredBrands[index];
                              return TBrandCard(
                                showBorder: false,
                                dark: dark,
                                brand: brand,
                                onTap: () => Get.to(() => BrandProducts(brand: brand)),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  bottom: TTabBar(
                    tabs: categories
                        .map((category) => Tab(child: Text(category.name)))
                        .toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children:
                  categories.map((category) => TCategoryTab(category: category)).toList(),
            ),
          ),
        ),
      );
    });
  }
}

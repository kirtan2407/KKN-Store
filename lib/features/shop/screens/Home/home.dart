// ignore_for_file: unused_import

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/image.text/image_text.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/cart_menu_icon.dart';
import 'package:kkn_store/common/widgets/custom_shaps/container/circular_container.dart';
import 'package:kkn_store/common/widgets/custom_shaps/container/primary_header_container.dart';
import 'package:kkn_store/common/widgets/custom_shaps/curved_edgs/curved_edge_widgets.dart';
import 'package:kkn_store/common/widgets/custom_shaps/curved_edgs/curved_edgs.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/THomeCategory.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/home_appbar.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/home_slider.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_vertical.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/searchbar.dart';
import 'package:kkn_store/features/shop/controllers/product_controller.dart';
import 'package:kkn_store/features/shop/controllers/banner_controller.dart';
import 'package:kkn_store/features/shop/screens/all_products/all_products.dart';
import 'package:kkn_store/features/shop/screens/search/search.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/constants/texts.dart';
import 'package:kkn_store/utils/device/device_utility.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///header of background theme and curved
            TPrimaryHeaderConatainer(
              child: Column(
                children: [
                  /// --- appbar ---
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwsections),

                  /// --- Searchbar ---
                  TSearchBarContainer(
                    text: 'Start searching here...',
                    onTap: () => Get.to(() => const SearchScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwsections),
                ],
              ),
            ),

            /// --- Body ---
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpacing),
              child: Column(
                children: [
                  /// --- Promo Slider (Banner) ---
                  Obx(() {
                    final bannerController = Get.put(BannerController());
                    if (bannerController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (bannerController.banners.isEmpty) {
                      return const Center(child: Text('No Banners Found!'));
                    }

                    return TPromoslider(banners: bannerController.banners);
                  }),
                  const SizedBox(height: TSizes.spaceBtwsections),

                  /// --- Categories ---
                  const TSectionHeading(
                    title: 'Categories',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const THomeCategories(),
                  const SizedBox(height: TSizes.spaceBtwsections),

                  /// --- Popular Products Heading ---
                  TSectionHeading(
                    title: 'Popular',
                    onPressed: () => Get.to(() => const AllProducts()),
                    showActionButton: true,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// --- popular products
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Products Found!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }

                    return TGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder:
                          (_, index) => TProductCardVertical(
                            product: controller.featuredProducts[index],
                          ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

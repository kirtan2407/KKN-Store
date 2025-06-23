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
import 'package:kkn_store/features/shop/screens/all_products/all_products.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///header of background theme and curved
            TPrimaryHeaderConatainer(
              child: SizedBox(
                child: Column(
                  children: [
                    /// --- appbar ---
                    const THomeAppBar(),
                    const SizedBox(height: TSizes.spaceBtwsections),

                    /// --- Searchbar ---
                    const TSearchBarContainer(text: 'Search in store'),
                    const SizedBox(height: TSizes.spaceBtwsections),

                    Padding(
                      padding: EdgeInsets.only(left: TSizes.defaultSpacing),
                      child: Column(
                        children: [
                          /// --- Heading ---
                          const TSectionHeading(
                            title: 'Popular Catagories',
                            showActionButton: false,
                            textcolor: TColors.white,
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),

                          /// --- Categorys ---
                          const THomeCategories(),
                          SizedBox(height: TSizes.spaceBtwsections),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// --- Body ---
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpacing),
              child: Column(
                children: [
                  /// --- Promo Slider ---
                  TPromoslider(
                    banners: [
                      TImages.poster1,
                      TImages.poster2,
                      TImages.poster3,
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwsections),

                  /// --- Heading ---
                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// --- popular products
                  TGridLayout(
                    itemCount: 10,
                    itemBuilder: (_, index) => const TProductCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

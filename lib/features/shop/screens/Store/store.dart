// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/appbar/TabBar.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/brands/brand_show_case.dart';
import 'package:kkn_store/common/widgets/images/TCircularImages.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/cart/cart_menu_icon.dart';
import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/screens/Brands/all_brands.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/home_appbar.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/searchbar.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/TCard.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/category_tab.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/enums.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 7,
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
                  padding: EdgeInsets.all(TSizes.defaultSpacing),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Searchbar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchBarContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwsections),

                      /// --- Feature Brands ---
                      TSectionHeading(
                        title: 'Feature Brands',
                        onPressed: () => Get.to(() => const AllBrands()),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),

                      /// Brands Grid
                      TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          //In the backend we will pass the Each Brand & onPressed Event also...
                          return TBrandCard(showBorder: false, dark: dark);
                        },
                      ),
                    ],
                  ),
                ),

                /// --- Tabs --- ///
                bottom: TTabBar(
                  tabs: const [
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('Electronics')),
                    Tab(child: Text('Shoes')),
                    Tab(child: Text('Watches')),
                    Tab(child: Text('Furniture')),
                    Tab(child: Text('Books')),
                    Tab(child: Text('Beauty')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/products.cart/sorttable/sortable_products.dart';
import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';
import 'package:kkn_store/features/shop/screens/search/widgets/active_filters_list.dart';
import 'package:kkn_store/features/shop/screens/search/widgets/search_filter_bottom_sheet.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.put(AllProductsController());
  final searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Setup Scroll Listener for Infinite Loading
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        // Load when nearing bottom
        controller.loadMore();
      }
    });

    if (controller.searchQuery.isEmpty) {
      controller.fetchSearchResults(reset: true);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: KknAppbar(
        title: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            color: dark ? TColors.dark : TColors.light,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: TColors.grey),
          ),
          child: TextField(
            controller: searchController,
            onChanged:
                (value) => controller.updateSearchQuery(value), // Debounced
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search products, brands...',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: const Icon(Iconsax.search_normal),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                  controller.updateSearchQuery('');
                },
                icon: const Icon(Icons.clear),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        showArrowBack: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const SearchFilterBottomSheet(),
              );
            },
            icon: const Icon(Iconsax.setting_4),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController, // Attach scroll controller
        child: Column(
          children: [
            // Active Filters List (Horizontal Scroll)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 2),
              child: ActiveFiltersList(),
            ),

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Obx(() {
                    // Main Content
                    if (controller.isSearchLoading.value &&
                        controller.searchResults.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (controller.searchResults.isEmpty &&
                        !controller.isSearchLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text('No Products Found'),
                        ),
                      );
                    }

                    return TSortableProducts(
                      products: controller.searchResults,
                    );
                  }),

                  // Bottom Loader for Infinite Scroll
                  Obx(() {
                    if (controller.isSearchLoading.value &&
                        controller.searchResults.isNotEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(TSizes.defaultSpace),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  const SizedBox(height: TSizes.spaceBtwsections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

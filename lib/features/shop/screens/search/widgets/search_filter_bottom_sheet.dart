// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';
import 'package:kkn_store/features/shop/controllers/brand_controller.dart';
import 'package:kkn_store/features/shop/controllers/category_controller.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  const SearchFilterBottomSheet({super.key});

  @override
  State<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet>
    with SingleTickerProviderStateMixin {
  final allProductsController = Get.find<AllProductsController>();
  late final CategoryController categoryController;
  late final BrandController brandController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  late List<String> selectedCategoryIds;
  late List<String> selectedBrandIds;
  late String selectedSortOption;
  late double selectedMinSale;
  late double selectedMinRating;

  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeControllers();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void _initializeControllers() {
    try {
      categoryController = Get.put(CategoryController());
      brandController = Get.put(BrandController());

      selectedCategoryIds = List.from(allProductsController.searchCategoryIds);
      selectedBrandIds = List.from(allProductsController.searchBrandIds);
      selectedSortOption = allProductsController.selectedSortOption.value;
      selectedMinSale = allProductsController.minSalePercentage.value;
      selectedMinRating = allProductsController.minRating.value;

      if (categoryController.allCategories.isEmpty) {
        categoryController.fetchCategories();
      }
      if (brandController.allBrands.isEmpty) {
        brandController.getAllBrands();
      }

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize filters: ${e.toString()}';
      });
    }
  }

  void _applyFilters() {
    try {
      allProductsController.searchCategoryIds.assignAll(selectedCategoryIds);
      allProductsController.searchBrandIds.assignAll(selectedBrandIds);
      allProductsController.selectedSortOption.value = selectedSortOption;
      allProductsController.minSalePercentage.value = selectedMinSale;
      allProductsController.minRating.value = selectedMinRating;

      allProductsController.fetchSearchResults(reset: true);
      _animationController.reverse().then((_) => Get.back());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to apply filters: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  void _resetFilters() {
    setState(() {
      selectedCategoryIds.clear();
      selectedBrandIds.clear();
      selectedSortOption = 'Name';
      selectedMinSale = -1;
      selectedMinRating = -1;
    });
  }

  int get _activeFiltersCount {
    int count = 0;
    if (selectedCategoryIds.isNotEmpty) count++;
    if (selectedBrandIds.isNotEmpty) count++;
    if (selectedSortOption != 'Name') count++;
    if (selectedMinSale != -1) count++;
    if (selectedMinRating != -1) count++;
    return count;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: dark ? TColors.dark : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg * 1.5),
            topRight: Radius.circular(TSizes.cardRadiusLg * 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            /// -- Drag Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: dark ? TColors.grey : TColors.darkGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            /// -- Header
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: TColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Iconsax.filter,
                          color: TColors.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Filters',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (_activeFiltersCount > 0)
                            Text(
                              '$_activeFiltersCount active',
                              style: TextStyle(
                                fontSize: 12,
                                color: TColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      _animationController.reverse().then((_) => Get.back());
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: dark ? TColors.light : TColors.dark,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: dark
                          ? TColors.darkGrey
                          : TColors.grey.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            /// -- Content
            Expanded(
              child: _errorMessage != null
                  ? _buildErrorState()
                  : !_isInitialized
                      ? _buildLoadingState()
                      : _buildContent(dark),
            ),

            /// -- Action Buttons
            Container(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              decoration: BoxDecoration(
                color: dark ? TColors.darkerGrey : TColors.white,
                border: Border(
                  top: BorderSide(
                    color: dark
                        ? TColors.grey.withOpacity(0.1)
                        : TColors.grey.withOpacity(0.2),
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _activeFiltersCount > 0 ? _resetFilters : null,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(
                            color: _activeFiltersCount > 0
                                ? TColors.primaryColor
                                : TColors.grey,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _activeFiltersCount > 0
                                ? TColors.primaryColor
                                : TColors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _applyFilters,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: TColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: TColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.warning_2,
              size: 64,
              color: Colors.red.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Filters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(color: TColors.darkGrey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _errorMessage = null;
                  _isInitialized = false;
                });
                _initializeControllers();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(bool dark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSortSection(dark),
          const SizedBox(height: TSizes.spaceBtwsections),
          _buildCategorySection(dark),
          const SizedBox(height: TSizes.spaceBtwsections),
          _buildBrandSection(dark),
          const SizedBox(height: TSizes.spaceBtwsections),
          _buildDiscountSection(dark),
          const SizedBox(height: TSizes.spaceBtwsections),
          _buildRatingSection(dark),
          const SizedBox(height: TSizes.spaceBtwsections),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: TColors.primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSortSection(bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Sort by', Iconsax.sort),
        const SizedBox(height: TSizes.spaceBtwItems),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest']
              .map(
                (option) => _buildChoiceChip(
                  label: option,
                  selected: selectedSortOption == option,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => selectedSortOption = option);
                    }
                  },
                  dark: dark,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCategorySection(bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Category', Iconsax.category),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(() {
          if (categoryController.isLoading.value) {
            return const LinearProgressIndicator();
          }

          final categories = categoryController.allCategories
              .where((c) => c.parentId.isEmpty)
              .toList();

          if (categories.isEmpty) {
            return Text(
              'No categories available',
              style: TextStyle(color: TColors.darkGrey),
            );
          }

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories
                .map(
                  (category) => _buildFilterChip(
                    label: category.name,
                    selected: selectedCategoryIds.contains(category.id),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedCategoryIds.add(category.id);
                        } else {
                          selectedCategoryIds.remove(category.id);
                        }
                      });
                    },
                    dark: dark,
                  ),
                )
                .toList(),
          );
        }),
      ],
    );
  }

  Widget _buildBrandSection(bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Brand', Iconsax.shop),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(() {
          if (brandController.isLoading.value) {
            return const LinearProgressIndicator();
          }

          if (brandController.allBrands.isEmpty) {
            return Text(
              'No brands available',
              style: TextStyle(color: TColors.darkGrey),
            );
          }

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: brandController.allBrands
                .map(
                  (brand) => _buildFilterChip(
                    label: brand.name,
                    selected: selectedBrandIds.contains(brand.id),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedBrandIds.add(brand.id);
                        } else {
                          selectedBrandIds.remove(brand.id);
                        }
                      });
                    },
                    dark: dark,
                  ),
                )
                .toList(),
          );
        }),
      ],
    );
  }

  Widget _buildDiscountSection(bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Discount Range', Iconsax.discount_shape),
        const SizedBox(height: TSizes.spaceBtwItems),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            {'label': 'Any', 'value': -1.0},
            {'label': '10% and above', 'value': 10.0},
            {'label': '25% and above', 'value': 25.0},
            {'label': '50% and above', 'value': 50.0},
          ].map((option) {
            final isSelected = selectedMinSale == option['value'];
            return _buildChoiceChip(
              label: option['label'] as String,
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => selectedMinSale = option['value'] as double);
                }
              },
              dark: dark,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRatingSection(bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Customer Rating', Iconsax.star1),
        const SizedBox(height: TSizes.spaceBtwItems),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            {'label': 'Any', 'value': -1.0},
            {'label': '4+ Stars', 'value': 4.0},
            {'label': '3+ Stars', 'value': 3.0},
          ].map((option) {
            final isSelected = selectedMinRating == option['value'];
            return _buildChoiceChip(
              label: option['label'] as String,
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => selectedMinRating = option['value'] as double);
                }
              },
              dark: dark,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool selected,
    required Function(bool) onSelected,
    required bool dark,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: dark ? TColors.darkerGrey : TColors.grey.withOpacity(0.1),
      selectedColor: TColors.primaryColor,
      labelStyle: TextStyle(
        color: selected ? TColors.white : (dark ? TColors.light : TColors.dark),
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected
              ? TColors.primaryColor
              : (dark ? TColors.grey.withOpacity(0.2) : TColors.grey.withOpacity(0.3)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required Function(bool) onSelected,
    required bool dark,
  }) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: dark ? TColors.darkerGrey : TColors.grey.withOpacity(0.1),
      selectedColor: TColors.primaryColor,
      checkmarkColor: TColors.white,
      labelStyle: TextStyle(
        color: selected ? TColors.white : (dark ? TColors.light : TColors.dark),
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected
              ? TColors.primaryColor
              : (dark ? TColors.grey.withOpacity(0.2) : TColors.grey.withOpacity(0.3)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}
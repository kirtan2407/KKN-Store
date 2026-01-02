import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/Product_Attribute.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/Product_Meta_Data.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/bottom_add_to_cart.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/product_Image_Slider.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/rating_Share_Widget.dart';
import 'package:kkn_store/features/shop/screens/Product_reviews/product_review.dart';
import 'package:kkn_store/features/shop/controllers/product/review_controller.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:readmore/readmore.dart';
import 'package:kkn_store/features/shop/screens/Checkout/checkout.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Product Image Slider
            TProductImageSlider(product: product),

            // 2. Product details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // I. Rating & Share Button
                  const TRatingAndShare(),

                  /// II. Product Name, Price , Stack & Brand
                  TProductMetaData(product: product),

                  /// III. Attributes
                  if (product.productType == 'variable')
                    TProductAttribute(product: product),
                  if (product.productType == 'variable')
                    const SizedBox(height: TSizes.spaceBtwsections),

                  /// IV. Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                         final controller = CartController.instance;
                         controller.addToCart(product);
                         Get.to(() => const CheckOutScreen());
                      },
                      child: const Text('CheckOut'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwsections),

                  /// V. Description
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwsections),

                  /// VI. Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        final controller = Get.put(ReviewController());
                        if (controller.productPageReviewCount.value == 0) {
                           // Trigger fetch if 0 (or could rely on init, but this ensures it loads)
                           // NOTE: Better to do this in init or build top level, but for localized update:
                           controller.fetchProductReviewCount(product.id);
                        }
                        return TSectionHeading(
                          title: 'Reviews(${controller.productPageReviewCount.value})',
                          showActionButton: false,
                        );
                      }),
                      IconButton(
                        onPressed:
                            () => Get.to(
                              () => ProductReviewScreen(productId: product.id),
                            ),
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

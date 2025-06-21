// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/custom_shaps/curved_edgs/curved_edge_widgets.dart';
import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/Product_Attribute.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/Product_Meta_Data.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/bottom_add_to_cart.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/product_Image_Slider.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/product_description.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/rating_Share_Widget.dart';
import 'package:kkn_store/features/shop/screens/Product_reviews/product_review.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Product Image Slider
            TProductImageSlider(),

            // 2. Product details
            Padding(
              padding: EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // I. Rating & Share Button
                  TRatingAndShare(),

                  /// II. Product Name, Price , Stack & Brand
                  TProductMetaData(),

                  /// III. Attributes
                  TProductAttribute(),
                  SizedBox(height: TSizes.spaceBtwsections),

                  /// IV. Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('CheckOut'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwsections),

                  /// V. Description verity- (1)

                  // TSectionHeading(
                  //   title: 'Description',
                  //   showActionButton: true,
                  //   buttonTitle: 'View Product Details',
                  //   onPressed: () => showProductDetailsModal(context),),
                  // const SizedBox(height: TSizes.spaceBtwItems),

                  /// V. Description verity - (2)
                  TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                    "Step In and Go The entire heel (including the sole) hinges open and stays open until you're ready. Just slip in and step down to make the heel move back into place and secure your foot.",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
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
                      const TSectionHeading(
                        title: 'Reviews(199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed:
                            () => Get.to(() => const ProductReviewScreen()),
                        icon: Icon(Iconsax.arrow_right_3, size: 18),
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

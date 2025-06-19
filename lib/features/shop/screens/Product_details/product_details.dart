// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/custom_shaps/curved_edgs/curved_edge_widgets.dart';
import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/Product_Meta_Data.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/product_Image_Slider.dart';
import 'package:kkn_store/features/shop/screens/Product_details/Widgets/rating_Share_Widget.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:video_player/video_player.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
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

                  // II. Product Name, Price , Stack & Brand
                  TProductMetaData(),

                  // III. Attributes

                  // IV. Checkout Button

                  // V. Description

                  // VI. Reviews
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

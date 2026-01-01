
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/product/review_controller.dart';
import 'package:kkn_store/features/shop/screens/Product_reviews/widgets/one_Indicator_bar.dart';

class TAllOverRatingIndicator extends StatelessWidget {
  const TAllOverRatingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewController());
    return Obx(
      () => Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              controller.averageRating.value.toStringAsFixed(1),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              children: [
                TRatingProgressIndicator(
                  rating: '5',
                  value: controller.starCounts[5] ?? 0.0,
                ),
                TRatingProgressIndicator(
                  rating: '4',
                  value: controller.starCounts[4] ?? 0.0,
                ),
                TRatingProgressIndicator(
                  rating: '3',
                  value: controller.starCounts[3] ?? 0.0,
                ),
                TRatingProgressIndicator(
                  rating: '2',
                  value: controller.starCounts[2] ?? 0.0,
                ),
                TRatingProgressIndicator(
                  rating: '1',
                  value: controller.starCounts[1] ?? 0.0,
                ),

                ///end of rating
              ],
            ),
          ),
        ],
      ),
    );
  }
}

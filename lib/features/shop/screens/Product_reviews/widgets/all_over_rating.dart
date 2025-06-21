
import 'package:flutter/material.dart';
import 'package:kkn_store/features/shop/screens/Product_reviews/widgets/one_Indicator_bar.dart';

class TAllOverRatingIndicator extends StatelessWidget {
  const TAllOverRatingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              TRatingProgressIndicator(rating: '5', value: 1.0),
              TRatingProgressIndicator(rating: '4', value: 0.8),
              TRatingProgressIndicator(rating: '3', value: 0.3),
              TRatingProgressIndicator(rating: '2', value: 0.2),
              TRatingProgressIndicator(rating: '1', value: 0.07),
    
              ///end of rating
            ],
          ),
        ),
      ],
    );
  }
}

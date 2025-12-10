import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpacing),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: THelperFunctions.screenWidth() * 0.8,
              height: THelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
  
            /// Title with padding
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
  
            const SizedBox(height: TSizes.sm),
  
            /// Subtitle with padding
            Text(
              subTitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

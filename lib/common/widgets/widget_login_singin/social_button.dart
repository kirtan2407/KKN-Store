
import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Image(
                width: TSizes.iconLg,
                height: TSizes.iconLg,
                image: AssetImage(TImages.google),
              ),
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwItems),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Image(
                width: TSizes.iconLg,
                height: TSizes.iconLg,
                image: AssetImage(TImages.facebook),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:kkn_store/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpacing,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skippage(),
        child: const Text('Skip'),
      ),
    );
  }
}

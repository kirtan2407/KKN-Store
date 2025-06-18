import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/features/authentication/screens/onboarding/widgets/onboarding_navigation.dart';
import 'package:kkn_store/features/authentication/screens/onboarding/widgets/onboarding_nextpage_button.dart';
import 'package:kkn_store/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:kkn_store/features/authentication/screens/onboarding/widgets/onbording_pages.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/texts.dart';

import '../../controller/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// --- horizontal scrollable container ---
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              // Page 1
              OnBoardingPage(
                image: TImages.onbording1,
                title: TText.onBoardingTitle1,
                subTitle: TText.onBoardingSubTitle1,
              ),
              // Page 2
              OnBoardingPage(
                image: TImages.onbording2,
                title: TText.onBoardingTitle2,
                subTitle: TText.onBoardingSubTitle2,
              ),
              // Page 3
              OnBoardingPage(
                image: TImages.onbording3,
                title: TText.onBoardingTitle3,
                subTitle: TText.onBoardingSubTitle3,
              ),
            ],
          ),

          /// --- Skip Button ---
          OnBoardingSkip(),

          /// --- dot Navigation indicators ---
          OnBoardingNavigation(),

          /// --- circular Button ---
          OnBoardingnextbutton(),
        ],
      ),
    );
  }
}


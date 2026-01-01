import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/features/personalization/screens/tasks/tasks.dart';
import 'package:kkn_store/features/personalization/screens/settings/settings.dart';
import 'package:kkn_store/features/shop/screens/Home/home.dart';
import 'package:kkn_store/features/shop/screens/Store/store.dart';
import 'package:kkn_store/features/shop/screens/wishlist/wishlist.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class NavigationMenu extends GetView<NavigationController> {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController(), permanent: true);

    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor:
              darkMode
                  ? TColors.white.withOpacity(0.1)
                  : TColors.black.withOpacity(0.1),
          onDestinationSelected: controller.changeTab,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            // NavigationDestination(
            //   icon: Icon(Iconsax.shield_security),
            //   label: 'Tasks',
            // ),
          ],
        ),
      ),
      body: Obx(() {
        final index = controller.selectedIndex.value;
        return controller.screens.elementAt(index);
      }),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> screens = const [
    HomeScreen(),
    StoreScreen(),
    FavouriteScreen(),
    SettingScreen(),
    Tasks(),
  ];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

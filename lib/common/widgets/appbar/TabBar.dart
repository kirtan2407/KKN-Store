import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/device/device_utility.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// If you want to add background color to tabs you have to warp them in Matirial Widgits
  /// To do that we need [PreferredSized] Widget and that's why created custom class. [PrefferedSizeWidget]

  const TTabBar({super.key, required this.tabs});
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: TColors.primaryColor,
        labelColor: dark ? TColors.white : TColors.primaryColor,
        unselectedLabelColor: TColors.darkGrey,
        tabAlignment: TabAlignment.start,
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/device/device_utility.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class KknAppbar extends StatelessWidget implements PreferredSizeWidget {
  const KknAppbar({
    super.key,
    this.title,
    this.showArrowBack = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.backgroundColor,
  });

  final Widget? title;
  final bool showArrowBack;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(top: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading:
            showArrowBack
                ? IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: dark ? TColors.primaryColor : TColors.primaryColor,
                  ),
                )
                : leadingIcon != null
                ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon),
                )
                : null,
        title: title,
        actions: actions,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  // TODO:Implement perferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}

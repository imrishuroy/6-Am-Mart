import 'package:flutter/material.dart';
import '/helpers/dimensions.dart';
import '/utils/utils.dart';

import 'cart_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final Function? onBackPressed;
  final bool showCart;
  final String? leadingIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backButton = true,
    this.onBackPressed,
    this.showCart = false,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      title: Text(
        title,
        style: robotoRegular.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: Theme.of(context).textTheme.bodyText1?.color),
      ),
      centerTitle: true,
      leading: backButton
          ? IconButton(
              icon: leadingIcon != null
                  ? Image.asset(leadingIcon!, height: 22, width: 22)
                  : const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).textTheme.bodyText1?.color,
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pop(context),
            )
          : const SizedBox.shrink(),
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      actions: showCart
          ? [
              IconButton(
                onPressed: () {},
                icon: const CartWidget(
                  color: Colors.red,
                  // color: Theme.of(context).textTheme.bodyText1.color,
                  size: 25.0,
                ),
              )
            ]
          : [
              const SizedBox.shrink(),
            ],
    );
  }

  @override
  Size get preferredSize => const Size(250, 50);

  // @override
  // Size get preferredSize => Size(Get.width, GetPlatform.isDesktop ? 70 : 50);
}

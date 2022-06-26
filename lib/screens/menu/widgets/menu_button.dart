import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/blocs/auth/auth_bloc.dart';
import '/helpers/dimensions.dart';
import '/utils/utils.dart';
import '/widgets/custom_image.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '/models/menu_model.dart';

class MenuButton extends StatelessWidget {
  final MenuModel menu;
  final bool isProfile;
  final bool isLogout;

  const MenuButton({
    Key? key,
    required this.menu,
    required this.isProfile,
    required this.isLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canvasSize = MediaQuery.of(context).size;
    final authBloc = context.read<AuthBloc>();

    int count = 4;
    double size = ((canvasSize.width > Dimensions.webMaxWidth
                ? Dimensions.webMaxWidth
                : canvasSize.width) /
            count) -
        Dimensions.paddingSizeDefault;

    return InkWell(
      onTap: () async {
        if (isLogout) {
          //  Get.back();
          // if (Get.find<AuthController>().isLoggedIn()) {
          //   Get.dialog(
          //     ConfirmationDialog(
          //         icon: Images.support,
          //         description: 'are_you_sure_to_logout'.tr,
          //         isLogOut: true,
          //         onYesPressed: () {
          //           Get.find<AuthController>().clearSharedData();
          //           Get.find<CartController>().clearCartList();
          //           Get.find<WishListController>().removeWishes();
          //           Get.offAllNamed(
          //               RouteHelper.getSignInRoute(RouteHelper.splash));
          //         }),
          //     useSafeArea: false,
          //   );
          // } else {
          //   Get.find<WishListController>().removeWishes();
          //   Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
          // }
        } else if (menu.route.startsWith('http')) {
          if (await canLaunchUrlString(menu.route)) {
            launchUrlString(menu.route);
          }
        } else {
          Navigator.of(context).pushNamed(menu.route);
          //Get.offNamed(menu.route);
        }
      },
      child: Column(children: [
        Container(
          height: size - (size * 0.2),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            // color: isLogout
            //     ? Get.find<AuthController>().isLoggedIn()
            //         ? Colors.red
            //         : Colors.green
            //     : Theme.of(context).primaryColor,
            color: isLogout
                ? authBloc.state.isLoggedIn()
                    ? Colors.red
                    : Colors.green
                : Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                //  color: Colors.grey[Get.isDarkMode ? 800 : 200],
                spreadRadius: 1,
                blurRadius: 5,
              )
            ],
          ),
          alignment: Alignment.center,
          child: isProfile
              ? ProfileImageWidget(size: size)
              : Image.asset(menu.icon,
                  width: size, height: size, color: Colors.white),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(menu.title,
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
            textAlign: TextAlign.center),
      ]),
    );
  }
}

class ProfileImageWidget extends StatelessWidget {
  final double size;
  const ProfileImageWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: Colors.white)),
      child: ClipOval(
        child: CustomImage(
          image: '',
          // '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
          // '/${(userController.userInfoModel != null && Get.find<AuthController>().isLoggedIn()) ? userController.userInfoModel.image ?? '' : ''}',
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

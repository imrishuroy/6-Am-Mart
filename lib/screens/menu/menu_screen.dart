import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:six_am_mart/blocs/auth/auth_bloc.dart';
import 'package:six_am_mart/screens/profile/profile_screen.dart';
import '/helpers/dimensions.dart';
import '/models/menu_model.dart';
import '/utils/utils.dart';

import 'widgets/menu_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<MenuModel> _menuList = [];

  @override
  void initState() {
    final authBloc = context.read<AuthBloc>();
    _menuList = [
      const MenuModel(
          icon: '', title: 'Profile', route: ProfileScreen.routeName),
      const MenuModel(icon: Images.location, title: 'My Address', route: ''),
      const MenuModel(icon: Images.language, title: 'Language', route: ''),
      const MenuModel(icon: Images.coupon, title: 'Coupon', route: ''),
      const MenuModel(icon: Images.support, title: 'Help Support', route: ''),
      const MenuModel(icon: Images.policy, title: 'Privacy Policy', route: ''),
      const MenuModel(icon: Images.aboutUs, title: 'About Us', route: ''),
      const MenuModel(icon: Images.terms, title: 'Terms Conditions', route: ''),
      const MenuModel(
        icon: Images.deliveryManJoin,
        title: 'Join as a delivery man',
        route: '',
      ),
      const MenuModel(
        icon: Images.restaurantJoin,
        title: 'Join as a store',
        route: '',
      ),
      MenuModel(
          icon: Images.logOut,
          title: authBloc.state.isLoggedIn() ? 'Logout' : 'Sign In',
          route: '')
    ];
    super.initState();
  }

  // final List<MenuModel> _menuList = const []

  final double _ratio = 1.2;
  final bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    // _ratio = ResponsiveHelper.isDesktop(context)
    //     ? 1.1
    //     : ResponsiveHelper.isTab(context)
    //         ? 1.1
    //         : 1.2;
    // _ratio = 1.2;
    // bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    //
    // _menuList = const [
    //   MenuModel(icon: '', title: 'profile', route: ''),
    //   MenuModel(icon: Images.location, title: 'my_address', route: ''),
    //   MenuModel(icon: Images.language, title: 'language', route: ''),
    //   MenuModel(icon: Images.coupon, title: 'coupon', route: ''),
    //   MenuModel(icon: Images.support, title: 'help_support', route: ''),
    //   MenuModel(icon: Images.policy, title: 'privacy_policy', route: ''),
    //   MenuModel(icon: Images.aboutUs, title: 'about_us', route: ''),
    //   MenuModel(icon: Images.terms, title: 'terms_conditions', route: ''),
    // ];
    // if(Get.find<SplashController>().configModel.toggleDmRegistration && !ResponsiveHelper.isDesktop(context)) {
    //   _menuList.add(MenuModel(
    //     icon: Images.delivery_man_join, title: 'join_as_a_delivery_man'.tr,
    //     route: '${AppConstants.BASE_URL}/deliveryman/apply',
    //   ));
    //  }
    // if(Get.find<SplashController>().configModel.toggleStoreRegistration && !ResponsiveHelper.isDesktop(context)) {
    //   _menuList.add(MenuModel(
    //     icon: Images.restaurant_join, title: Get.find<SplashController>().configModel.moduleConfig.module.showRestaurantText
    //       ? 'join_as_a_restaurant'.tr : 'join_as_a_store'.tr,
    //     route: '${AppConstants.BASE_URL}/store/apply',
    //   ));
    //  }
    // _menuList.add(
    //   const MenuModel(
    //     icon: Images.logOut,
    //     // title: isLoggedIn ? 'logout' : 'sign_in',
    //     title: 'Sing IN',
    //     route: '',
    //   ),
    // );

    return PointerInterceptor(
      child: Container(
        width: Dimensions.webMaxWidth,
        // height: 500.0,
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4,
                crossAxisCount: 4,
                childAspectRatio: (1 / _ratio),
                crossAxisSpacing: Dimensions.paddingSizeExtraSmall,
                mainAxisSpacing: Dimensions.paddingSizeExtraSmall,
              ),
              itemCount: _menuList.length,
              itemBuilder: (context, index) {
                return MenuButton(
                  menu: _menuList[index],
                  isProfile: index == 0,
                  isLogout: index == _menuList.length - 1,
                );
              },
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
          ],
        ),
      ),
    );
  }
}

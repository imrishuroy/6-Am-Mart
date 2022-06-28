import 'package:flutter/material.dart';
import '/blocs/auth/auth_bloc.dart';
import '/helpers/dimensions.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  MenuDrawerState createState() => MenuDrawerState();
}

class MenuDrawerState extends State<MenuDrawer>
    with SingleTickerProviderStateMixin {
  final List<Menu> _menuList = [
    Menu(
        icon: Images.profile,
        title: LocaleKeys.favourite.tr(),
        onTap: () {
          // Get.offNamed(RouteHelper.getProfileRoute());
        }),
    Menu(
        icon: Images.orders,
        title: LocaleKeys.my_orders.tr(),
        onTap: () {
          //Get.offNamed(RouteHelper.getOrderRoute());
        }),
    Menu(
        icon: Images.location,
        title: LocaleKeys.my_address.tr(),
        onTap: () {
          //Get.offNamed(RouteHelper.getAddressRoute());
        }),
    Menu(
        icon: Images.language,
        title: LocaleKeys.language.tr(),
        onTap: () {
          // Get.offNamed(RouteHelper.getLanguageRoute('menu'));
        }),
    Menu(
        icon: Images.coupon,
        title: LocaleKeys.coupon.tr(),
        onTap: () {
          // Get.offNamed(RouteHelper.getCouponRoute());
        }),
    Menu(
        icon: Images.support,
        title: LocaleKeys.help_support.tr(),
        onTap: () {
          //  Get.offNamed(RouteHelper.getSupportRoute());
        }),
    Menu(
        icon: Images.logOut,
        title: 'Sign In',
        //  Get.find<AuthController>().isLoggedIn()
        //     ? 'logout'.tr
        //     : 'sign_in'.tr,
        onTap: () {
          //Get.back();
          //Navigator.of(context).pop();
          // if (Get.find<AuthController>().isLoggedIn()) {
          //   Get.dialog(
          //       ConfirmationDialog(
          //         icon: Images.support,
          //         description: 'are_you_sure_to_logout'.tr,
          //         isLogOut: true,
          //         onYesPressed: () {
          //           Get.find<AuthController>().clearSharedData();
          //           Get.find<CartController>().clearCartList();
          //           Get.find<WishListController>().removeWishes();
          //           Get.offAllNamed(
          //               RouteHelper.getSignInRoute(RouteHelper.splash));
          //         },
          //),
          /// useSafeArea: false);
          // } else {
          //   // Get.find<WishListController>().removeWishes();
          //   // Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
          // }
        }),
  ];

  static const _initialDelayTime = Duration(milliseconds: 200);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration =
      _initialDelayTime + (_staggerTime * 7) + _buttonDelayTime + _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuList.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
    // return ResponsiveHelper.isDesktop(context) ? _buildContent() : SizedBox();
  }

  Widget _buildContent() {
    return Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(30)),
              color: Theme.of(context).cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeLarge, horizontal: 25),
                margin: const EdgeInsets.only(right: 30),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight:
                          Radius.circular(Dimensions.radiusExtraLarge)),
                  color: Theme.of(context).primaryColor,
                ),
                alignment: Alignment.centerLeft,
                child: Text(LocaleKeys.menu.tr(),
                    style:
                        robotoBold.copyWith(fontSize: 20, color: Colors.white)),
              ),
              ListView.builder(
                itemCount: _menuList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _staggeredController,
                    builder: (context, child) {
                      final animationPercent = Curves.easeOut.transform(
                        _itemSlideIntervals[index]
                            .transform(_staggeredController.value),
                      );
                      final opacity = animationPercent;
                      final slideDistance = (1.0 - animationPercent) * 150;

                      return Opacity(
                        opacity: opacity,
                        child: Transform.translate(
                          offset: Offset(slideDistance, 0),
                          child: child,
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () => _menuList[index].onTap(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: Row(children: [
                          Container(
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusExtraLarge),
                              color: index != _menuList.length - 1
                                  ? Theme.of(context).primaryColor
                                  : context.read<AuthBloc>().state.isLoggedIn()
                                      ? Theme.of(context).errorColor
                                      : Colors.green,
                            ),
                            child: Image.asset(_menuList[index].icon,
                                color: Colors.white, height: 30, width: 30),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Text(_menuList[index].title, style: robotoMedium),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class Menu {
  String icon;
  String title;
  Function onTap;

  Menu({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

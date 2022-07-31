import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/data/model/response/menu_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/view/screens/menu/profile_tile.dart';

import '/controller/auth_controller.dart';
import '/controller/user_controller.dart';

class NewMenuScreen extends StatefulWidget {
  const NewMenuScreen({Key key}) : super(key: key);

  @override
  State<NewMenuScreen> createState() => _NewMenuScreenState();
}

class _NewMenuScreenState extends State<NewMenuScreen> {
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();

    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
  }

  List menuOptions = [
    // MenuModel(
    //     icon: '', title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
    MenuModel(
        icon: Images.location,
        title: 'my_address'.tr,
        route: RouteHelper.getAddressRoute()),
    MenuModel(
        icon: Images.language,
        title: 'language'.tr,
        route: RouteHelper.getLanguageRoute('menu')),
    MenuModel(
        icon: Images.coupon,
        title: 'coupon'.tr,
        route: RouteHelper.getCouponRoute()),
    MenuModel(
        icon: Images.support,
        title: 'help_support'.tr,
        route: RouteHelper.getSupportRoute()),
    MenuModel(
        icon: Images.policy,
        title: 'privacy_policy'.tr,
        route: RouteHelper.getHtmlRoute('privacy-policy')),
    MenuModel(
        icon: Images.about_us,
        title: 'about_us'.tr,
        route: RouteHelper.getHtmlRoute('about-us')),
    MenuModel(
        icon: Images.terms,
        title: 'terms_conditions'.tr,
        route: RouteHelper.getHtmlRoute('terms-and-condition')),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GetBuilder<UserController>(
        builder: (userController) {
          return (_isLoggedIn && userController.userInfoModel == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                        //  const SizedBox(height: 30.0),
                        SizedBox(
                          width: size.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.person_outline_sharp,
                                      color: Colors.black,
                                      size: 40.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30.0),
                              Expanded(
                                child: Text(
                                  userController.userInfoModel != null
                                      ? '${userController.userInfoModel.fName} ${userController.userInfoModel.lName}'
                                      : 'guest'.tr,
                                  // '${state.user?.firstName ?? ' '}\n${state.user?.lastName ?? ''}',
                                  //'Rishu Kumar',
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        MenuTile(
                          label: 'Profile Settings',
                          icon: Icons.person,
                          onTap: () =>
                              Get.toNamed(RouteHelper.getUpdateProfileRoute()),
                        ),
                        Divider(),
                        // Row(
                        //   children: [
                        //     MenuTile(
                        //       label: 'Order history',
                        //       icon: Icons.description,
                        //       onTap: () {},
                        //     ),
                        //     const Spacer(),
                        //     const CircleAvatar(
                        //       radius: 13.0,
                        //       backgroundColor: Colors.amber,
                        //       child: Text(
                        //         '0',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12.0,
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // const Divider(),
                        // MenuTile(
                        //   label: 'Liked products',
                        //   icon: Icons.favorite,
                        //   onTap: () {},
                        // ),
                        // const Divider(),

                        for (MenuModel menu in menuOptions)
                          Column(
                            children: [
                              MenuTile(
                                label: menu.title,
                                iconImg: menu.icon,
                                // icon: Icons.settings,
                                onTap: () => Get.toNamed(menu.route),
                              ),
                              const Divider(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ));
        },
      ),
    );
  }
}

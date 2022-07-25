import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '/controller/auth_controller.dart';
import '/controller/user_controller.dart';
import 'widget/profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();

    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final authBloc = context.read<AuthBloc>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.chat_bubble_outline,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: GetBuilder<UserController>(
          builder: (userController) {
            return (_isLoggedIn && userController.userInfoModel == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 25.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                          const SizedBox(height: 30.0),
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
                          Row(
                            children: [
                              ProfileTile(
                                label: 'Order history',
                                icon: Icons.description,
                                onTap: () {},
                              ),
                              const Spacer(),
                              const CircleAvatar(
                                radius: 13.0,
                                backgroundColor: Colors.amber,
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          ProfileTile(
                            label: 'Liked products',
                            icon: Icons.favorite,
                            onTap: () {},
                          ),
                          const Divider(),
                          Row(
                            children: [
                              ProfileTile(
                                label: 'Profile Settings',
                                icon: Icons.person,
                                onTap: () {},
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: 'Completed - '),
                                        TextSpan(
                                          text: '60%',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      for (int i = 0; i < 4; i++)
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          height: 7.0,
                                          width: 15.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            color: Colors.black,
                                          ),
                                        ),
                                      for (int i = 0; i < 4; i++)
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          height: 7.0,
                                          width: 15.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const Divider(),
                          ProfileTile(
                            label: 'Settings',
                            icon: Icons.settings,
                            onTap: () {},
                          ),
                          const Divider(),
                          ProfileTile(
                            label: 'Exit',
                            icon: FontAwesomeIcons.arrowRightFromBracket,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ));
          },
        ),
      ),
    );
  }
}
        
        //  BlocConsumer<ProfileCubit, ProfileState>(
        //   listener: (context, state) {},
        //   builder: (context, state) {
        //     switch (state.status) {
        //       case ProfileStatus.loading:
        //         return const LoadingIndicator();

        //       case ProfileStatus.error:
        //         return const Center(
        //           child: Text('Something went wrong'),
        //         );

        //       case ProfileStatus.succuss:
        //         return 
                
                
                

              // default:
              //   return const LoadingIndicator();
            //}
          //},
    //     ),
    //   ),
    // );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sixam_mart/controller/auth_controller.dart';
// import 'package:sixam_mart/controller/splash_controller.dart';
// import 'package:sixam_mart/controller/theme_controller.dart';
// import 'package:sixam_mart/controller/user_controller.dart';
// import 'package:sixam_mart/helper/responsive_helper.dart';
// import 'package:sixam_mart/helper/route_helper.dart';
// import 'package:sixam_mart/util/app_constants.dart';
// import 'package:sixam_mart/util/dimensions.dart';
// import 'package:sixam_mart/util/styles.dart';
// import 'package:sixam_mart/view/base/custom_image.dart';
// import 'package:sixam_mart/view/base/footer_view.dart';
// import 'package:sixam_mart/view/base/menu_drawer.dart';
// import 'package:sixam_mart/view/base/web_menu_bar.dart';
// import 'package:sixam_mart/view/screens/profile/widget/profile_bg_widget.dart';
// import 'package:sixam_mart/view/screens/profile/widget/profile_button.dart';
// import 'package:sixam_mart/view/screens/profile/widget/profile_card.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

//   @override
//   void initState() {
//     super.initState();

//     if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
//       Get.find<UserController>().getUserInfo();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
//       endDrawer: MenuDrawer(),
//       backgroundColor: Theme.of(context).cardColor,
//       body: GetBuilder<UserController>(builder: (userController) {
//         return (_isLoggedIn && userController.userInfoModel == null)
//             ? Center(child: CircularProgressIndicator())
//             : ProfileBgWidget(
//                 backButton: true,
//                 circularImage: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                         width: 2, color: Theme.of(context).cardColor),
//                     shape: BoxShape.circle,
//                   ),
//                   alignment: Alignment.center,
//                   child: ClipOval(
//                       child: CustomImage(
//                     image:
//                         '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
//                         '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.image : ''}',
//                     height: 100,
//                     width: 100,
//                     fit: BoxFit.cover,
//                   )),
//                 ),
//                 mainWidget: SingleChildScrollView(
//                     physics: BouncingScrollPhysics(),
//                     child: FooterView(
//                       minHeight: _isLoggedIn ? 0.6 : 0.35,
//                       child: Center(
//                           child: Container(
//                         width: Dimensions.WEB_MAX_WIDTH,
//                         color: Theme.of(context).cardColor,
//                         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//                         child: Column(children: [
//                           Text(
//                             _isLoggedIn
//                                 ? '${userController.userInfoModel.fName} ${userController.userInfoModel.lName}'
//                                 : 'guest'.tr,
//                             style: robotoMedium.copyWith(
//                                 fontSize: Dimensions.fontSizeLarge),
//                           ),
//                           SizedBox(height: 30),
//                           _isLoggedIn
//                               ? Row(children: [
//                                   ProfileCard(
//                                       title: 'since_joining'.tr,
//                                       data:
//                                           '${userController.userInfoModel.memberSinceDays} ${'days'.tr}'),
//                                   SizedBox(
//                                       width: Dimensions.PADDING_SIZE_SMALL),
//                                   ProfileCard(
//                                       title: 'total_order'.tr,
//                                       data: userController
//                                           .userInfoModel.orderCount
//                                           .toString()),
//                                 ])
//                               : SizedBox(),
//                           SizedBox(height: _isLoggedIn ? 30 : 0),
//                           ProfileButton(
//                               icon: Icons.dark_mode,
//                               title: 'dark_mode'.tr,
//                               isButtonActive: Get.isDarkMode,
//                               onTap: () {
//                                 Get.find<ThemeController>().toggleTheme();
//                               }),
//                           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                           _isLoggedIn
//                               ? GetBuilder<AuthController>(
//                                   builder: (authController) {
//                                   return ProfileButton(
//                                     icon: Icons.notifications,
//                                     title: 'notification'.tr,
//                                     isButtonActive: authController.notification,
//                                     onTap: () {
//                                       authController.setNotificationActive(
//                                           !authController.notification);
//                                     },
//                                   );
//                                 })
//                               : SizedBox(),
//                           SizedBox(
//                               height: _isLoggedIn
//                                   ? Dimensions.PADDING_SIZE_SMALL
//                                   : 0),
//                           _isLoggedIn
//                               ? ProfileButton(
//                                   icon: Icons.lock,
//                                   title: 'change_password'.tr,
//                                   onTap: () {
//                                     Get.toNamed(
//                                         RouteHelper.getResetPasswordRoute(
//                                             '', '', 'password-change'));
//                                   })
//                               : SizedBox(),
//                           SizedBox(
//                               height: _isLoggedIn
//                                   ? Dimensions.PADDING_SIZE_SMALL
//                                   : 0),
//                           ProfileButton(
//                               icon: Icons.edit,
//                               title: 'edit_profile'.tr,
//                               onTap: () {
//                                 Get.toNamed(
//                                     RouteHelper.getUpdateProfileRoute());
//                               }),
//                           SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text('${'version'.tr}:',
//                                     style: robotoRegular.copyWith(
//                                         fontSize:
//                                             Dimensions.fontSizeExtraSmall)),
//                                 SizedBox(
//                                     width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                                 Text(AppConstants.APP_VERSION.toString(),
//                                     style: robotoMedium.copyWith(
//                                         fontSize:
//                                             Dimensions.fontSizeExtraSmall)),
//                               ]),
//                         ]),
//                       )),
//                     )),
//               );
//       }),
//     );
//   }
// }

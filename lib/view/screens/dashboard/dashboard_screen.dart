import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/screens/cart/cart_screen.dart';
import 'package:sixam_mart/view/screens/favourite/favourite_screen.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';
import 'package:sixam_mart/view/screens/menu/new_menu_screen.dart';
import 'package:sixam_mart/view/screens/order/order_screen.dart';
import 'package:sixam_mart/widgets/curved_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      FavouriteScreen(),
      CartScreen(fromNav: true),
      OrderScreen(),
      // Container(),
      NewMenuScreen()
    ];

    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    print('Page Index -- $_pageIndex');
    List<Icon> _naviagtionIcons = [
      Icon(
        Icons.home,
        color: _pageIndex == 0 ? Colors.white : Colors.black,
      ),
      Icon(Icons.favorite_rounded,
          color: _pageIndex == 1 ? Colors.white : Colors.black),
      Icon(Icons.shopping_cart,
          color: _pageIndex == 2 ? Colors.white : Colors.black),
      Icon(Icons.shopping_bag,
          color: _pageIndex == 3 ? Colors.white : Colors.black),
      Icon(Icons.menu, color: _pageIndex == 4 ? Colors.white : Colors.black),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (!ResponsiveHelper.isDesktop(context) &&
              Get.find<SplashController>().module != null) {
            Get.find<SplashController>().setModule(null);
            return false;
          } else {
            if (_canExit) {
              return true;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('back_press_again_to_exit'.tr,
                    style: TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              ));
              _canExit = true;
              Timer(Duration(seconds: 2), () {
                _canExit = false;
              });
              return false;
            }
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        // floatingActionButton: ResponsiveHelper.isDesktop(context)
        //     ? null
        //     : FloatingActionButton(
        //         elevation: 5,
        //         backgroundColor: _pageIndex == 2
        //             ? Color(0xff171E30)
        //             //Theme.of(context).primaryColor
        //             : Theme.of(context).cardColor,
        //         onPressed: () {
        //           _setPage(2);
        //         },
        //         child: CartWidget(
        //             color: _pageIndex == 2
        //                 ? Colors.white

        //                 //Color(0xff171E30)
        //                 //Theme.of(context).cardColor
        //                 : Theme.of(context).disabledColor,
        //             size: 30),
        //       ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ResponsiveHelper.isDesktop(context)
            ? SizedBox()
            :
            // BottomAppBar(
            //     elevation: 5,
            //     notchMargin: 5,
            //     clipBehavior: Clip.antiAlias,
            //     shape: CircularNotchedRectangle(),

            Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: CurvedNavigationBar(
                    color: Colors.grey.shade200,
                    backgroundColor: Colors.transparent,
                    //buttonBackgroundColor: Colors.green.shade400,

                    // color: Colors.grey.shade200,
                    // //  backgroundColor: Colors.transparent,
                    // backgroundColor: Color(0xff171E30),
                    buttonBackgroundColor: Color(0xff171E30),
                    animationDuration: const Duration(milliseconds: 360),
                    height: 50,
                    items: _naviagtionIcons,
                    onTap: (index) async {
                      print('index -- $index');
                      _setPage(index);
                      // if (index == 4) {
                      //   await showModalBottomSheet<void>(
                      //     shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(20.0),
                      //         topRight: Radius.circular(20.0),
                      //       ),
                      //     ),
                      //     context: context,
                      //     builder: (context) => MenuScreen(),
                      //   );
                      // } else {
                      //   _setPage(index);
                      // }
                    }),
              ),

        // Padding(
        //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   child: Row(children: [
        //     BottomNavItem(iconData: Icons.home, isSelected: _pageIndex == 0, onTap: () => _setPage(0)),
        //     BottomNavItem(iconData: Icons.favorite, isSelected: _pageIndex == 1, onTap: () => _setPage(1)),
        //     Expanded(child: SizedBox()),
        //     BottomNavItem(iconData: Icons.shopping_bag, isSelected: _pageIndex == 3, onTap: () => _setPage(3)),
        //     BottomNavItem(iconData: Icons.menu, isSelected: _pageIndex == 4, onTap: () {
        //       Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
        //     }),
        //   ]),
        // ),

        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}

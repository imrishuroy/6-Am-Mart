import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/menu/menu_screen.dart';
import '/repositories/dashboard/dashboard_repository.dart';
import '/screens/home/cubit/home_cubit.dart';
import '/screens/home/home_screen.dart';
import '/config/shared_prefs.dart';
import 'widgets/curved_nav_bar.dart';

class DashBoardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  const DashBoardScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const DashBoardScreen(),
    );
  }

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late PageController _pageController;
  final List<Widget> _screens = [
    BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        dashBoardRepository: context.read<DashBoardRepository>(),
      )..load(),
      child: const HomeScreen(),
    ),
    Container(color: Colors.red, height: 400, width: 200.0),
    Container(color: Colors.red, height: 400, width: 200.0),
    Container(color: Colors.red, height: 400, width: 200.0),
    const SizedBox.shrink()
    //Container(color: Colors.red, height: 400, width: 200.0),
    // FavouriteScreen(),
    // CartScreen(fromNav: true),
    // OrderScreen(),
    // // ProfileScreen(),
    // ProfileScreen1()
  ];

  final List<Icon> _naviagtionIcons = const [
    Icon(Icons.home),
    Icon(Icons.favorite_rounded),
    Icon(Icons.shopping_cart),
    Icon(Icons.shopping_bag),
    Icon(Icons.menu),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    print('Token  ${SharedPrefs().token}');
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _screens.length,
        itemBuilder: (contex, index) {
          return _screens[index];
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        child: CurvedNavigationBar(
            color: Colors.grey.shade200,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.green.shade400,
            animationDuration: const Duration(milliseconds: 360),
            height: 60,
            items: _naviagtionIcons,
            onTap: (index) async {
              print('index -- $index');
              if (index == 4) {
                await showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  context: context,
                  builder: (context) => const MenuScreen(),
                );
              } else {
                _setPage(index);
              }
            }),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
    });
  }
}

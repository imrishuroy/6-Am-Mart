import 'package:flutter/material.dart';
import 'package:six_am_mart/screens/home/home_screen.dart';
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
  int _pageIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    Container(color: Colors.red, height: 400, width: 200.0),
    Container(color: Colors.red, height: 400, width: 200.0),
    Container(color: Colors.red, height: 400, width: 200.0),
    Container(color: Colors.red, height: 400, width: 200.0),
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
    Icon(Icons.person),
  ];

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    print('Token  ${SharedPrefs().token}');
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _screens.length,
        itemBuilder: (contex, index) {
          return _screens[index];
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.black),
        ),
        child: CurvedNavigationBar(
            color: Colors.grey.shade200,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.green.shade400,
            animationDuration: Duration(milliseconds: 360),
            height: 60,
            items: _naviagtionIcons,
            onTap: (index) {
              _setPage(index);
            }),
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

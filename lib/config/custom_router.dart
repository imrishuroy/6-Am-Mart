import 'package:flutter/material.dart';
import 'package:six_am_mart/screens/address/add_address_screen.dart';
import 'package:six_am_mart/screens/address/address_screen.dart';
import '/screens/parcel/task_details_screen.dart';
import '/screens/profile/profile_screen.dart';
import '/screens/item/item_details_screen.dart';
import '/screens/parcel/parcel_screen.dart';
import '/screens/store/screens/view_all_items.dart';
import '/screens/store/screens/store_items_screen.dart';
import '/screens/store/store_screen.dart';
import '/screens/dashboard/dashboard_screen.dart';
import '/screens/on-boarding/on_boarding_screen.dart';
import '/screens/sign-up/sign_up_screen.dart';
import '/screens/splash/splash_screen.dart';
import '/screens/sign-in/sign_in_screen.dart';
import '/config/auth_wrapper.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case SignInScreen.routeName:
        return SignInScreen.route();

      case DashBoardScreen.routeName:
        return DashBoardScreen.route();

      case SplashScreen.routeName:
        return SplashScreen.route();

      case SignUpScreen.routeName:
        return SignUpScreen.route();

      case OnBoardingScreen.routeName:
        return OnBoardingScreen.route();

      case StoreScreen.routeName:
        return StoreScreen.route(args: settings.arguments as StoreScreenArgs);

      case StoresItemsScreen.routeName:
        return StoresItemsScreen.route(
            args: settings.arguments as StoresItemsArgs);

      case ItemDetailsScreen.routeName:
        return ItemDetailsScreen.route(
            args: settings.arguments as ItemDetailsArgs);

      case ViewAllItems.routeName:
        return ViewAllItems.route(args: settings.arguments as ViewAllItemsArgs);

      case ParcelScreen.routeName:
        return ParcelScreen.route();

      case TaskDetailsScreen.routeName:
        return TaskDetailsScreen.route();

      case ProfileScreen.routeName:
        return ProfileScreen.route();

      case AddressScreen.routeName:
        return AddressScreen.route();

      case AddAddressScreen.routeName:
        return AddAddressScreen.route(
            args: settings.arguments as AddAddressArgs);

      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRouter(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:six_am_mart/screens/dashboard/dashboard_screen.dart';
import 'package:six_am_mart/screens/sign-up/sign_up_screen.dart';
import 'package:six_am_mart/screens/splash/splash_screen.dart';
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

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/blocs/bloc/app_config_bloc.dart';
import 'package:six_am_mart/screens/splash/splash_logo.dart';
import '/utils/images.dart';

import 'no_interner_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          final connectivityResult = snapshot.data;

          print('Connection result $connectivityResult');

          if (connectivityResult == ConnectivityResult.none) {
            return const NoInternetScreen(child: SplashScreen());
          }

          //context.read<AppConfigBloc>().add(LoadConfig());
          return const SplashLogo();
        },
      ),
    );
  }
}

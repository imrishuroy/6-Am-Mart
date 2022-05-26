import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/sign-in/sign_in_screen.dart';

import '/blocs/bloc/auth_bloc.dart';
import '/enums/enums.dart';
import '/repositories/auth/auth_repo.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/auth';

  const AuthWrapper({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = RepositoryProvider.of<AuthRepository>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          print('Auth State $state');
          if (state.status == AuthenticationStatus.authenticated) {
            print('This runs 4');
            Navigator.of(context).pushNamed(SignInScreen.routeName);
            //Navigator.of(context).pushNamed(NavScreen.routeName);
          } else if (state.status == AuthenticationStatus.unauthenticated) {
            if (await auth.isLoggedIn()) {
              print('This runs 2');
              Navigator.of(context).pushNamed(SignInScreen.routeName);
              //Navigator.of(context).pushNamed(NavScreen.routeName);
            } else {
              print('This runs 3');
              //Navigator.of(context).pushNamed(LoginScreen.routeName);
              Navigator.of(context).pushNamed(SignInScreen.routeName);
            }
          }
        },
        child: const Scaffold(
            backgroundColor: Colors.white, body: CircularProgressIndicator()),
      ),
    );
  }
}

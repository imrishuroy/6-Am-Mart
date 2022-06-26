import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/sign-in/sign_in_screen.dart';
import '/screens/dashboard/dashboard_screen.dart';
import '/enums/enums.dart';

class AuthWrapper extends StatefulWidget {
  static const String routeName = '/auth';

  const AuthWrapper({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthWrapper(),
    );
  }

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthStatusChanged());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  final auth = RepositoryProvider.of<AuthRepository>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          print('Auth State $state');
          if (state.status == AuthenticationStatus.authenticated) {
            print('This runs 4');
            Navigator.of(context).pushNamed(DashBoardScreen.routeName);
          } else if (state.status == AuthenticationStatus.unauthenticated) {
            Navigator.of(context).pushNamed(SignInScreen.routeName);
            // if (await auth.isLoggedIn()) {
            //   print('This runs 2');
            //   Navigator.of(context).pushNamed(DashBoardScreen.routeName);
            // } else {
            //   print('This runs 3');

            //   Navigator.of(context).pushNamed(SignInScreen.routeName);
            // }
          }
        },
        child: const Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

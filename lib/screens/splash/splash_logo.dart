import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/config/app_config_bloc.dart';
import '/widgets/loading_indicator.dart';

import '/config/auth_wrapper.dart';
import '/config/shared_prefs.dart';
import '/screens/on-boarding/on_boarding_screen.dart';
import '/utils/utils.dart';

class SplashLogo extends StatefulWidget {
  const SplashLogo({Key? key}) : super(key: key);

  @override
  State<SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> {
  @override
  void initState() {
    context.read<AppConfigBloc>().add(LoadConfig());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppConfigBloc, AppConfigState>(
      listener: (context, state) {
        if (state.status == AppConfigStatus.succuss) {
          if (SharedPrefs().showIntro) {
            Navigator.of(context).pushNamed(OnBoardingScreen.routeName);
          } else {
            Navigator.of(context).pushNamed(AuthWrapper.routeName);
          }
        }
      },
      builder: (context, state) {
        print('App config state $state');
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Images.logo, width: 200),
              if (state.status == AppConfigStatus.loading)
                const LoadingIndicator()
            ],
          ),
        );
      },
    );
  }
}

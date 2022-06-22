import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/translations/codegen_loader.g.dart';
import '/repositories/parcel/parcel_repository.dart';
import '/repositories/location/location_repository.dart';
import '/repositories/store/store_repository.dart';
import '/config/auth_wrapper.dart';
import '/screens/on-boarding/on_boarding_screen.dart';
import '/theme/light_theme.dart';
import '/config/custom_router.dart';
import '/repositories/dashboard/dashboard_repository.dart';
import '/repositories/user/user_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/simple_bloc_observer.dart';
import 'config/shared_prefs.dart';
import 'repositories/auth/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (kIsWeb) {
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: 'AIzaSyAog5tvJGNb63Hjbe6TpPVPW_Qp_D9iKRs',
    //     appId: '1:526121573343:web:b0caef970924f065c6c26a',
    //     messagingSenderId: '526121573343',
    //     projectId: 'viewyourstories-4bf4d',
    //     storageBucket: 'viewyourstories-4bf4d.appspot.com',
    //   ),
    // );
  } else {
    await Firebase.initializeApp();
  }

  await SharedPrefs().init();
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());

  runApp(
    EasyLocalization(
      supportedLocales: const [
        // Locale('en', 'US'),
        // Locale('ar', 'DZ'),
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('en'),
      //path: 'resources/langs',
      path: 'assets/translations',
      // assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Onboarding  ${SharedPrefs().showIntro}');
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(

          /// systemNavigationBarColor: Colors.blue, // navigation bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark // status bar color
          ),
    );
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<DashBoardRepository>(
          create: (_) => DashBoardRepository(),
        ),
        RepositoryProvider<StoreRepository>(
          create: (_) => StoreRepository(),
        ),
        RepositoryProvider<LocationRepository>(
          create: (_) => LocationRepository(),
        ),
        RepositoryProvider<ParcelRepository>(
          create: (_) => ParcelRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          //showPerformanceOverlay: true,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: light(),
          debugShowCheckedModeBanner: false,

          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: SharedPrefs().showIntro
              ? OnBoardingScreen.routeName
              : AuthWrapper.routeName,
          // initialRoute: StoreScreen.routeName,
        ),
      ),
    );
  }
}

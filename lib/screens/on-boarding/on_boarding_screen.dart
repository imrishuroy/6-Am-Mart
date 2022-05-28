import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/auth_wrapper.dart';
import '/config/shared_prefs.dart';
import '/widgets/custom_button.dart';
import '/helpers/dimensions.dart';
import '/screens/on-boarding/cubit/on_boarding_cubit.dart';
import '/utils/images.dart';
import '/utils/styles.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/onBoarding';
  const OnBoardingScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: const OnBoardingScreen(),
      ),
    );
  }

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  final _onBoardingImages = [
    Images.onboard_1,
    Images.onboard_2,
    Images.onboard_3,
  ];

  final _onBoardingTitle = [
    'Get Favorite Items',
    'Easy Payment',
    'Fast Delivery'
  ];

  final _onBoardingDescription = [
    'Select your location to see the wide range stores and order your desired item',
    'Order item with COD payment or pay by safer and faster payment gateway',
    'Hundreds of delivery man are waiting for your order. SO place your order and get the item delivered to your doorstep!',
  ];

  List<Widget> _pageIndicators(int selectedIndex, BuildContext context) {
    List<Container> indicators = [];

    for (int i = 0; i < 3; i++) {
      indicators.add(
        Container(
          width: 7,
          height: 7,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == selectedIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
            borderRadius: i == selectedIndex
                ? BorderRadius.circular(50)
                : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return indicators;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        context.read<OnBoardingCubit>().changePage(index);
                      },
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.height * 0.05),
                              child: Image.asset(
                                _onBoardingImages[index],
                                height: size.height * 0.4,
                              ),
                            ),
                            Text(
                              _onBoardingTitle[index],
                              style: robotoMedium.copyWith(
                                  fontSize: size.height * 0.022),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: size.height * 0.025),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeLarge),
                              child: Text(
                                _onBoardingDescription[index],
                                style: robotoRegular.copyWith(
                                    fontSize: size.height * 0.015,
                                    color: Theme.of(context).disabledColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _pageIndicators(state.selectedIndex, context),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Padding(
                    padding: const EdgeInsets.all(
                      Dimensions.paddingSizeSmall,
                    ),
                    child: Row(
                      children: [
                        state.selectedIndex == 2
                            ? const SizedBox()
                            : Expanded(
                                child: CustomButton(
                                    transparent: true,
                                    onPressed: () async {
                                      final sharedPefs = SharedPrefs();
                                      await sharedPefs.disableIntro().then(
                                          (value) => Navigator.of(context)
                                              .pushReplacementNamed(
                                                  AuthWrapper.routeName));

                                      // Get.find<SplashController>().disableIntro();
                                      // Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.onBoarding));
                                    },
                                    buttonText: 'Skip'),
                              ),
                        Expanded(
                          child: CustomButton(
                            buttonText: state.selectedIndex != 2
                                ? 'Next'
                                : 'Get Started',
                            onPressed: () async {
                              if (state.selectedIndex != 2) {
                                _pageController.nextPage(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.ease);
                              } else {
                                final sharedPefs = SharedPrefs();
                                await sharedPefs.disableIntro().then((value) =>
                                    Navigator.of(context).pushReplacementNamed(
                                        AuthWrapper.routeName));
                                // Get.find<SplashController>().disableIntro();
                                // Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.onBoarding));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

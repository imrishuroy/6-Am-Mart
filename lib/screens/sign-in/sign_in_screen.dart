import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/repositories/auth/auth_repo.dart';
import 'package:six_am_mart/screens/dashboard/dashboard_screen.dart';
import 'package:six_am_mart/screens/sign-in/cubit/sign_in_cubit.dart';
import '/widgets/custom_text_field.dart';
import 'widgets/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/login';
  const SignInScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<SignInCubit>(
          create: (context) =>
              SignInCubit(authRepository: context.read<AuthRepository>()),
          child: const SignInScreen()),
    );
  }

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 240, 1),
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.05),
                    child: Image(
                      image: const AssetImage('assets/image/image9.png'),
                      height: size.height * 0.42,
                      width: size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 22,
                    margin: EdgeInsets.only(
                        top: size.height * 0.075, right: 16, left: 30),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'WEBKOON',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: -1,
                              color: Color.fromRGBO(0, 0, 0, 1)),
                        ),
                        InkWell(
                          onTap: () {
                            //Get.toNamed("/sign-up");
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              letterSpacing: -1,
                              color: Color.fromRGBO(69, 165, 36, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.only(
                          top: size.height * 0.022,
                          left: size.width * 0.0725,
                          right: size.width * 0.0725,
                          bottom: size.height * 0.03),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.023),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                    letterSpacing: -2,
                                    color: Color.fromRGBO(0, 0, 0, 1)),
                              ),
                            ),
                            CustomTextField(
                              title: 'Phone',
                              type: TextInputType.phone,
                              onChange: context
                                  .read<SignInCubit>()
                                  .phoneNumberChanged,
                              validator: (value) {
                                if (value!.length < 10) {
                                  return 'Invalid phone number';
                                }
                                return null;
                              },
                              defaultValue: '',
                              hintText: '+9191919191',
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              height: 1.0,
                            ),
                            CustomTextField(
                              title: 'Password',
                              type: TextInputType.visiblePassword,
                              onChange:
                                  context.read<SignInCubit>().passwordChanged,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password to short';
                                }
                                return null;
                              },
                              textAlignVerticle: true,
                              isPassowrdField: !state.showPassword,
                              defaultValue: '',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<SignInCubit>()
                                      .showPassword(state.showPassword);
                                },
                                icon: Icon(
                                  state.showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                  size: 20.0,
                                ),
                              ),
                              hintText: ' * * * * * * * * * ',
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  bottom: size.width * 0.046),
                              child: TextButton(
                                onPressed: () {},
                                ///// => Get.toNamed("/forgotPassword"),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        const EdgeInsets.all(0))),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      child: const Icon(
                                        Icons.password,
                                        color: Color.fromRGBO(69, 165, 36, 1),
                                        size: 20,
                                      ),
                                    ),
                                    const Text(
                                      'Forgot password',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: -0.5,
                                        color: Color.fromRGBO(69, 165, 36, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            state.status == SignInStatus.submitting
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SignButton(
                                        title: 'Sign In',
                                        loading: false,
                                        onClick: () async {
                                          print('Phone ${state.phoneNumber}');
                                          print('Passeor ${state.password}');
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<SignInCubit>()
                                                .signInWithPhoneNo();

                                            Navigator.of(context).pushNamed(
                                                DashBoardScreen.routeName);
                                          }

                                          // ResponseModel responseModel =
                                          //     await authController.login(
                                          //         phone, password);

                                          // if (responseModel.isSuccess) {
                                          //   Get.offAllNamed('/');
                                          // }

                                          // if (!responseModel.isSuccess) {
                                          //   setState(() {
                                          //     phone = '';
                                          //     password = '';
                                          //   });
                                          //   passwordController.text = '';
                                          //   Get.snackbar('Failed to signin',
                                          //       responseModel.message,
                                          //       snackPosition: SnackPosition.BOTTOM,
                                          //       backgroundColor: Colors.red.shade400,
                                          //       colorText: Colors.white);
                                          //}
                                        },
                                      ),
                                    ],
                                  ),
                            Container(
                              width: size.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: size.height * 0.02),
                              child: TextButton(
                                onPressed: () {},
                                // Get.offAllNamed(RouteHelper.getInitialRoute()),
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    const EdgeInsets.all(0),
                                  ),
                                ),
                                child: const Text(
                                  'Sign in as Guest',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.5,
                                    color: Color.fromRGBO(136, 136, 126, 1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

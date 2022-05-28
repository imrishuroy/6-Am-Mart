import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/widgets/show_snakbar.dart';
import '/repositories/auth/auth_repo.dart';
import '/screens/dashboard/dashboard_screen.dart';
import '/screens/sign-up/cubit/sign_up_cubit.dart';
import '/widgets/custom_text_field.dart';
import 'widgets/sign_up_button.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signUp';
  const SignUpScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: const SignUpScreen(),
      ),
    );
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.status == SignUpStatus.error) {
            ShowSnackBar.showSnackBar(context, title: state.failure.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: 22,
                    margin: EdgeInsets.only(
                        top: size.height * 0.075, right: 16, left: 30),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'WEBKOON',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: -1,
                              color: Color.fromRGBO(0, 0, 0, 1)),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              letterSpacing: -1,
                              color: Color.fromRGBO(69, 165, 36, 1),
                            ),
                          ),
                        ),
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
                          bottom: size.height * 0.08),
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
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                                letterSpacing: -2,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                            CustomTextField(
                              title: 'First Name',
                              type: TextInputType.name,
                              onChange:
                                  context.read<SignUpCubit>().fNameChanged,
                              validator: (value) {
                                if (value!.length < 3) {
                                  return 'First Name too short';
                                }
                                return null;
                              },
                              defaultValue: '',
                              hintText: 'John',
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              height: 1.0,
                            ),
                            CustomTextField(
                              title: 'Last Name ',
                              type: TextInputType.name,
                              onChange:
                                  context.read<SignUpCubit>().lNameChanged,
                              validator: (value) {
                                if (value!.length < 3) {
                                  return 'Last Name too short';
                                }
                                return null;
                              },
                              defaultValue: '',
                              hintText: 'Doe',
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              height: 1.0,
                            ),
                            CustomTextField(
                              title: 'E-mail',
                              type: TextInputType.emailAddress,
                              onChange:
                                  context.read<SignUpCubit>().emailChanged,
                              validator: (value) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!)) {
                                  return null;
                                }
                                return 'Invalid email';
                              },
                              defaultValue: '',
                              hintText: 'john@gmail.com',
                            ),
                            const Divider(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              height: 1.0,
                            ),
                            CustomTextField(
                              title: 'Phone',
                              type: TextInputType.phone,
                              onChange:
                                  context.read<SignUpCubit>().phoneChanged,
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
                                  context.read<SignUpCubit>().passwordChanged,
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
                                      .read<SignUpCubit>()
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
                            SizedBox(height: size.height * 0.045),
                            state.status == SignUpStatus.submitting
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SignUpButton(
                                        title: 'Sign Up',
                                        onClick: () async {
                                          print('Phone ${state.phoneNumber}');
                                          print('Passeor ${state.password}');
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<SignUpCubit>()
                                                .signUp();

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

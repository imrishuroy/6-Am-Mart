import 'package:flutter/material.dart';
import '/widgets/custom_text_field.dart';
import '/widgets/password_text_field.dart';
import 'widgets/sign_in_button.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/login';
  const SignInScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 240, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          width: _size.width,
          height: _size.height,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: _size.height * 0.05),
                child: Image(
                  image: const AssetImage("assets/image/image9.png"),
                  height: _size.height * 0.42,
                  width: _size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                width: _size.width,
                height: 22,
                margin: EdgeInsets.only(
                    top: _size.height * 0.075, right: 16, left: 30),
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
                  width: _size.width,
                  padding: EdgeInsets.only(
                      top: _size.height * 0.022,
                      left: _size.width * 0.0725,
                      right: _size.width * 0.0725,
                      bottom: _size.height * 0.03),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: _size.height * 0.023),
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
                        onChange: (value) {
                          // print(value);
                          // phone = value;
                        },
                        defaultValue: '',
                        placeholder: '+9191919191',
                      ),
                      const Divider(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        height: 1.0,
                      ),
                      PasswordInput(
                        title: 'Password',
                        isPassword: true,
                        onChange: (value) {},
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: _size.height * 0.01,
                            bottom: _size.width * 0.046),
                        child: TextButton(
                          onPressed: () {},
                          ///// => Get.toNamed("/forgotPassword"),
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SignButton(
                            title: 'Sign In',
                            loading: false,
                            onClick: () async {
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
                        width: _size.width,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: _size.height * 0.02),
                        child: TextButton(
                          onPressed: () {},
                          // Get.offAllNamed(RouteHelper.getInitialRoute()),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
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
            ],
          ),
        ),
      ),
    );
  }
}

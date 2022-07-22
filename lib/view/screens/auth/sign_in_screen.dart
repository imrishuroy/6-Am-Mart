import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sixam_mart/view/screens/auth/widget/auth_button.dart';
import 'package:sixam_mart/widgets/loading_indicator.dart';

import '/controller/auth_controller.dart';
import '/controller/localization_controller.dart';
import '/controller/splash_controller.dart';
import '/helper/responsive_helper.dart';
import '/helper/route_helper.dart';
import '/util/dimensions.dart';
import '/util/images.dart';
import '/util/styles.dart';
import '/view/base/custom_snackbar.dart';
import '/view/base/custom_text_field.dart';
import '/view/base/menu_drawer.dart';
import '/view/base/web_menu_bar.dart';
import '/view/screens/auth/widget/code_picker_widget.dart';
import '/view/screens/auth/widget/condition_check_box.dart';
import 'widget/guest_button.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  SignInScreen({@required this.exitFromApp});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _countryDialCode;
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _countryDialCode =
        Get.find<AuthController>().getUserCountryCode().isNotEmpty
            ? Get.find<AuthController>().getUserCountryCode()
            : CountryCode.fromCountryCode(
                    Get.find<SplashController>().configModel.country)
                .dialCode;
    _phoneController.text = Get.find<AuthController>().getUserNumber() ?? '';
    _passwordController.text =
        Get.find<AuthController>().getUserPassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context)
            ? WebMenuBar()
            : !widget.exitFromApp
                ? AppBar(
                    leading: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back_ios_rounded,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent)
                : null,
        endDrawer: MenuDrawer(),
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return ListView(
              children: [
                Container(
                  width: size.width,
                  height: 24,
                  margin: EdgeInsets.only(
                    right: 16,
                    left: 30,
                    top: size.height * 0.035,
                  ),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'WEBKOON',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: -1,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(RouteHelper.getSignUpRoute()),
                        child: Text(
                          'sign_up'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: -1,
                            color: Color.fromRGBO(69, 165, 36, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// SizedBox(height: 5.0),
                Container(
                  // margin: EdgeInsets.only(top: size.height * 0.05),
                  child: Image(
                    image: const AssetImage('assets/image/image9.png'),
                    height: size.height * 0.30,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: size.height * 0.58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      topRight:
                          Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_LARGE),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          child: Text(
                            'sign_in'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              letterSpacing: -2,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                        Row(
                          children: [
                            CodePickerWidget(
                              onChanged: (CountryCode countryCode) {
                                _countryDialCode = countryCode.dialCode;
                              },
                              initialSelection: _countryDialCode != null
                                  ? CountryCode.fromCountryCode(
                                          Get.find<SplashController>()
                                              .configModel
                                              .country)
                                      .code
                                  : Get.find<LocalizationController>()
                                      .locale
                                      .countryCode,
                              favorite: [
                                CountryCode.fromCountryCode(
                                        Get.find<SplashController>()
                                            .configModel
                                            .country)
                                    .code
                              ],
                              showDropDownButton: true,
                              padding: EdgeInsets.zero,
                              showFlagMain: true,
                              flagWidth: 30,
                              dialogBackgroundColor:
                                  Theme.of(context).cardColor,
                              textStyle: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomTextField(
                                hintText: 'phone'.tr,
                                controller: _phoneController,
                                focusNode: _phoneFocus,
                                nextFocus: _passwordFocus,
                                inputType: TextInputType.phone,
                                divider: false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Divider(height: 1),
                        SizedBox(height: 10.0),
                        CustomTextField(
                          hintText: 'password'.tr,
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Images.lock,
                          isPassword: true,
                          onSubmit: (text) =>
                              (GetPlatform.isWeb && authController.acceptTerms)
                                  ? _login(authController, _countryDialCode)
                                  : null,
                        ),
                        const SizedBox(height: 10.0),
                        Divider(height: 1),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                onTap: () => authController.toggleRememberMe(),
                                leading: Checkbox(
                                  activeColor: Theme.of(context).primaryColor,
                                  value: authController.isActiveRememberMe,
                                  onChanged: (bool isChecked) =>
                                      authController.toggleRememberMe(),
                                ),
                                title: Text('remember_me'.tr),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                horizontalTitleGap: 0,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(
                                  RouteHelper.getForgotPassRoute(false, null)),
                              child: Text('${'forgot_password'.tr}?'),
                            ),
                          ],
                        ),
                        ConditionCheckBox(authController: authController),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        !authController.isLoading
                            ? Center(
                                child: AuthButton(
                                  title: 'sign_in'.tr,
                                  onClick: () {
                                    if (authController.acceptTerms) {
                                      _login(authController, _countryDialCode);
                                    }
                                  },
                                ),
                              )
                            : LoadingIndicator(),
                        //  const SizedBox(height: 10.0),

                        Center(child: GuestButton()),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    //  SafeArea(
    //   child: FooterView(
    //       child: Center(
    //     child: Container(
    //       width: context.width > 700 ? 700 : context.width,
    //       // padding: context.width > 700
    //       // ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
    //       // : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    //       margin: context.width > 700
    //           ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
    //           : EdgeInsets.zero,
    //       decoration: context.width > 700
    //           ? BoxDecoration(
    //               color: Theme.of(context).cardColor,
    //               borderRadius:
    //                   BorderRadius.circular(Dimensions.RADIUS_SMALL),
    //               boxShadow: [
    //                 BoxShadow(
    //                     color: Colors.grey[Get.isDarkMode ? 700 : 300],
    //                     blurRadius: 5,
    //                     spreadRadius: 1)
    //               ],
    //             )
    //           : null,
    //       child:
    ///     ),
    // )),
    // ),
    // ),
    // );
  }

  void _login(AuthController authController, String countryDialCode) async {
    String _phone = _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    String _numberWithCountryCode = countryDialCode + _phone;
    bool _isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode =
            '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }
    if (_phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    } else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else {
      authController
          .login(_numberWithCountryCode, _password)
          .then((status) async {
        if (status.isSuccess) {
          if (authController.isActiveRememberMe) {
            authController.saveUserNumberAndPassword(
                _phone, _password, countryDialCode);
          } else {
            authController.clearUserNumberAndPassword();
          }
          String _token = status.message.substring(1, status.message.length);
          if (Get.find<SplashController>().configModel.customerVerification &&
              int.parse(status.message[0]) == 0) {
            List<int> _encoded = utf8.encode(_password);
            String _data = base64Encode(_encoded);
            Get.toNamed(RouteHelper.getVerificationRoute(
                _numberWithCountryCode, _token, RouteHelper.signUp, _data));
          } else {
            Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
          }
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}

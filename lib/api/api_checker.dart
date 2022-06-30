import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import '/blocs/wishlist/wishlist_cubit.dart';
import '/widgets/show_snakbar.dart';

class ApiChecker {
  static void checkApi(Response response, {required BuildContext context}) {
    if (response.statusCode == 401) {
      context.read<AuthBloc>();
      context.read<WishlistCubit>().removeWishes();
      // Navigator.of(context).pushNamed(SplashScreen.routeName);
      // Get.find<AuthController>().clearSharedData();
      // Get.find<WishListController>().removeWishes();
      // Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    } else {
      ShowSnackBar.showSnackBar(context, title: response.statusMessage);
      //showCustomSnackBar(response.statusText);
    }
  }
}

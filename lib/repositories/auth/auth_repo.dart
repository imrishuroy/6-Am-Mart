import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_am_mart/models/failure.dart';
import 'package:six_am_mart/api/dio_inceptor.dart';
import '/config/shared_prefs.dart';
import '/enums/auth_status.dart';
import '/config/urls.dart';
import '/repositories/auth/base_auth_repo.dart';

class AuthRepository extends BaseAuthRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  final _dio = Dio();

  // TODO: Work on this
  // experted from this https://blog.logrocket.com/networking-flutter-using-dio/

  // final _dio = Dio(
  //   BaseOptions(
  //     baseUrl: 'https://reqres.in/api',
  //     connectTimeout: 5000,
  //     receiveTimeout: 3000,
  //   ),
  // )..interceptors.add(Logging());

  Future<void> registerUser() async {}

  Future<bool> loginUser({
    required String? phoneNumber,
    required String? password,
  }) async {
    try {
      if (phoneNumber == null || password == null) {
        return false;
      }
      final prefs = SharedPrefs();
      final data = {'phone': phoneNumber, 'password': password};
      final response = await _dio.post(Urls.login, data: data);

      if (response.statusCode == 200) {
        final responseData = response.data as Map?;
        if (responseData != null) {
          final token = responseData['token'] as String?;

          if (token != null) {
            await prefs.setToken(token);
            return true;
          }
        }
      }
      print('response ${response.data}');
      return false;
    } on DioError catch (error) {
      print('Error in login ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in login ${error.toString()}');
      throw Failure(message: error.toString());
    }
  }

  Future<void> singUpUser({
    required String? phoneNumber,
    required String? password,
    required String? fName,
    required String? lName,
    required String? email,
    required String? phone,
  }) async {
    try {
      if (phoneNumber == null || password == null) {
        return;
      }
      final prefs = SharedPrefs();
      final data = {
        'f_name': fName,
        'l_name': lName,
        'phone': phoneNumber,
        'email': email,
        'password': password,
      };
      final response = await _dio.post(Urls.register, data: data);

      if (response.statusCode == 200) {
        final responseData = response.data as Map?;
        if (responseData != null) {
          final token = responseData['token'];

          if (token != null) {
            prefs.setToken(token);
          }
        }
      }

      print('response ${response.data}');
    } on DioError catch (error) {
      print('Error in login ${error.message}');
    } catch (error) {
      print('Error in login ${error.toString()}');
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('token')) {
      print('This runs 1');

      return true;
      //final user = await getUser(prefs.getString('token'));
      // if (user != null) {
      //   print('User $user');
      //   return true;
      // }
    }

    return false;
  }
}

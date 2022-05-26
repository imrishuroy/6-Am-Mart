import 'dart:async';

import 'package:dio/dio.dart';
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

  Future<void> registerUser() async {}

  Future<void> loginUser({
    required String? phoneNumber,
    required String? password,
  }) async {
    try {
      if (phoneNumber == null || password == null) {
        return;
      }
      final data = {'phone': phoneNumber, 'password': password};
      final response = await _dio.post(Urls.login, data: data);

      print('response ${response.data}');
    } on DioError catch (error) {
      print('Error in login ${error.message}');
    } catch (error) {
      print('Error in login ${error.toString()}');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:six_am_mart/repositories/auth/base_auth_repo.dart';

class AuthRepository extends BaseAuthRepository {
  final _dio = Dio();

  Future<void> registerUser() async {}
}

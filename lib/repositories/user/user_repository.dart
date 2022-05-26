import 'package:dio/dio.dart';

import '/models/failure.dart';
import '/models/user.dart';
import '/repositories/user/base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final _dio = Dio();

  Future<User?> getUserDetails() async {
    try {
      return null;
      //_dio.get(Urls.customerInfo, );
    } on DioError catch (error) {
      print('Error getting user details ${error.message}');
      throw const Failure(message: 'Error getting user');
    } catch (error) {
      print('Error getting user details ${error.toString()}');
      throw const Failure(message: 'Error getting user');
    }
  }
}

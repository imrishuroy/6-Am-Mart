import 'package:dio/dio.dart';
import 'package:six_am_mart/models/user.dart';
import '/config/shared_prefs.dart';
import '/config/urls.dart';
import '/models/failure.dart';
import '/repositories/user/base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final _dio = Dio();

  // Future<User?> getUserDetails() async {
  Future<User?> getUserDetails() async {
    try {
      final data = {
        'Authorization': 'Bearer ${SharedPrefs().token}',
        'moduleId': '1'
      };
      final response =
          await _dio.get(Urls.customerInfo, options: Options(headers: data));
      print('User response - ${response.data}');
      if (response.data != null) {
        return User.fromMap(response.data);
      }
      return null;

      // return response.statusCode == 200;
      //return null;
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

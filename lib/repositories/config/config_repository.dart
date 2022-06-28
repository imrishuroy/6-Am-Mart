import 'package:dio/dio.dart';
import 'package:six_am_mart/api/api.dart';
import 'package:six_am_mart/config/urls.dart';
import 'package:six_am_mart/models/config-model/config_model.dart';
import 'package:six_am_mart/models/failure.dart';
import 'package:six_am_mart/repositories/config/base_config_repo.dart';

class ConfigRepository extends BaseConfigRepository {
  @override
  Future<ConfigModel?> getConfigData() async {
    try {
      final response = await Api.createDio().get(Urls.config);
      print('Config response ${response.data}');
      if (response.statusCode == 200) {
        return ConfigModel.fromMap(response.data);
      }
      return null;
    } on DioError catch (error) {
      print('Error getting config data ${error.toString()}');
      throw const Failure(message: 'Error in getting config data');
    }
  }
}

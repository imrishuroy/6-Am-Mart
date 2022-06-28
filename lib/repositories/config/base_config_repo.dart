import '/models/config-model/config_model.dart';

abstract class BaseConfigRepository {
  Future<ConfigModel?> getConfigData();
}

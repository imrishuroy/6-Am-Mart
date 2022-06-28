import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/failure.dart';
import '/repositories/config/config_repository.dart';
import '/models/config-model/config_model.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  final ConfigRepository _configRepository;
  AppConfigBloc({required ConfigRepository configRepository})
      : _configRepository = configRepository,
        super(AppConfigInitial()) {
    on<LoadConfig>((event, emit) async {
      try {
        emit(AppConfigLoading());

        final config = await _configRepository.getConfigData();
        print('Config bloc --- $config');
        if (config != null) {
          emit(AppConfigSuccuss(config));
        } else {
          emit(const AppConfigError(
              Failure(message: 'Error in getting config')));
        }
      } on Failure catch (failure) {
        emit(AppConfigError(failure));
      }
    });
  }
}

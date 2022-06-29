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
        super(AppConfigState.initial()) {
    on<LoadConfig>((event, emit) async {
      try {
        emit(state.copyWith(status: AppConfigStatus.loading));

        final config = await _configRepository.getConfigData();
        print('Config bloc --- $config');
        if (config != null) {
          emit(state.copyWith(status: AppConfigStatus.succuss, config: config));
        } else {
          emit(
            state.copyWith(
                failure: const Failure(message: 'Error in getting config'),
                status: AppConfigStatus.error),
          );
        }
      } on Failure catch (failure) {
        emit(state.copyWith(failure: failure, status: AppConfigStatus.error));
      }
    });
  }
}

part of 'app_config_bloc.dart';

class AppConfigState extends Equatable {
  const AppConfigState();

  @override
  List<Object> get props => [];
}

class AppConfigInitial extends AppConfigState {}

class AppConfigLoading extends AppConfigState {}

class AppConfigSuccuss extends AppConfigState {
  final ConfigModel config;

  const AppConfigSuccuss(this.config);

  @override
  List<Object> get props => [config];
}

class AppConfigError extends AppConfigState {
  final Failure failure;

  const AppConfigError(this.failure);

  @override
  List<Object> get props => [failure];
}

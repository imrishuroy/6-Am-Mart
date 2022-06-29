part of 'app_config_bloc.dart';

enum AppConfigStatus { initial, loading, succuss, error }

class AppConfigState extends Equatable {
  final ConfigModel? config;
  final AppConfigStatus status;
  final Failure failure;

  const AppConfigState({
    this.config,
    required this.status,
    required this.failure,
  });

  factory AppConfigState.initial() =>
      const AppConfigState(status: AppConfigStatus.initial, failure: Failure());

  AppConfigState copyWith({
    ConfigModel? config,
    AppConfigStatus? status,
    Failure? failure,
  }) {
    return AppConfigState(
      config: config ?? this.config,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [config, status, failure];
}

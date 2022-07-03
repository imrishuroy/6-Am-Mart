part of 'app_config_bloc.dart';

abstract class AppConfigEvent extends Equatable {
  const AppConfigEvent();

  @override
  List<Object> get props => [];
}

class LoadConfig extends AppConfigEvent {}

class SetFirstTimeConfigCheck extends AppConfigEvent {
  final bool isChecked;

  const SetFirstTimeConfigCheck({required this.isChecked});

  @override
  List<Object> get props => [isChecked];
}

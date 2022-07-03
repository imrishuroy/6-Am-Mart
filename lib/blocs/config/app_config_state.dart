// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_config_bloc.dart';

enum AppConfigStatus { initial, loading, succuss, error }

class AppConfigState extends Equatable {
  final ConfigModel? configModel;
  final AppConfigStatus status;
  final bool firstTimeConnectionCheck;
  final Failure failure;
  final bool hasConnection;
  final ModuleModel? module;
  final List<ModuleModel> moduleList;
  final int moduleIndex;
  final Map<String, dynamic> data;
  final String? htmlText;
  final bool isLoading;

  const AppConfigState({
    this.configModel,
    required this.status,
    required this.failure,
    this.hasConnection = true,
    this.firstTimeConnectionCheck = true,
    this.module,
    this.moduleList = const [],
    this.moduleIndex = 0,
    this.data = const {},
    this.htmlText,
    this.isLoading = false,
  });

  factory AppConfigState.initial() => const AppConfigState(
        status: AppConfigStatus.initial,
        failure: Failure(),
        moduleList: [],
        data: {},
        hasConnection: true,
        isLoading: false,
        moduleIndex: 0,
        firstTimeConnectionCheck: true,
      );

  // AppConfigState copyWith({
  //   ConfigModel? configModel,
  //   AppConfigStatus? status,
  //   Failure? failure,
  // }) {
  //   return AppConfigState(
  //     configModel: configModel ?? this.configModel,
  //     status: status ?? this.status,
  //     failure: failure ?? this.failure,
  //   );
  // }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        configModel,
        status,
        failure,
        hasConnection,
        module,
        moduleList,
        moduleIndex,
        data,
        htmlText,
        isLoading,
      ];

  AppConfigState copyWith({
    ConfigModel? configModel,
    AppConfigStatus? status,
    bool? firstTimeConnectionCheck,
    Failure? failure,
    bool? hasConnection,
    ModuleModel? module,
    List<ModuleModel>? moduleList,
    int? moduleIndex,
    Map<String, dynamic>? data,
    String? htmlText,
    bool? isLoading,
  }) {
    return AppConfigState(
      configModel: configModel ?? this.configModel,
      status: status ?? this.status,
      firstTimeConnectionCheck:
          firstTimeConnectionCheck ?? this.firstTimeConnectionCheck,
      failure: failure ?? this.failure,
      hasConnection: hasConnection ?? this.hasConnection,
      module: module ?? this.module,
      moduleList: moduleList ?? this.moduleList,
      moduleIndex: moduleIndex ?? this.moduleIndex,
      data: data ?? this.data,
      htmlText: htmlText ?? this.htmlText,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

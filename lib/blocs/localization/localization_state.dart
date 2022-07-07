part of 'localization_cubit.dart';

enum LocalizationStatus { initial, loading, succuss, error }

class LocalizationState extends Equatable {
  final List<LanguageModel> languages;
  final bool isLtr;
  final Locale locale;
  final int selectedIndex;
  final LocalizationStatus status;
  final Failure failure;

  const LocalizationState({
    required this.languages,
    required this.isLtr,
    required this.locale,
    required this.selectedIndex,
    required this.status,
    required this.failure,
  });

  factory LocalizationState.initial() => LocalizationState(
        languages: const [],
        isLtr: true,
        locale: Locale(AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode),
        selectedIndex: 0,
        status: LocalizationStatus.initial,
        failure: const Failure(),
      );

  LocalizationState copyWith({
    List<LanguageModel>? languages,
    bool? isLtr,
    Locale? locale,
    int? selectedIndex,
    LocalizationStatus? status,
    Failure? failure,
  }) {
    return LocalizationState(
      languages: languages ?? this.languages,
      isLtr: isLtr ?? this.isLtr,
      locale: locale ?? this.locale,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      languages,
      isLtr,
      locale,
      selectedIndex,
      status,
      failure,
    ];
  }
}

part of 'on_boarding_cubit.dart';

enum OnBoardingStatus { initial, loading, succuss, error }

class OnBoardingState extends Equatable {
  final int selectedIndex;
  final OnBoardingStatus status;
  final Failure failure;

  const OnBoardingState({
    required this.selectedIndex,
    required this.status,
    required this.failure,
  });

  factory OnBoardingState.initial() => const OnBoardingState(
      selectedIndex: 0, status: OnBoardingStatus.initial, failure: Failure());

  @override
  List<Object> get props => [selectedIndex, status, failure];

  OnBoardingState copyWith({
    int? selectedIndex,
    OnBoardingStatus? status,
    Failure? failure,
  }) {
    return OnBoardingState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() =>
      'OnBoardingState(selectedIndex: $selectedIndex, status: $status, failure: $failure)';
}

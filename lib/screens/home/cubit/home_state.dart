part of 'home_cubit.dart';

enum HomeStatus { initial, loading, succuss, error }

class HomeState extends Equatable {
  final List<AppBanner?> banners;
  final Failure failure;
  final HomeStatus status;

  const HomeState({
    required this.banners,
    required this.failure,
    required this.status,
  });

  factory HomeState.initial() => const HomeState(
      banners: [], failure: Failure(), status: HomeStatus.initial);

  HomeState copyWith({
    List<AppBanner?>? banners,
    Failure? failure,
    HomeStatus? status,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [banners, failure, status];

  @override
  String toString() =>
      'DashboardState(banners: $banners, failure: $failure, status: $status)';
}

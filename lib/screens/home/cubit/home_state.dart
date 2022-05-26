part of 'home_cubit.dart';

enum HomeStatus { initial, loading, succuss, error }

class HomeState extends Equatable {
  final List<AppBanner?> banners;
  final List<AppCategory?> categories;
  final Failure failure;
  final HomeStatus status;

  const HomeState({
    required this.banners,
    required this.failure,
    required this.status,
    required this.categories,
  });

  factory HomeState.initial() => const HomeState(
        banners: [],
        failure: Failure(),
        status: HomeStatus.initial,
        categories: [],
      );

  HomeState copyWith({
    List<AppBanner?>? banners,
    List<AppCategory?>? categories,
    Failure? failure,
    HomeStatus? status,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [banners, categories, failure, status];

  @override
  String toString() =>
      'DashboardState(banners: $banners, categories: $categories, failure: $failure, status: $status)';
}

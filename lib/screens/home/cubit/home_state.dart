part of 'home_cubit.dart';

enum HomeStatus { initial, loading, succuss, error }

class HomeState extends Equatable {
  final List<AppBanner?> banners;
  final List<AppCategory?> categories;
  final List<Module?> modules;

  final Failure failure;
  final HomeStatus status;

  const HomeState({
    required this.banners,
    required this.failure,
    required this.status,
    required this.categories,
    required this.modules,
  });

  factory HomeState.initial() => const HomeState(
        banners: [],
        failure: Failure(),
        status: HomeStatus.initial,
        categories: [],
        modules: [],
      );

  HomeState copyWith({
    List<AppBanner?>? banners,
    List<AppCategory?>? categories,
    List<Module?>? modules,
    Failure? failure,
    HomeStatus? status,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      modules: modules ?? this.modules,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [banners, categories, modules, failure, status];

  @override
  String toString() =>
      'DashboardState(banners: $banners, categories: $categories, modules: $modules, failure: $failure, status: $status)';
}

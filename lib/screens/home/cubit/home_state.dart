part of 'home_cubit.dart';

enum HomeStatus { initial, loading, succuss, error }

class HomeState extends Equatable {
  final List<AppBanner?> banners;
  final List<AppCategory?> categories;
  final List<Module?> modules;

  final List<Store?> featuredStores;

  final Failure failure;
  final HomeStatus status;

  const HomeState({
    required this.banners,
    required this.failure,
    required this.status,
    required this.categories,
    required this.modules,
    required this.featuredStores,
  });

  factory HomeState.initial() => const HomeState(
        banners: [],
        failure: Failure(),
        status: HomeStatus.initial,
        categories: [],
        modules: [],
        featuredStores: [],
      );

  HomeState copyWith({
    List<AppBanner?>? banners,
    List<AppCategory?>? categories,
    List<Module?>? modules,
    Failure? failure,
    HomeStatus? status,
    List<Store?>? featuredStores,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      modules: modules ?? this.modules,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      featuredStores: featuredStores ?? this.featuredStores,
    );
  }

  @override
  List<Object> get props =>
      [banners, categories, modules, featuredStores, failure, status];

  @override
  String toString() =>
      'DashboardState(banners: $banners, categories: $categories, modules: $modules,featuredStores: $featuredStores, failure: $failure, status: $status)';
}

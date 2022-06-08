part of 'store_cubit.dart';

enum StoreStatus { initial, loading, succuss, error }

class StoreState extends Equatable {
  final List<AppBanner?> banners;
  final List<Store?> popularStores;
  final List<Store?> allStores;
  final Failure failure;
  final StoreStatus status;
  final List<AppCategory?> categories;
  final List<Item?> items;

  const StoreState({
    required this.banners,
    required this.failure,
    required this.status,
    required this.allStores,
    required this.popularStores,
    required this.categories,
    required this.items,
  });

  factory StoreState.initial() => const StoreState(
        banners: [],
        allStores: [],
        popularStores: [],
        failure: Failure(),
        status: StoreStatus.initial,
        categories: [],
        items: [],
      );

  @override
  List<Object> get props => [
        banners,
        failure,
        status,
        items,
        categories,
      ];

  StoreState copyWith({
    List<AppBanner?>? banners,
    List<Store?>? allStores,
    List<Store?>? popularStores,
    Failure? failure,
    StoreStatus? status,
    List<AppCategory?>? categories,
    List<Item?>? items,
  }) {
    return StoreState(
      banners: banners ?? this.banners,
      failure: failure ?? this.failure,
      allStores: allStores ?? this.allStores,
      popularStores: popularStores ?? this.popularStores,
      status: status ?? this.status,
      categories: categories ?? this.categories,
      items: items ?? this.items,
    );
  }

  @override
  String toString() =>
      'StoreState(banners: $banners, failure: $failure, status: $status, allStores: $allStores, popularStores: $popularStores, categories: $categories, items $items)';
}

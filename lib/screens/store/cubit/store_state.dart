part of 'store_cubit.dart';

enum StoreStatus { initial, loading, succuss, error }

class StoreState extends Equatable {
  final List<AppBanner?> banners;
  final List<Store?> popularStores;
  final List<Store?> allStores;
  final Failure failure;
  final StoreStatus status;

  const StoreState({
    required this.banners,
    required this.failure,
    required this.status,
    required this.allStores,
    required this.popularStores,
  });

  factory StoreState.initial() => const StoreState(
      banners: [],
      allStores: [],
      popularStores: [],
      failure: Failure(),
      status: StoreStatus.initial);

  @override
  List<Object> get props => [banners, failure, status];

  StoreState copyWith({
    List<AppBanner?>? banners,
    List<Store?>? allStores,
    List<Store?>? popularStores,
    Failure? failure,
    StoreStatus? status,
  }) {
    return StoreState(
      banners: banners ?? this.banners,
      failure: failure ?? this.failure,
      allStores: allStores ?? this.allStores,
      popularStores: popularStores ?? this.popularStores,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'StoreState(banners: $banners, failure: $failure, status: $status, allStores: $allStores, popularStores: $popularStores)';
}
